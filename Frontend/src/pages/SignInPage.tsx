import { type FormEvent, useState } from 'react'
import AuthShell from '../components/auth/AuthShell'
import AuthTextField from '../components/auth/AuthTextField'
import { signInSession } from '../components/auth/authSession'

function SignInPage() {
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')

  const handleSubmit = (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault()
    signInSession(email.split('@')[0] || 'Member', email || 'member@example.com')
    const params = new URLSearchParams(window.location.search)
    window.location.href = params.get('returnTo') || '/'
  }

  return (
    <AuthShell
      eyebrow="Welcome back"
      subtitle="Sign in to manage your exchanges, message owners, and keep your travel plans moving."
      title="Continue your next exchange."
    >
      <form className="grid gap-5" onSubmit={handleSubmit}>
        <AuthTextField
          autoComplete="email"
          label="Email"
          name="email"
          onChange={setEmail}
          placeholder="you@example.com"
          type="email"
          value={email}
        />
        <AuthTextField
          autoComplete="current-password"
          label="Password"
          name="password"
          onChange={setPassword}
          placeholder="Enter your password"
          type="password"
          value={password}
        />

        <div className="flex flex-wrap items-center justify-between gap-3 text-sm">
          <a className="font-bold text-blue-500 no-underline hover:text-blue-600" href="/forgot-password">
            Forgot password?
          </a>
          <span className="text-gray-400">
            New here?{' '}
            <a className="font-bold text-blue-500 no-underline hover:text-blue-600" href="/sign-up">
              Create an account
            </a>
          </span>
        </div>

        <button
          className="font-outfit mt-2 h-14 cursor-pointer rounded-4xl border-0 bg-blue-500 text-xl font-extrabold text-white shadow-lg shadow-blue-200 transition hover:bg-blue-600"
          type="submit"
        >
          Sign In
        </button>
      </form>
    </AuthShell>
  )
}

export default SignInPage
