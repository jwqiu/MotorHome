import { useEffect, useState } from 'react'
import {
  getSessionUserEmail,
  isAuthenticated,
  setIdentityVerified,
} from '../components/auth/authSession'
import { verifyIdentity } from '../components/auth/verificationApi'
import ModernDateInput from '../components/listing/ModernDateInput'
import Navbar from '../components/layout/Navbar'

function IdentityVerificationPage() {
  const [legalFirstName, setLegalFirstName] = useState('')
  const [legalLastName, setLegalLastName] = useState('')
  const [dateOfBirth, setDateOfBirth] = useState('')
  const [licenceNumber, setLicenceNumber] = useState('')
  const [versionNumber, setVersionNumber] = useState('')
  const [frontLicence, setFrontLicence] = useState<File | null>(null)
  const [backLicence, setBackLicence] = useState<File | null>(null)
  const [frontLicencePreviewUrl, setFrontLicencePreviewUrl] = useState('')
  const [backLicencePreviewUrl, setBackLicencePreviewUrl] = useState('')
  const [isConfirmed, setIsConfirmed] = useState(false)
  const [isSubmitting, setIsSubmitting] = useState(false)
  const [showPassportHint, setShowPassportHint] = useState(false)
  const [message, setMessage] = useState('')
  const returnTo = new URLSearchParams(window.location.search).get('returnTo')

  useEffect(() => {
    if (!frontLicence) {
      setFrontLicencePreviewUrl('')
      return
    }

    const previewUrl = URL.createObjectURL(frontLicence)
    setFrontLicencePreviewUrl(previewUrl)

    return () => URL.revokeObjectURL(previewUrl)
  }, [frontLicence])

  useEffect(() => {
    if (!backLicence) {
      setBackLicencePreviewUrl('')
      return
    }

    const previewUrl = URL.createObjectURL(backLicence)
    setBackLicencePreviewUrl(previewUrl)

    return () => URL.revokeObjectURL(previewUrl)
  }, [backLicence])

  const verificationRequirements = [
    { isComplete: Boolean(legalFirstName.trim()), label: 'legal first name' },
    { isComplete: Boolean(legalLastName.trim()), label: 'legal last name' },
    { isComplete: Boolean(dateOfBirth), label: 'date of birth' },
    { isComplete: Boolean(licenceNumber.trim()), label: 'licence number' },
    { isComplete: Boolean(versionNumber.trim()), label: 'version number' },
    { isComplete: Boolean(frontLicence), label: 'front licence image' },
    { isComplete: Boolean(backLicence), label: 'back licence image' },
    { isComplete: isConfirmed, label: 'confirmation checkbox' },
  ]
  const missingRequirements = verificationRequirements
    .filter((requirement) => !requirement.isComplete)
    .map((requirement) => requirement.label)
  const canSubmit = missingRequirements.length === 0

  const handleSubmit = async () => {
    if (!canSubmit || !frontLicence || !backLicence) {
      return
    }

    setMessage('')
    setIsSubmitting(true)

    try {
      await verifyIdentity({
        backLicenceFileName: backLicence.name,
        confirmationAccepted: isConfirmed,
        dateOfBirth,
        email: getSessionUserEmail(),
        frontLicenceFileName: frontLicence.name,
        legalFirstName,
        legalLastName,
        licenceNumber,
        versionNumber,
      })

      setIdentityVerified()
      window.location.href = returnTo || '/user-center'
    } catch (error) {
      setMessage(error instanceof Error ? error.message : 'Unable to submit verification.')
    } finally {
      setIsSubmitting(false)
    }
  }

  const handlePassportClick = () => {
    setShowPassportHint(true)
    window.setTimeout(() => setShowPassportHint(false), 2600)
  }

  if (!isAuthenticated()) {
    const currentPath = `${window.location.pathname}${window.location.search}`

    window.location.href = `/sign-in?returnTo=${encodeURIComponent(currentPath)}`
    return null
  }

  return (
    <main className="min-h-screen bg-blue-50 font-sans text-gray-600 antialiased">
      <Navbar variant="solid" />

      <section className="px-6 pt-40 pb-16 md:px-16 md:pt-44">
        <div className="mx-auto max-w-[920px]">
          <p className="mb-3 text-sm font-extrabold tracking-[0.18em] text-blue-500 uppercase">
            Identity verification
          </p>
          <h1 className="font-outfit m-0 text-4xl leading-tight font-extrabold text-gray-800 md:text-5xl">
            Verify your identity.
          </h1>
          <p className="mt-4 mb-0 max-w-[720px] text-sm leading-7 text-gray-500">
            This is a temporary verification flow for the MVP. Submitting all required details will mark your account as verified for now.
          </p>

          <section className="mt-8 rounded-4xl bg-white p-7 shadow-lg shadow-blue-100 md:p-8">
            <form className="grid gap-5">
              <div className="grid gap-2 text-sm font-extrabold text-gray-700 md:grid-cols-[220px_1fr] md:items-center">
                <span>Document type</span>
                <div className="grid gap-3 md:grid-cols-2">
                  <button
                    aria-pressed="true"
                    className="h-12 rounded-4xl border border-blue-200 bg-blue-50 px-5 text-sm font-extrabold text-blue-600"
                    type="button"
                  >
                    Driver licence
                  </button>
                  <div className="relative">
                    <button
                      aria-describedby={showPassportHint ? 'passport-hint' : undefined}
                      aria-disabled="true"
                      className="h-12 w-full cursor-not-allowed rounded-4xl border border-gray-100 bg-gray-50 px-5 text-sm font-extrabold text-gray-300"
                      onClick={handlePassportClick}
                      type="button"
                    >
                      Passport
                    </button>
                    {showPassportHint ? (
                      <div
                        className="absolute right-0 bottom-[calc(100%+10px)] z-10 w-[220px] rounded-2xl bg-gray-800 px-4 py-3 text-xs leading-5 font-bold text-white shadow-lg shadow-gray-900/20"
                        id="passport-hint"
                        role="status"
                      >
                        Passport verification is coming soon.
                      </div>
                    ) : null}
                  </div>
                </div>
              </div>

              <div className="grid gap-4">
                <div className="grid gap-2 text-sm font-extrabold text-gray-700 md:grid-cols-[220px_1fr] md:items-center">
                  <span>Legal name</span>
                  <div className="grid gap-3 md:grid-cols-2">
                    <input
                      aria-label="Legal first name"
                      className="h-12 rounded-3xl border border-blue-100 px-4 text-sm font-semibold text-gray-700 placeholder:text-gray-300 outline-none focus:border-blue-400"
                      onChange={(event) => setLegalFirstName(event.target.value)}
                      placeholder="First name"
                      value={legalFirstName}
                    />
                    <input
                      aria-label="Legal last name"
                      className="h-12 rounded-3xl border border-blue-100 px-4 text-sm font-semibold text-gray-700 placeholder:text-gray-300 outline-none focus:border-blue-400"
                      onChange={(event) => setLegalLastName(event.target.value)}
                      placeholder="Last name"
                      value={legalLastName}
                    />
                  </div>
                </div>
                <label className="grid gap-2 text-sm font-extrabold text-gray-700 md:grid-cols-[220px_1fr] md:items-center">
                  <span>Date of birth</span>
                  <ModernDateInput
                    ariaLabel="Date of birth"
                    onChange={setDateOfBirth}
                    value={dateOfBirth}
                  />
                </label>
                <div className="grid gap-2 text-sm font-extrabold text-gray-700 md:grid-cols-[220px_1fr] md:items-center">
                  <span>Driver licence details</span>
                  <div className="grid gap-3 md:grid-cols-2">
                    <input
                      aria-label="NZ driver licence number"
                      className="h-12 rounded-3xl border border-blue-100 px-4 text-sm font-semibold text-gray-700 placeholder:text-gray-300 outline-none focus:border-blue-400"
                      onChange={(event) => setLicenceNumber(event.target.value)}
                      placeholder="Licence number"
                      value={licenceNumber}
                    />
                    <input
                      aria-label="Version number"
                      className="h-12 rounded-3xl border border-blue-100 px-4 text-sm font-semibold text-gray-700 placeholder:text-gray-300 outline-none focus:border-blue-400"
                      onChange={(event) => setVersionNumber(event.target.value)}
                      placeholder="Version number"
                      value={versionNumber}
                    />
                  </div>
                </div>
              </div>

              <div className="grid gap-4">
                <label className="grid gap-2 text-sm font-extrabold text-gray-700 md:grid-cols-[220px_1fr] md:items-start">
                  <span className="md:pt-5">Upload front of licence</span>
                  <span className="relative flex min-h-28 cursor-pointer items-center justify-center overflow-hidden rounded-3xl border border-dashed border-blue-200 bg-blue-50/50 px-4 py-5 text-center text-sm font-bold text-gray-500 transition hover:bg-blue-50">
                    {frontLicencePreviewUrl ? (
                      <>
                        <img
                          alt="Front of licence preview"
                          className="absolute inset-0 h-full w-full object-cover"
                          src={frontLicencePreviewUrl}
                        />
                        <span className="relative z-10 rounded-3xl bg-white/85 px-4 py-2 text-gray-700 shadow-md shadow-gray-900/10">
                          {frontLicence?.name}
                        </span>
                      </>
                    ) : (
                      'Choose front image'
                    )}
                    <input
                      accept="image/*"
                      className="sr-only"
                      onChange={(event) => setFrontLicence(event.target.files?.[0] ?? null)}
                      type="file"
                    />
                  </span>
                </label>
                <label className="grid gap-2 text-sm font-extrabold text-gray-700 md:grid-cols-[220px_1fr] md:items-start">
                  <span className="md:pt-5">Upload back of licence</span>
                  <span className="relative flex min-h-28 cursor-pointer items-center justify-center overflow-hidden rounded-3xl border border-dashed border-blue-200 bg-blue-50/50 px-4 py-5 text-center text-sm font-bold text-gray-500 transition hover:bg-blue-50">
                    {backLicencePreviewUrl ? (
                      <>
                        <img
                          alt="Back of licence preview"
                          className="absolute inset-0 h-full w-full object-cover"
                          src={backLicencePreviewUrl}
                        />
                        <span className="relative z-10 rounded-3xl bg-white/85 px-4 py-2 text-gray-700 shadow-md shadow-gray-900/10">
                          {backLicence?.name}
                        </span>
                      </>
                    ) : (
                      'Choose back image'
                    )}
                    <input
                      accept="image/*"
                      className="sr-only"
                      onChange={(event) => setBackLicence(event.target.files?.[0] ?? null)}
                      type="file"
                    />
                  </span>
                </label>
              </div>

              <label className="flex cursor-pointer items-start gap-3 rounded-3xl bg-blue-50/60 px-4 py-4 text-sm leading-6 text-gray-600">
                <input
                  checked={isConfirmed}
                  className="mt-1 h-4 w-4 shrink-0 accent-blue-500"
                  onChange={(event) => setIsConfirmed(event.target.checked)}
                  type="checkbox"
                />
                <span>
                  I confirm that this is my own driver licence and I agree that this information will be used only for identity verification.
                </span>
              </label>

              <div className="flex flex-wrap items-center gap-3">
                <button
                  className="font-outfit h-12 cursor-pointer rounded-4xl border-0 bg-blue-500 px-8 text-sm font-extrabold text-white shadow-lg shadow-blue-200 transition hover:bg-blue-600 disabled:cursor-not-allowed disabled:bg-gray-300 disabled:shadow-none"
                  disabled={!canSubmit || isSubmitting}
                  onClick={handleSubmit}
                  type="button"
                >
                  {isSubmitting ? 'Submitting...' : 'Submit for verification'}
                </button>
                {!returnTo ? (
                  <a className="text-sm font-extrabold text-gray-400 no-underline hover:text-gray-600" href="/user-center">
                    Back to profile
                  </a>
                ) : null}
              </div>
              {!canSubmit ? (
                <p className="m-0 text-xs leading-5 text-gray-400">
                  Complete the missing fields to submit: {missingRequirements.join(', ')}.
                </p>
              ) : null}
              {message ? (
                <p className="m-0 rounded-3xl bg-red-50 px-4 py-3 text-sm font-bold text-red-500">
                  {message}
                </p>
              ) : null}
            </form>
          </section>
        </div>
      </section>
    </main>
  )
}

export default IdentityVerificationPage
