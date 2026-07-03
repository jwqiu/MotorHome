import { useEffect, useState } from 'react'
import { isIdentityVerified } from '../auth/authSession'
import ModernSelect from '../listing/ModernSelect'

type EnquiryModalProps = {
  listingTitle: string
  onClose: () => void
}

const userListings: string[] = []
const ENQUIRY_DRAFT_KEY = 'mt-exchange-enquiry-draft'

type EnquiryDraft = {
  email: string
  exchangeMethod: string
  isDisclaimerAccepted: boolean
  listingTitle: string
  message: string
  name: string
  selectedUserListing: string
}

function EnquiryModal({ listingTitle, onClose }: EnquiryModalProps) {
  const identityVerified = isIdentityVerified()
  const [exchangeMethod, setExchangeMethod] = useState('Direct Exchange')
  const [selectedUserListing, setSelectedUserListing] = useState(userListings.length === 1 ? userListings[0] : '')
  const [name, setName] = useState('')
  const [email, setEmail] = useState('')
  const [message, setMessage] = useState('')
  const [isDisclaimerAccepted, setIsDisclaimerAccepted] = useState(false)
  const [showPointExchangeHint, setShowPointExchangeHint] = useState(false)
  const hasUserListings = userListings.length > 0
  const canSendRequest = Boolean(
    name &&
    email &&
    message &&
    isDisclaimerAccepted &&
    identityVerified &&
    (exchangeMethod !== 'Direct Exchange' || selectedUserListing),
  )

  useEffect(() => {
    const savedDraft = window.sessionStorage.getItem(ENQUIRY_DRAFT_KEY)

    if (!savedDraft) {
      return
    }

    try {
      const parsedDraft = JSON.parse(savedDraft) as EnquiryDraft

      if (parsedDraft.listingTitle !== listingTitle) {
        return
      }

      setExchangeMethod(parsedDraft.exchangeMethod || 'Direct Exchange')
      setSelectedUserListing(parsedDraft.selectedUserListing || (userListings.length === 1 ? userListings[0] : ''))
      setName(parsedDraft.name || '')
      setEmail(parsedDraft.email || '')
      setMessage(parsedDraft.message || '')
      setIsDisclaimerAccepted(Boolean(parsedDraft.isDisclaimerAccepted))
      window.sessionStorage.removeItem(ENQUIRY_DRAFT_KEY)
    } catch {
      window.sessionStorage.removeItem(ENQUIRY_DRAFT_KEY)
    }
  }, [listingTitle])

  const handleExchangeMethodClick = (method: string) => {
    if (method === 'Use Points') {
      setShowPointExchangeHint(true)
      window.setTimeout(() => setShowPointExchangeHint(false), 2600)
      return
    }

    setShowPointExchangeHint(false)
    setExchangeMethod(method)
  }

  const handleVerifyIdentity = () => {
    const draft: EnquiryDraft = {
      email,
      exchangeMethod,
      isDisclaimerAccepted,
      listingTitle,
      message,
      name,
      selectedUserListing,
    }
    const returnTo = `${window.location.pathname}?requestSwap=1`

    window.sessionStorage.setItem(ENQUIRY_DRAFT_KEY, JSON.stringify(draft))
    window.location.href = `/user-center/verification?returnTo=${encodeURIComponent(returnTo)}`
  }

  return (
    <div
      aria-labelledby="enquiry-modal-title"
      aria-modal="true"
      className="fixed inset-0 z-40 flex items-center justify-center bg-gray-900/40 px-6 backdrop-blur-sm"
      role="dialog"
    >
      <div className="max-h-[88vh] w-full max-w-[560px] overflow-y-auto rounded-4xl bg-white p-6 shadow-2xl shadow-gray-900/20 md:p-7">
        <div className="mb-5 flex items-start justify-between gap-6">
          <div>
            <p className="mb-2 text-xs font-extrabold tracking-[0.16em] text-blue-500 uppercase">Send enquiry</p>
            <h2 id="enquiry-modal-title" className="font-outfit m-0 text-2xl font-extrabold text-gray-800">
              Ask about {listingTitle}
            </h2>
          </div>
          <button
            aria-label="Close enquiry form"
            className="flex h-10 w-10 shrink-0 cursor-pointer items-center justify-center rounded-full border border-blue-100 bg-blue-50 text-xl font-bold text-gray-700"
            onClick={onClose}
            type="button"
          >
            x
          </button>
        </div>

        <form className="grid gap-3">
          <fieldset className="border-0 p-0">
            <legend className="mb-2 text-sm font-extrabold text-gray-700">Exchange method</legend>
            <div className="grid gap-3 sm:grid-cols-2">
              {['Direct Exchange', 'Use Points'].map((method) => {
                const isUsePoints = method === 'Use Points'
                const isSelected = exchangeMethod === method

                return (
                  <div className="relative" key={method}>
                    <button
                      aria-describedby={isUsePoints && showPointExchangeHint ? 'point-exchange-hint' : undefined}
                      aria-disabled={isUsePoints}
                      aria-pressed={isSelected}
                      className={`h-12 w-full cursor-pointer rounded-4xl border px-4 text-sm font-extrabold transition ${
                        isUsePoints
                          ? 'cursor-not-allowed border-gray-100 bg-gray-50 text-gray-300'
                          : isSelected
                            ? 'border-blue-200 bg-blue-50 text-blue-600'
                            : 'border-blue-100 bg-white text-gray-600 shadow-md shadow-blue-100/70 hover:bg-blue-50 hover:text-blue-500'
                      }`}
                      onClick={() => handleExchangeMethodClick(method)}
                      type="button"
                    >
                      {method}
                    </button>

                    {isUsePoints && showPointExchangeHint ? (
                      <div
                        className="absolute right-0 bottom-[calc(100%+10px)] z-10 w-[230px] rounded-2xl bg-gray-800 px-4 py-3 text-xs leading-5 font-bold text-white shadow-lg shadow-gray-900/20"
                        id="point-exchange-hint"
                        role="status"
                      >
                        The point exchange system is coming soon.
                      </div>
                    ) : null}
                  </div>
                )
              })}
            </div>
          </fieldset>

          {exchangeMethod === 'Direct Exchange' ? (
            hasUserListings ? (
              <label className="grid gap-2 text-sm font-extrabold text-gray-700">
                Your listing to exchange
                <ModernSelect
                  ariaLabel="Your listing to exchange"
                  onChange={setSelectedUserListing}
                  options={userListings}
                  placeholder="Select your listing"
                  value={selectedUserListing}
                />
              </label>
            ) : (
              <div className="rounded-3xl  text-sm text-gray-400">
                You don&apos;t have an existing listing to exchange.
              </div>
            )
          ) : null}
          <div className="grid gap-2 mt-2 mb-2">
            {identityVerified ? (
              <p className="m-0 flex items-center gap-2 text-sm font-bold text-emerald-600">
                <span className="inline-flex h-5 w-5 items-center justify-center rounded-full bg-emerald-500 text-white" aria-hidden="true">
                  <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={2.5} stroke="currentColor" className="h-3.5 w-3.5">
                    <path strokeLinecap="round" strokeLinejoin="round" d="m4.5 12.75 6 6 9-13.5" />
                  </svg>
                </span>
                Identity verified
              </p>
            ) : (
              <div className="flex flex-wrap items-center justify-between gap-3">
                <div>
                  <p className="m-0 text-sm font-extrabold text-gray-700">Identity not verified</p>
                  <p className="mt-1 mb-0 text-xs leading-5 text-gray-500">
                    Verify your identity before sending a swap request.
                  </p>
                </div>
                <button
                  className="h-9 cursor-pointer rounded-4xl border border-blue-100 bg-white px-4 text-xs font-extrabold text-blue-600 transition hover:bg-blue-50"
                  onClick={handleVerifyIdentity}
                  type="button"
                >
                  Verify identity
                </button>
              </div>
            )}
          </div>

          <div className="grid gap-3 sm:grid-cols-2">
            <label className="grid gap-2 text-sm font-extrabold text-gray-700">
              Name
              <input
                className="h-11 rounded-3xl border border-blue-100 px-4 text-sm font-semibold text-gray-700 outline-none focus:border-blue-400"
                onChange={(event) => setName(event.target.value)}
                value={name}
              />
            </label>
            <label className="grid gap-2 text-sm font-extrabold text-gray-700">
              Email
              <input
                className="h-11 rounded-3xl border border-blue-100 px-4 text-sm font-semibold text-gray-700 outline-none focus:border-blue-400"
                onChange={(event) => setEmail(event.target.value)}
                type="email"
                value={email}
              />
            </label>
          </div>
          <label className="grid gap-2 text-sm font-extrabold text-gray-700">
            Message
            <textarea
              className="min-h-28 resize-none placeholder:text-gray-400 placeholder:font-normal rounded-3xl border border-blue-100 px-4 py-3 text-sm font-semibold text-gray-700 outline-none focus:border-blue-400"
              onChange={(event) => setMessage(event.target.value)}
              placeholder="Share your travel dates, why this swap is a good fit, and any details about your listing that may help the owner feel confident."
              value={message}
            />
          </label>

          <label className="flex cursor-pointer items-start gap-3 rounded-3xl bg-blue-50/60 px-4 py-3 text-sm text-gray-600">
            <input
              checked={isDisclaimerAccepted}
              className="mt-1 h-4 w-4 shrink-0 accent-blue-500"
              onChange={(event) => setIsDisclaimerAccepted(event.target.checked)}
              type="checkbox"
            />
            <span className="leading-5">
              <span className="block">
                I understand that this platform only helps users connect. All exchange arrangements are made directly between users.
              </span>
              <a
                className="mt-2 inline-flex font-extrabold text-blue-500 no-underline hover:text-blue-600"
                href="about:blank"
                rel="noreferrer"
                target="_blank"
              >
                View Exchange Disclaimer
              </a>
            </span>
          </label>

          <button
            className="font-outfit mt-1 h-12 cursor-pointer rounded-4xl border-0 bg-blue-500 text-lg font-extrabold text-white shadow-lg shadow-blue-200 transition hover:bg-blue-600 disabled:cursor-not-allowed disabled:bg-gray-300 disabled:shadow-none"
            disabled={!canSendRequest}
            type="button"
          >
            Send Request
          </button>
        </form>
      </div>
    </div>
  )
}

export default EnquiryModal
