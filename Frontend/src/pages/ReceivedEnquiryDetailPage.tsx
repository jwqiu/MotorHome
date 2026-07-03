import { useState } from 'react'
import { isAuthenticated } from '../components/auth/authSession'
import { getReceivedStatusDescription, receivedEnquiries, type ReceivedEnquiry, type ReceivedEnquiryStatus } from '../components/userCenter/userCenterData'
import Navbar from '../components/layout/Navbar'

function getEnquiryIdFromPath() {
  const parts = window.location.pathname.split('/').filter(Boolean)
  return parts[parts.length - 1] ?? ''
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

      <a
        className="mt-6 inline-flex text-sm font-extrabold text-blue-500 no-underline hover:text-blue-600"
        href={`/listings/${listing.id}`}
        rel="noreferrer"
        target="_blank"
      >
        Check Detail &gt;&gt;
      </a>
    </section>
  )
}

function ReceivedEnquiryDetailPage() {
  const enquiryId = getEnquiryIdFromPath()
  const enquiry = receivedEnquiries.find((item) => item.id === enquiryId)
  const [status, setStatus] = useState<ReceivedEnquiryStatus>(enquiry?.status ?? 'Pending')
  const [isDisclaimerAccepted, setIsDisclaimerAccepted] = useState(false)
  const isAgreed = status === 'Agreed'
  const canRespond = status === 'Pending'
  const canAccept = canRespond && isDisclaimerAccepted

  if (!isAuthenticated()) {
    window.location.href = `/sign-in?returnTo=${encodeURIComponent(window.location.pathname)}`
    return null
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
                <dt className="text-sm font-extrabold text-gray-800">Email</dt>
                <dd className="m-0 text-sm leading-6 text-gray-500">
                  {isAgreed ? enquiry.senderEmail : 'Hidden until agreed to discuss'}
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
                  href="about:blank"
                  rel="noreferrer"
                  target="_blank"
                >
                  View Exchange Disclaimer
                </a>
              </span>
            </label>
            <div className="flex flex-wrap gap-3">
              <button
                className="h-11 cursor-pointer rounded-4xl border border-gray-200 bg-white px-8 text-sm font-extrabold text-gray-600 shadow-md shadow-gray-200 transition hover:bg-gray-50"
                onClick={() => setStatus('Declined')}
                type="button"
              >
                Decline
              </button>
              <button
                className={`h-11 rounded-4xl border px-8 text-sm font-extrabold transition ${
                  canAccept
                    ? 'cursor-pointer border-blue-500 bg-blue-500 text-white shadow-lg shadow-blue-200 hover:bg-blue-600'
                    : 'cursor-not-allowed border-blue-100 bg-blue-50 text-blue-200'
                }`}
                disabled={!canAccept}
                onClick={() => setStatus('Agreed')}
                type="button"
              >
                Agree to Discuss
              </button>
            </div>
          </div>
        </section>
      ) : null}
    </main>
  )
}

export default ReceivedEnquiryDetailPage
