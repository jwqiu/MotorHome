import { spawn } from 'node:child_process'

const serviceState = {
  backend: {
    ready: false,
    url: 'http://127.0.0.1:5080',
  },
  frontend: {
    ready: false,
    url: 'http://127.0.0.1:5173',
  },
}

let readyMessagePrinted = false
let readyMessageTimer
let browserOpened = false

const commands = [
  {
    name: 'backend',
    command: 'dotnet',
    args: ['run', '--project', 'Backend/MotorHome.Api.csproj', '--urls', 'http://127.0.0.1:5080'],
  },
  {
    name: 'frontend',
    command: 'npm',
    args: [
      '--prefix',
      'Frontend',
      'run',
      'dev',
      '--',
      '--host',
      '127.0.0.1',
      '--port',
      '5173',
      '--strictPort',
    ],
  },
]

const children = commands.map(({ name, command, args }) => {
  const child = spawn(command, args, {
    cwd: process.cwd(),
    stdio: ['inherit', 'pipe', 'pipe'],
    shell: process.platform === 'win32',
  })

  child.stdout.on('data', (data) => {
    const output = data.toString()
    process.stdout.write(`[${name}] ${output}`)
    handleOutput(name, output)
  })

  child.stderr.on('data', (data) => {
    const output = data.toString()
    process.stderr.write(`[${name}] ${output}`)
    handleOutput(name, output)
  })

  child.on('exit', (code, signal) => {
    if (code && code !== 0) {
      console.error(`[${name}] exited with code ${code}`)
      stopAll()
    }

    if (signal) {
      console.error(`[${name}] stopped by ${signal}`)
    }
  })

  return child
})

function handleOutput(name, output) {
  const backendUrl = output.match(/Now listening on:\s+(http:\/\/[^\s]+)/)
  const frontendUrl = output.match(/Local:\s+(http:\/\/[^\s]+)/)

  if (name === 'backend' && backendUrl) {
    serviceState.backend.url = backendUrl[1]
  }

  if (name === 'backend' && output.includes('Application started.')) {
    serviceState.backend.ready = true
  }

  if (name === 'frontend' && frontendUrl) {
    serviceState.frontend.ready = true
    serviceState.frontend.url = frontendUrl[1]
  }

  if (output.includes('address already in use') || output.includes('Port 5173 is already in use')) {
    printStartupError()
  }

  scheduleReadyMessage()
}

function printStartupError() {
  console.error(`
============================================================
STARTUP FAILED: one of the development ports is already in use.

Expected frontend: http://127.0.0.1:5173
Expected backend:  http://127.0.0.1:5080

Stop the existing process, then run:
npm run dev
============================================================
`)
}

function scheduleReadyMessage() {
  if (
    readyMessagePrinted ||
    !serviceState.backend.ready ||
    !serviceState.frontend.ready
  ) {
    return
  }

  clearTimeout(readyMessageTimer)
  readyMessageTimer = setTimeout(printReadyMessage, 200)
}

function printReadyMessage() {
  if (readyMessagePrinted) {
    return
  }

  readyMessagePrinted = true
  const frontendUrl = trimTrailingSlash(serviceState.frontend.url)
  const backendUrl = trimTrailingSlash(serviceState.backend.url)

  console.log(`
============================================================
READY: frontend and backend are running.

Frontend: ${frontendUrl}
Backend:  ${backendUrl}
API test: ${frontendUrl}/api/connection

Opening frontend in default browser...

Press Ctrl+C to stop both services.
============================================================
`)

  openFrontendInBrowser(frontendUrl)
}

function trimTrailingSlash(url) {
  return url.endsWith('/') ? url.slice(0, -1) : url
}

function openFrontendInBrowser(url) {
  if (browserOpened || process.platform !== 'darwin') {
    return
  }

  browserOpened = true
  const opener = spawn('open', [url], {
    stdio: 'ignore',
    detached: true,
  })

  opener.on('error', () => {
    console.error(`Could not open the browser automatically. Open this URL manually: ${url}`)
  })

  opener.unref()
}

function stopAll() {
  for (const child of children) {
    if (!child.killed) {
      child.kill()
    }
  }
}

process.on('SIGINT', () => {
  stopAll()
  process.exit(0)
})

process.on('SIGTERM', () => {
  stopAll()
  process.exit(0)
})
