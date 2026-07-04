import { type FormEvent, useState } from 'react'
import AuthShell from '../components/auth/AuthShell'
import { login } from '../components/auth/authApi'
import AuthTextField from '../components/auth/AuthTextField'
import { signInSession } from '../components/auth/authSession'

function SignInPage() {
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [message, setMessage] = useState('')
  const [isSubmitting, setIsSubmitting] = useState(false)

  const handleSubmit = async (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault()

    setMessage('')
    setIsSubmitting(true)

    try {
      const user = await login(email, password)
      signInSession(user.id, user.userName, user.email, user.identityVerified)
      const params = new URLSearchParams(window.location.search)
      window.location.href = params.get('returnTo') || '/'
    } catch (error) {
      setMessage(error instanceof Error ? error.message : 'Unable to sign in.')
    } finally {
      setIsSubmitting(false)
    }
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

        {message ? (
          <p className="m-0 rounded-3xl bg-red-50 px-4 py-3 text-sm font-bold text-red-500">
            {message}
          </p>
        ) : null}

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
          className="font-outfit mt-2 h-14 cursor-pointer rounded-4xl border-0 bg-blue-500 text-xl font-extrabold text-white shadow-lg shadow-blue-200 transition hover:bg-blue-600 disabled:cursor-not-allowed disabled:bg-gray-300 disabled:shadow-none"
          disabled={isSubmitting}
          type="submit"
        >
          {isSubmitting ? 'Signing In...' : 'Sign In'}
        </button>
      </form>
    </AuthShell>
  )
}

export default SignInPage
