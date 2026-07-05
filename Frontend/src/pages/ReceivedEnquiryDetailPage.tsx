import { useEffect, useState } from 'react'
import { getSessionUserId, isAuthenticated } from '../components/auth/authSession'
import { agreeToDiscuss, declineEnquiry, getUserEnquiries, type UserEnquiryItemResponse } from '../components/detail/enquiryApi'
import { listingFromEnquirySummary } from '../components/detail/enquiryListingMapper'
import { getReceivedStatusDescription, type ReceivedEnquiry, type ReceivedEnquiryStatus } from '../components/userCenter/userCenterData'
import Navbar from '../components/layout/Navbar'

function getEnquiryIdFromPath() {
  const parts = window.location.pathname.split('/').filter(Boolean)
  return Number(parts[parts.length - 1] ?? 0)
}

function formatDate(value?: string) {
  if (!value) {
    return 'Not recorded'
  }

  const date = new Date(`${value}T00:00:00`)
  if (Number.isNaN(date.getTime())) {
    return value
  }

  return date.toLocaleDateString('en-NZ', {
    day: '2-digit',
    month: 'short',
  })
}

function toReceivedStatus(status: string): ReceivedEnquiryStatus {
  if (status === 'Agreed' || status === 'Declined') {
    return status
  }

  return 'Pending'
}

function mapReceivedEnquiry(enquiry: UserEnquiryItemResponse): ReceivedEnquiry {
  return {
    dateReceived: formatDate(enquiry.dateReceived || enquiry.dateSent),
    id: enquiry.id,
    message: enquiry.message,
    senderEmail: enquiry.counterpartyEmail || '',
    senderListing: listingFromEnquirySummary(
      enquiry.offeredListing,
      enquiry.offeredListingId,
      'No listing offered',
      'The sender did not attach one of their listings to this enquiry.',
    ),
    senderName: enquiry.counterpartyName,
    status: toReceivedStatus(enquiry.status),
    type: enquiry.enquiryType,
    yourListing: listingFromEnquirySummary(enquiry.listing, enquiry.listingId),
  }
}

function ListingPreviewCard({
  listing,
  title,
}: {
  listing: ReceivedEnquiry['yourListing']
  title: string
}) {
  return (
    <section className="rounded-4xl bg-white p-6 shadow-lg shadow-blue-100">
      <p className="m-0 mb-4 text-sm font-extrabold text-gray-800">{title}</p>
      <div className="overflow-hidden rounded-3xl bg-blue-50">
        <img alt={listing.imageLabel} className="h-56 w-full object-cover" src={listing.imageSrc} />
      </div>

      <h2 className="font-outfit mt-5 mb-3 text-2xl font-extrabold text-gray-800">{listing.title}</h2>
      <p className="m-0 mb-5 text-sm leading-6 text-gray-500">{listing.description}</p>
      <dl className="m-0 grid gap-3 text-sm">
        <div className="grid gap-1 sm:grid-cols-[140px_1fr]">
          <dt className="font-extrabold text-gray-700">Location</dt>
          <dd className="m-0 text-gray-500">{listing.currentLocation}</dd>
        </div>
        <div className="grid gap-1 sm:grid-cols-[140px_1fr]">
          <dt className="font-extrabold text-gray-700">Asset Type</dt>
          <dd className="m-0 text-gray-500">{listing.listingType}</dd>
        </div>
        <div className="grid gap-1 sm:grid-cols-[140px_1fr]">
          <dt className="font-extrabold text-gray-700">Exchange Options</dt>
          <dd className="m-0 flex flex-wrap items-start gap-2">
            {listing.exchangeTypes.map((type) => (
              <span className="inline-flex items-center rounded-4xl border border-blue-100 bg-blue-50 px-3 py-1 text-xs leading-none text-gray-600" key={type}>
                {type}
              </span>
            ))}
          </dd>
        </div>
        <div className="grid gap-1 sm:grid-cols-[140px_1fr]">
          <dt className="font-extrabold text-gray-700">Wanted Destinations</dt>
          <dd className="m-0 flex flex-wrap items-start gap-2">
            {listing.wantedDestinations.map((destination) => (
              <span className="inline-flex items-center rounded-4xl border border-blue-100 bg-blue-50 px-3 py-1 text-xs leading-none text-gray-600" key={destination}>
                {destination}
              </span>
            ))}
          </dd>
        </div>
        <div className="grid gap-1 sm:grid-cols-[140px_1fr]">
          <dt className="font-extrabold text-gray-700">Wanted Assets</dt>
          <dd className="m-0 flex flex-wrap items-start gap-2">
            {listing.wantedAssets.map((asset) => (
              <span className="inline-flex items-center rounded-4xl border border-blue-100 bg-blue-50 px-3 py-1 text-xs leading-none text-gray-600" key={asset}>
                {asset}
              </span>
            ))}
          </dd>
        </div>
      </dl>

      {listing.id ? (
        <a
          className="mt-6 inline-flex text-sm font-extrabold text-blue-500 no-underline hover:text-blue-600"
          href={`/listings/${listing.id}`}
          rel="noreferrer"
          target="_blank"
        >
          Check Detail &gt;&gt;
        </a>
      ) : null}
    </section>
  )
}

