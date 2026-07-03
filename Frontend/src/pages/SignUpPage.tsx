import { type FormEvent, useState } from 'react'
import AuthShell from '../components/auth/AuthShell'
import AuthTextField from '../components/auth/AuthTextField'
import { signInSession } from '../components/auth/authSession'

function SignUpPage() {
  const [name, setName] = useState('')
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [confirmPassword, setConfirmPassword] = useState('')
  const [verificationCode, setVerificationCode] = useState('')
  const [isCodeSent, setIsCodeSent] = useState(false)
  const [isCodeVerified, setIsCodeVerified] = useState(false)
  const [message, setMessage] = useState('')
  const passwordsDoNotMatch = Boolean(confirmPassword) && password !== confirmPassword
  const canSendCode = Boolean(name && email)
  const canContinue = Boolean(name && email && verificationCode)
  const canCompleteRegistration = Boolean(password && confirmPassword) && !passwordsDoNotMatch

  const handleSendCode = () => {
    if (!canSendCode) {
      setMessage('Please enter your user name and email first.')
      return
    }

    setIsCodeSent(true)
    setMessage('Verification code sent. Use any code to continue for now.')
  }

  const handleContinue = (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault()

    if (!canSendCode) {
      setMessage('Please enter your user name and email first.')
      return
    }

    if (!verificationCode) {
      setMessage('Please enter your verification code.')
      return
    }

    setIsCodeVerified(true)
    setMessage('')
  }

  const handleSubmit = (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault()

    if (!password || !confirmPassword) {
      setMessage('Please create and confirm your password.')
      return
    }

    if (passwordsDoNotMatch) {
      setMessage('Passwords do not match.')
      return
    }

    signInSession()
    const params = new URLSearchParams(window.location.search)
    window.location.href = params.get('returnTo') || '/'
  }

  return (
    <AuthShell
      eyebrow="Join MT Exchange"
      subtitle="Create an account to save listings, request swaps, and start building your exchange profile."
      title="Start exchanging with trusted members."
    >
      {!isCodeVerified ? (
        <form className="grid gap-5" onSubmit={handleContinue}>
          <AuthTextField
            autoComplete="name"
            label="User name"
            name="name"
            onChange={setName}
            placeholder="Your display name"
            value={name}
          />
          <AuthTextField
            autoComplete="email"
            label="Email"
            name="email"
            onChange={setEmail}
            placeholder="you@example.com"
            type="email"
            value={email}
          />

          <div className="grid gap-2">
            <label className="grid gap-2 text-sm font-extrabold text-gray-700">
              Verification code
              <div className="grid gap-3 sm:grid-cols-[180px_1fr]">
                <button
                  className="h-13 cursor-pointer rounded-4xl border border-blue-100 bg-blue-50 px-4 text-sm font-extrabold text-blue-600 transition hover:bg-blue-100 disabled:cursor-not-allowed disabled:bg-gray-50 disabled:text-gray-300"
                  disabled={!canSendCode}
                  onClick={handleSendCode}
                  type="button"
                >
                  Send Code
                </button>
                <input
                  autoComplete="one-time-code"
                  className="h-13 min-w-0 rounded-4xl border border-blue-100 bg-white px-5 text-sm font-bold text-gray-700 outline-0 transition focus:border-blue-500 focus:ring-4 focus:ring-blue-100 disabled:bg-gray-50 disabled:text-gray-300"
                  disabled={!isCodeSent}
                  name="verificationCode"
                  onChange={(event) => setVerificationCode(event.target.value)}
                  placeholder="Enter code"
                  value={verificationCode}
                />
              </div>
            </label>
            {message ? (
              <p className="m-0 text-xs leading-5 text-gray-400">
                {message}
              </p>
            ) : null}
          </div>

          <button
            className="font-outfit mt-2 h-14 cursor-pointer rounded-4xl border-0 bg-blue-500 text-xl font-extrabold text-white shadow-lg shadow-blue-200 transition hover:bg-blue-600 disabled:cursor-not-allowed disabled:bg-gray-300 disabled:shadow-none"
            disabled={!canContinue}
            type="submit"
          >
            Continue
          </button>

          <p className="m-0 text-center text-sm text-gray-400">
            Already have an account?{' '}
            <a className="font-bold text-blue-500 no-underline hover:text-blue-600" href="/sign-in">
              Sign in
            </a>
          </p>
        </form>
      ) : (
        <form className="grid gap-5" onSubmit={handleSubmit}>
          <AuthTextField
            autoComplete="new-password"
            label="Password"
            name="password"
            onChange={setPassword}
            placeholder="Create a password"
            type="password"
            value={password}
          />
          <AuthTextField
            autoComplete="new-password"
            label="Confirm password"
            name="confirmPassword"
            onChange={setConfirmPassword}
            placeholder="Enter the password again"
            type="password"
            value={confirmPassword}
          />

          {passwordsDoNotMatch ? (
            <p className="m-0 rounded-3xl bg-red-50 px-4 py-3 text-sm font-bold text-red-500">
              Passwords do not match.
            </p>
          ) : null}

          {message ? (
            <p className="m-0 text-xs leading-5 text-gray-400">
              {message}
            </p>
          ) : null}

          <button
            className="font-outfit mt-2 h-14 cursor-pointer rounded-4xl border-0 bg-blue-500 text-xl font-extrabold text-white shadow-lg shadow-blue-200 transition hover:bg-blue-600 disabled:cursor-not-allowed disabled:bg-gray-300 disabled:shadow-none"
            disabled={!canCompleteRegistration}
            type="submit"
          >
            Complete Registration
          </button>
        </form>
      )}
    </AuthShell>
  )
}

export default SignUpPage
