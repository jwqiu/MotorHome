import type { ReactNode } from 'react'

type AuthShellProps = {
  children: ReactNode
  eyebrow: string
  subtitle: string
  title: string
}

function AuthShell({ children, eyebrow, subtitle, title }: AuthShellProps) {
  return (
    <main className="relative min-h-screen bg-blue-50 font-sans text-gray-600 antialiased">
      <a
        aria-label="MT Exchange home"
        className="font-outfit fixed top-8 left-6 z-20 text-xl font-bold text-gray-700 no-underline transition hover:text-blue-500 md:left-20 md:text-[26px]"
        href="/"
      >
        MT Exchange
      </a>

      <section className="grid min-h-screen place-items-center px-6 py-28 md:px-16 md:py-32">
        <div className="mx-auto grid max-w-[1120px] items-center gap-10 lg:grid-cols-[minmax(0,0.95fr)_minmax(420px,520px)]">
          <div className="max-w-[560px]">
            <p className="mb-3 text-sm font-extrabold tracking-[0.18em] text-blue-500 uppercase">
              {eyebrow}
            </p>
            <h1 className="font-outfit m-0 text-4xl leading-tight font-extrabold text-gray-800 md:text-5xl">
              {title}
            </h1>
            <p className="mt-5 mb-0 text-base leading-7 text-gray-500 md:text-lg">
              {subtitle}
            </p>
          </div>

          <div className="rounded-4xl bg-white p-7 shadow-lg shadow-blue-100 md:p-8">
            {children}
          </div>
        </div>
      </section>
    </main>
  )
}

export default AuthShell
