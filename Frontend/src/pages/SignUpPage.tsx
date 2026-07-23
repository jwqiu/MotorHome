import { type FormEvent, useState } from 'react'
import AuthShell from '../components/auth/AuthShell'
import {sendSignUpCode, signUp, verifySignUpCode} from '../components/auth/authApi'
import AuthTextField from '../components/auth/AuthTextField'
import { signInSession } from '../components/auth/authSession'

function SignUpPage() {
  const [name, setName] = useState('')
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [confirmPassword, setConfirmPassword] = useState('')
  const [verificationCode, setVerificationCode] = useState('')
  const [isCodeSent, setIsCodeSent] = useState(false)
  const [isSendingCode, setIsSendingCode] = useState(false)
  const [isCodeVerified, setIsCodeVerified] = useState(false)
  const [isSubmitting, setIsSubmitting] = useState(false)
  const [message, setMessage] = useState('')
  const [isVerifyingCode, setIsVerifyingCode] = useState(false)
  const passwordsDoNotMatch = Boolean(confirmPassword) && password !== confirmPassword
  const canSendCode = Boolean(name && email)
  const canContinue = Boolean(name && email) && verificationCode.length === 6
  const canCompleteRegistration = Boolean(password && confirmPassword) && !passwordsDoNotMatch
  const verificationSuccessMessage = 'A verification code was sent to your email.'

  const handleSendCode = async () => {
    if (!canSendCode) {
      setMessage('Please enter your user name and email first.')
      return
    }

    setIsSendingCode(true)
    setMessage('')

    try {
      await sendSignUpCode(email)

      setIsCodeSent(true)
      setVerificationCode('')
      setMessage(verificationSuccessMessage)
    } catch (error) {
      setMessage(
        error instanceof Error
          ? error.message
          : 'Unable to send the verification code.',
      )
    } finally {
      setIsSendingCode(false)
    }
  }

  const handleContinue = async (
    event: FormEvent<HTMLFormElement>,
  ) => {
    event.preventDefault()

    if (!canSendCode) {
      setMessage('Please enter your user name and email first.')
      return
    }

    if (verificationCode.length !== 6) {
      setMessage('Please enter the six-digit verification code.')
      return
    }

    setIsVerifyingCode(true)
    setMessage('')

    try {
      await verifySignUpCode(email, verificationCode)

      setIsCodeVerified(true)
      setMessage('')
    } catch (error) {
      setMessage(
        error instanceof Error
          ? error.message
          : 'Unable to verify the code.',
      )
    } finally {
      setIsVerifyingCode(false)
    }
  }

  const handleSubmit = async (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault()

    if (!password || !confirmPassword) {
      setMessage('Please create and confirm your password.')
      return
    }

    if (passwordsDoNotMatch) {
      setMessage('Passwords do not match.')
      return
    }

    setMessage('')
    setIsSubmitting(true)

    try {
      const user = await signUp(name, email, password, verificationCode)
      signInSession(user.id, user.userName, user.email, user.identityVerified)
      const params = new URLSearchParams(window.location.search)
      window.location.href = params.get('returnTo') || '/'
    } catch (error) {
      setMessage(error instanceof Error ? error.message : 'Unable to create your account.')
    } finally {
      setIsSubmitting(false)
    }
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
                  className={`h-13 rounded-4xl border px-4 text-sm font-extrabold transition ${
                    !canSendCode || isSendingCode
                      ? 'cursor-not-allowed border-gray-200 bg-gray-100 text-gray-400 shadow-inner'
                      : 'cursor-pointer border-blue-100 bg-blue-50 text-blue-600 hover:bg-blue-100'
                  }`}
                  disabled={!canSendCode || isSendingCode}
                  onClick={handleSendCode}
                  type="button"
                >
                  {isSendingCode
                    ? 'Sending...'
                    : isCodeSent
                      ? 'Resend Code'
                      : 'Send Code'}
                </button>
                <input
                  autoComplete="one-time-code"
                  className={`h-13 min-w-0 rounded-4xl border px-5 text-sm font-bold outline-0 transition disabled:bg-gray-50 disabled:text-gray-300 ${
                    isCodeSent
                      ? 'border-blue-100 bg-white text-gray-700 focus:border-blue-500 focus:ring-4 focus:ring-blue-100'
                      : 'border-gray-200 bg-gray-100 text-gray-400 shadow-inner'
                  }`}
                  disabled={!isCodeSent}
                  inputMode="numeric"
                  maxLength={6}
                  name="verificationCode"
                  onChange={(event) => setVerificationCode(event.target.value.replace(/\D/g, '').slice(0, 6),)}
                  placeholder="Enter code"
                  value={verificationCode}
                />
              </div>
            </label>
            {message ? (
              <p className={`m-0 mt-2 flex items-center gap-2 text-xs leading-5 ${message === verificationSuccessMessage ? 'font-bold text-green-600' : 'text-gray-400'}`}>
                {message === verificationSuccessMessage ? (
                  <span aria-hidden="true" className="text-base leading-none">
                    ✅
                  </span>
                ) : null}
                <span>{message}</span>
              </p>
            ) : null}
          </div>

          <button
            className="font-outfit mt-2 h-14 cursor-pointer rounded-4xl border-0 bg-blue-500 text-xl font-extrabold text-white shadow-lg shadow-blue-200 transition hover:bg-blue-600 disabled:cursor-not-allowed disabled:bg-gray-300 disabled:shadow-none"
            disabled={!canContinue || isVerifyingCode}
            type="submit"
          >
            {isVerifyingCode ? 'Verifying...' : 'Continue'}
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
            disabled={!canCompleteRegistration || isSubmitting}
            type="submit"
          >
            {isSubmitting ? 'Creating Account...' : 'Complete Registration'}
          </button>
        </form>
      )}
    </AuthShell>
  )
}

export default SignUpPage
