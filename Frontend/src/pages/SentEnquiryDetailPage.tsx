import { useEffect, useState } from 'react'
import { getSessionUserId, isAuthenticated } from '../components/auth/authSession'
import { getUserEnquiries, type UserEnquiryItemResponse } from '../components/detail/enquiryApi'
import { listingFromEnquirySummary } from '../components/detail/enquiryListingMapper'
import type { Listing } from '../components/listing/listingData'
import Navbar from '../components/layout/Navbar'

type SentEnquiryStatus = 'Pending' | 'Agreed' | 'Declined' | 'Cancelled'

type SentEnquiry = {
  contactEmail?: string
  dateSent: string
  id: number
  listing: Listing
  message: string
  offeredListing: Listing
  owner: string
  status: SentEnquiryStatus
  type: string
}

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

function toSentStatus(status: string): SentEnquiryStatus {
  if (status === 'Agreed' || status === 'Declined' || status === 'Cancelled') {
    return status
  }

  return 'Pending'
}

function getSentStatusDescription(status: SentEnquiryStatus) {
  switch (status) {
    case 'Pending':
      return 'Waiting for owner decision'
    case 'Agreed':
      return 'Contact details shared'
    case 'Declined':
      return 'Owner declined this request'
    case 'Cancelled':
      return 'You cancelled this request'
  }
}

function mapSentEnquiry(enquiry: UserEnquiryItemResponse): SentEnquiry {
  return {
    contactEmail: enquiry.counterpartyEmail,
    dateSent: formatDate(enquiry.dateSent),
    id: enquiry.id,
    listing: listingFromEnquirySummary(enquiry.listing, enquiry.listingId),
    message: enquiry.message,
    offeredListing: listingFromEnquirySummary(
      enquiry.offeredListing,
      enquiry.offeredListingId,
      'No listing offered',
      'You did not attach one of your listings to this enquiry.',
    ),
    owner: enquiry.counterpartyName,
    status: toSentStatus(enquiry.status),
    type: enquiry.enquiryType,
  }
}

function getOwnerEmailDisplay(enquiry: SentEnquiry) {
  if (enquiry.status === 'Agreed') {
    return enquiry.contactEmail || 'Not available'
  }

  if (enquiry.status === 'Declined') {
    return 'Not shared because this enquiry was declined'
  }

  if (enquiry.status === 'Cancelled') {
    return 'Not shared because this enquiry was cancelled'
  }

  return 'Hidden until the owner agrees to discuss'
}

function ListingPreviewCard({
  listing,
  title,
}: {
  listing: Listing
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

function SentEnquiryDetailPage() {
  const enquiryId = getEnquiryIdFromPath()
  const [enquiry, setEnquiry] = useState<SentEnquiry | null>(null)
  const [isLoadingEnquiry, setIsLoadingEnquiry] = useState(true)

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

        const sentEnquiry = response.sent.find((item) => item.id === enquiryId)
        setEnquiry(sentEnquiry ? mapSentEnquiry(sentEnquiry) : null)
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
            Sent enquiry
          </p>
          <h1 className="font-outfit m-0 text-4xl leading-tight font-extrabold text-gray-800 md:text-5xl">
            Enquiry Details
          </h1>

          <section className="mt-8 rounded-4xl bg-white p-7 shadow-lg shadow-blue-100 md:p-8">
            <dl className="m-0 grid gap-4">
              <div className="grid gap-2 border-b border-blue-50 pb-4 md:grid-cols-[180px_1fr] md:gap-6">
                <dt className="text-sm font-extrabold text-gray-800">Owner Name</dt>
                <dd className="m-0 text-sm leading-6 text-gray-500">{enquiry.owner}</dd>
              </div>
              <div className="grid gap-2 border-b border-blue-50 pb-4 md:grid-cols-[180px_1fr] md:gap-6">
                <dt className="text-sm font-extrabold text-gray-800">Enquiry Type</dt>
                <dd className="m-0 text-sm leading-6 text-gray-500">{enquiry.type}</dd>
              </div>
              <div className="grid gap-2 border-b border-blue-50 pb-4 md:grid-cols-[180px_1fr] md:gap-6">
                <dt className="text-sm font-extrabold text-gray-800">Owner email</dt>
                <dd className="m-0 text-sm leading-6 text-gray-500">{getOwnerEmailDisplay(enquiry)}</dd>
              </div>
              <div className="grid gap-2 border-b border-blue-50 pb-4 md:grid-cols-[180px_1fr] md:gap-6">
                <dt className="text-sm font-extrabold text-gray-800">Date sent</dt>
                <dd className="m-0 text-sm leading-6 text-gray-500">{enquiry.dateSent}</dd>
              </div>
              <div className="grid gap-2 border-b border-blue-50 pb-4 md:grid-cols-[180px_1fr] md:gap-6">
                <dt className="text-sm font-extrabold text-gray-800">Status</dt>
                <dd className="m-0 text-sm leading-6 text-gray-500">
                  {enquiry.status} - {getSentStatusDescription(enquiry.status)}
                </dd>
              </div>
              <div className="grid gap-2 md:grid-cols-[180px_1fr] md:gap-6">
                <dt className="text-sm font-extrabold text-gray-800">Message</dt>
                <dd className="m-0 text-sm leading-7 text-gray-500">{enquiry.message}</dd>
              </div>
            </dl>
          </section>

          <div className="mt-8 grid gap-8 lg:grid-cols-2">
            <ListingPreviewCard listing={enquiry.listing} title="Requested Listing" />
            <ListingPreviewCard listing={enquiry.offeredListing} title="Your Offered Listing" />
          </div>
        </div>
      </section>

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
    </main>
  )
}

export default SentEnquiryDetailPage
