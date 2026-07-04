import { type FormEvent, useEffect, useState } from 'react'
import AuthShell from '../components/auth/AuthShell'
import { resetPassword } from '../components/auth/authApi'
import AuthTextField from '../components/auth/AuthTextField'

function ForgotPasswordPage() {
  const [email, setEmail] = useState('')
  const [verificationCode, setVerificationCode] = useState('')
  const [password, setPassword] = useState('')
  const [confirmPassword, setConfirmPassword] = useState('')
  const [isCodeSent, setIsCodeSent] = useState(false)
  const [isCodeVerified, setIsCodeVerified] = useState(false)
  const [isPasswordUpdated, setIsPasswordUpdated] = useState(false)
  const [isSubmitting, setIsSubmitting] = useState(false)
  const [redirectCountdown, setRedirectCountdown] = useState(3)
  const [message, setMessage] = useState('')
  const passwordsDoNotMatch = Boolean(confirmPassword) && password !== confirmPassword
  const canContinue = Boolean(email && verificationCode)
  const canUpdatePassword = isCodeVerified && Boolean(password && confirmPassword) && !passwordsDoNotMatch

  useEffect(() => {
    if (!isPasswordUpdated) {
      return undefined
    }

    if (redirectCountdown === 0) {
      window.location.href = '/sign-in'
      return undefined
    }

    const timer = window.setTimeout(() => {
      setRedirectCountdown((currentCountdown) => currentCountdown - 1)
    }, 1000)

    return () => window.clearTimeout(timer)
  }, [isPasswordUpdated, redirectCountdown])

  const handleSendCode = () => {
    if (!email) {
      setMessage('Please enter your email address first.')
      return
    }

    setIsCodeSent(true)
    setMessage('Verification code sent. Use any code to continue for now.')
  }

  const handleContinue = (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault()

    if (!canContinue) {
      setMessage('Please enter your email and verification code.')
      return
    }

    setIsCodeVerified(true)
    setMessage('')
  }

  const handleSubmit = async (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault()

    if (!password || !confirmPassword) {
      setMessage('Please enter and confirm your new password.')
      return
    }

    if (passwordsDoNotMatch) {
      setMessage('Passwords do not match.')
      return
    }

    setMessage('')
    setIsSubmitting(true)

    try {
      await resetPassword(email, password, verificationCode)
      setIsPasswordUpdated(true)
    } catch (error) {
      setMessage(error instanceof Error ? error.message : 'Unable to update your password.')
    } finally {
      setIsSubmitting(false)
    }
  }

  const goToSignIn = () => {
    window.location.href = '/sign-in'
  }

  return (
    <AuthShell
      eyebrow="Password help"
      subtitle="Enter your email, verify the code, and set a new password."
      title="Reset your account password."
    >
      {!isCodeVerified ? (
        <form className="grid gap-5" onSubmit={handleContinue}>
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
                  disabled={!email}
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
            Remembered it?{' '}
            <a className="font-bold text-blue-500 no-underline hover:text-blue-600" href="/sign-in">
              Back to sign in
            </a>
          </p>
        </form>
      ) : (
        <form className="grid gap-5" onSubmit={handleSubmit}>
          <AuthTextField
            autoComplete="new-password"
            label="New password"
            name="password"
            onChange={setPassword}
            placeholder="Set a new password"
            type="password"
            value={password}
          />
          <AuthTextField
            autoComplete="new-password"
            label="Confirm new password"
            name="confirmPassword"
            onChange={setConfirmPassword}
            placeholder="Enter the new password again"
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
            disabled={!canUpdatePassword || isSubmitting}
            type="submit"
          >
            {isSubmitting ? 'Updating Password...' : 'Update Password'}
          </button>
        </form>
      )}
      {isPasswordUpdated ? (
        <div
          aria-labelledby="password-updated-title"
          aria-modal="true"
          className="fixed inset-0 z-40 flex items-center justify-center bg-gray-900/40 px-6 backdrop-blur-sm"
          role="dialog"
        >
          <div className="w-full max-w-[440px] rounded-4xl bg-white p-8 text-center shadow-2xl shadow-gray-900/20">
            <p className="mb-3 text-xs font-extrabold tracking-[0.16em] text-blue-500 uppercase">
              Password updated
            </p>
            <h2 id="password-updated-title" className="font-outfit m-0 text-3xl font-extrabold text-gray-800">
              Your password has been updated.
            </h2>
            <p className="mt-4 mb-6 text-sm leading-6 text-gray-500">
              You can now sign in with your new password.
            </p>
            <button
              className="font-outfit h-13 w-full cursor-pointer rounded-4xl border-0 bg-blue-500 text-base font-extrabold text-white shadow-lg shadow-blue-200 transition hover:bg-blue-600"
              onClick={goToSignIn}
              type="button"
            >
              Back to Sign In ({redirectCountdown}s)
            </button>
          </div>
        </div>
      ) : null}
    </AuthShell>
  )
}

export default ForgotPasswordPage