function ReceivedEnquiryDetailPage() {
  const enquiryId = getEnquiryIdFromPath()
  const [enquiry, setEnquiry] = useState<ReceivedEnquiry | null>(null)
  const [status, setStatus] = useState<ReceivedEnquiryStatus>('Pending')
  const [senderEmail, setSenderEmail] = useState('')
  const [isDisclaimerAccepted, setIsDisclaimerAccepted] = useState(false)
  const [isSubmittingDecision, setIsSubmittingDecision] = useState(false)
  const [decisionMessage, setDecisionMessage] = useState('')
  const [isLoadingEnquiry, setIsLoadingEnquiry] = useState(true)
  const [showAcceptSuccess, setShowAcceptSuccess] = useState(false)
  const isAgreed = status === 'Agreed'
  const isDeclined = status === 'Declined'
  const canRespond = status === 'Pending'
  const canAccept = canRespond && isDisclaimerAccepted && !isSubmittingDecision
  const senderEmailDisplay = isAgreed
    ? senderEmail
    : isDeclined
      ? 'Not shared because this enquiry was declined'
      : 'Hidden until agreed to discuss'

  useEffect(() => {
    let isActive = true
    const userId = getSessionUserId()

    if (!isAuthenticated() || !userId) {
      setIsLoadingEnquiry(false)
      return () => {
        isActive = false
      }
    }

    setIsLoadingEnquiry(true)

    getUserEnquiries(userId)
      .then((response) => {
        if (!isActive) {
          return
        }

        const receivedEnquiry = response.received.find((item) => item.id === enquiryId)
        if (!receivedEnquiry) {
          setEnquiry(null)
          return
        }

        const mappedEnquiry = mapReceivedEnquiry(receivedEnquiry)
        setEnquiry(mappedEnquiry)
        setStatus(mappedEnquiry.status)
        setSenderEmail(mappedEnquiry.senderEmail)
      })
      .catch(() => {
        if (isActive) {
          setEnquiry(null)
        }
      })
      .finally(() => {
        if (isActive) {
          setIsLoadingEnquiry(false)
        }
      })

    return () => {
      isActive = false
    }
  }, [enquiryId])

  const handleAgreeToDiscuss = async () => {
    if (!canAccept) {
      return
    }

    setDecisionMessage('')
    setIsSubmittingDecision(true)

    try {
      const response = await agreeToDiscuss(enquiryId, getSessionUserId())
      const updatedSenderEmail = response.senderEmail || senderEmail
      setStatus('Agreed')
      setSenderEmail(updatedSenderEmail)
      setShowAcceptSuccess(true)
      setDecisionMessage('Contact details are now shared.')
    } catch (error) {
      setDecisionMessage(error instanceof Error ? error.message : 'Unable to agree to discuss.')
    } finally {
      setIsSubmittingDecision(false)
    }
  }

  const handleDecline = async () => {
    if (!canRespond || isSubmittingDecision) {
      return
    }

    setDecisionMessage('')
    setIsSubmittingDecision(true)

    try {
      await declineEnquiry(enquiryId, getSessionUserId())
      setStatus('Declined')
      setDecisionMessage('This enquiry has been declined.')
    } catch (error) {
      setDecisionMessage(error instanceof Error ? error.message : 'Unable to decline enquiry.')
    } finally {
      setIsSubmittingDecision(false)
    }
  }

  if (!isAuthenticated()) {
    window.location.href = `/sign-in?returnTo=${encodeURIComponent(window.location.pathname)}`
    return null
  }

  if (isLoadingEnquiry) {
    return (
      <main className="min-h-screen bg-blue-50 font-sans text-gray-600 antialiased">
        <Navbar variant="solid" />
        <section className="px-6 pt-40 pb-16 md:px-16 md:pt-44">
          <div className="mx-auto max-w-[920px] rounded-4xl bg-white p-8 text-center shadow-lg shadow-blue-100">
            <h1 className="font-outfit m-0 text-3xl font-extrabold text-gray-800">Loading enquiry...</h1>
          </div>
        </section>
      </main>
    )
  }

  if (!enquiry) {
    return (
      <main className="min-h-screen bg-blue-50 font-sans text-gray-600 antialiased">
        <Navbar variant="solid" />
        <section className="px-6 pt-40 pb-16 md:px-16 md:pt-44">
          <div className="mx-auto max-w-[920px] rounded-4xl bg-white p-8 text-center shadow-lg shadow-blue-100">
            <h1 className="font-outfit m-0 text-3xl font-extrabold text-gray-800">Enquiry not found</h1>
            <p className="mt-3 mb-0 text-sm text-gray-500">The enquiry you are looking for is not available.</p>
          </div>
        </section>
      </main>
    )
  }

  return (
    <main className="min-h-screen bg-blue-50 font-sans text-gray-600 antialiased">
      <Navbar variant="solid" />

      <section className="px-6 pt-40 pb-10 md:px-16 md:pt-44">
        <div className="mx-auto max-w-[1120px]">
          <p className="mb-3 text-sm font-extrabold tracking-[0.18em] text-blue-500 uppercase">
            Received enquiry
          </p>
          <h1 className="font-outfit m-0 text-4xl leading-tight font-extrabold text-gray-800 md:text-5xl">
            Enquiry Details
          </h1>

          <section className="mt-8 rounded-4xl bg-white p-7 shadow-lg shadow-blue-100 md:p-8">
            <dl className="m-0 grid gap-4">
              <div className="grid gap-2 border-b border-blue-50 pb-4 md:grid-cols-[180px_1fr] md:gap-6">
                <dt className="text-sm font-extrabold text-gray-800">Sender Name</dt>
                <dd className="m-0 text-sm leading-6 text-gray-500">{enquiry.senderName}</dd>
              </div>
              <div className="grid gap-2 border-b border-blue-50 pb-4 md:grid-cols-[180px_1fr] md:gap-6">
                <dt className="text-sm font-extrabold text-gray-800">Enquiry Type</dt>
                <dd className="m-0 text-sm leading-6 text-gray-500">{enquiry.type}</dd>
              </div>
              <div className="grid gap-2 border-b border-blue-50 pb-4 md:grid-cols-[180px_1fr] md:gap-6">
                <dt className="text-sm font-extrabold text-gray-800">Sender email</dt>
                <dd className={`m-0 text-sm leading-6 ${isAgreed ? 'font-extrabold text-red-500' : 'text-gray-500'}`}>
                  {senderEmailDisplay}
                </dd>
              </div>
              <div className="grid gap-2 border-b border-blue-50 pb-4 md:grid-cols-[180px_1fr] md:gap-6">
                <dt className="text-sm font-extrabold text-gray-800">Date received</dt>
                <dd className="m-0 text-sm leading-6 text-gray-500">{enquiry.dateReceived}</dd>
              </div>
              <div className="grid gap-2 border-b border-blue-50 pb-4 md:grid-cols-[180px_1fr] md:gap-6">
                <dt className="text-sm font-extrabold text-gray-800">Status</dt>
                <dd className="m-0 text-sm leading-6 text-gray-500">
                  {status} - {getReceivedStatusDescription(status)}
                </dd>
              </div>
              <div className="grid gap-2 md:grid-cols-[180px_1fr] md:gap-6">
                <dt className="text-sm font-extrabold text-gray-800">Message</dt>
                <dd className="m-0 text-sm leading-7 text-gray-500">{enquiry.message}</dd>
              </div>
            </dl>
          </section>

          <div className="mt-8 grid gap-8 lg:grid-cols-2">
            <ListingPreviewCard listing={enquiry.yourListing} title="Brief of Your Listing" />
            <ListingPreviewCard listing={enquiry.senderListing} title="Sender's Listing" />
          </div>
        </div>
      </section>

      {canRespond ? (
        <section className="sticky bottom-0 border-t border-blue-100 bg-white/95 px-6 py-5 backdrop-blur md:px-16">
          <div className="mx-auto flex max-w-[1120px] flex-col gap-4 md:flex-row md:items-center md:justify-between">
            <label className="flex max-w-[650px] cursor-pointer items-start gap-3 text-xs leading-5 text-gray-500">
              <input
                checked={isDisclaimerAccepted}
                className="mt-0.5 h-4 w-4 shrink-0 accent-blue-500"
                onChange={(event) => setIsDisclaimerAccepted(event.target.checked)}
                type="checkbox"
              />
              <span>
                <span className="block">
                  I understand that this platform only helps users connect. All exchange arrangements are made directly between users.
                </span>
                <a
                  className="mt-1 inline-flex font-extrabold text-blue-500 no-underline hover:text-blue-600"
                  href="/exchange-disclaimer.pdf"
                  rel="noreferrer"
                  target="_blank"
                >
                  View Exchange Disclaimer
                </a>
              </span>
            </label>
            <div className="flex flex-wrap gap-3">
              <button
                className="h-11 cursor-pointer rounded-4xl border border-gray-200 bg-white px-8 text-sm font-extrabold text-gray-600 shadow-md shadow-gray-200 transition hover:bg-gray-50 disabled:cursor-not-allowed disabled:bg-gray-50 disabled:text-gray-300 disabled:shadow-none"
                disabled={isSubmittingDecision}
                onClick={handleDecline}
                type="button"
              >
                {isSubmittingDecision ? 'Updating...' : 'Decline'}
              </button>
              <button
                className={`h-11 rounded-4xl border px-8 text-sm font-extrabold transition ${
                  canAccept
                    ? 'cursor-pointer border-blue-500 bg-blue-500 text-white shadow-lg shadow-blue-200 hover:bg-blue-600'
                    : 'cursor-not-allowed border-blue-100 bg-blue-50 text-blue-200'
                }`}
                disabled={!canAccept}
                onClick={handleAgreeToDiscuss}
                type="button"
              >
                {isSubmittingDecision ? 'Updating...' : 'Agree to Discuss'}
              </button>
            </div>
            {decisionMessage ? (
              <p className="m-0 text-sm font-bold text-gray-500">{decisionMessage}</p>
            ) : null}
          </div>
        </section>
      ) : isAgreed || isDeclined ? (
        <section className="sticky bottom-0 border-t border-blue-100 bg-white/95 px-6 py-5 backdrop-blur md:px-16">
          <div className="mx-auto flex max-w-[1120px] justify-center">
            <a
              className="inline-flex h-11 items-center justify-center rounded-4xl border border-gray-900 bg-white px-8 text-sm font-extrabold text-gray-900 no-underline transition hover:bg-gray-50"
              href="/user-center"
            >
              Back to User Center
            </a>
          </div>
        </section>
      ) : null}
      {showAcceptSuccess ? (
        <div
          aria-labelledby="accept-success-title"
          aria-modal="true"
          className="fixed inset-0 z-50 flex items-center justify-center bg-gray-900/20 px-6 backdrop-blur-sm"
          role="dialog"
        >
          <div className="relative flex w-full max-w-[520px] items-start gap-4 rounded-3xl border border-gray-100 bg-white px-7 py-6 pr-14 text-left shadow-2xl shadow-gray-900/20">
            <button
              aria-label="Close success message"
              className="absolute top-4 right-4 cursor-pointer border-0 bg-transparent p-1 text-xl leading-none font-extrabold text-gray-300 transition hover:text-gray-500"
              onClick={() => setShowAcceptSuccess(false)}
              type="button"
            >
              x
            </button>
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.8} stroke="currentColor" className="mt-0.5 h-7 w-7 shrink-0 text-green-500">
              <path strokeLinecap="round" strokeLinejoin="round" d="M9 12.75 11.25 15 15 9.75M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z" />
            </svg>
            <div>
              <h2 id="accept-success-title" className="m-0 text-lg leading-7 font-extrabold text-gray-900">Success!</h2>
              <p className="mt-2 mb-0 text-sm leading-6 font-bold text-gray-700">
                The request has been accepted. You can now contact the sender at{' '}
                <span className="font-extrabold text-red-500">{senderEmail || 'Not available'}</span>.
              </p>
            </div>
          </div>
        </div>
      ) : null}
    </main>
  )
}

export default ReceivedEnquiryDetailPage
