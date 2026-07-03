import { useState } from 'react'
import {
  getSessionUserEmail,
  getSessionUserName,
  isIdentityVerified,
  isAuthenticated,
} from '../components/auth/authSession'
import { listings } from '../components/listing/listingData'
import Navbar from '../components/layout/Navbar'
import { getReceivedStatusDescription, receivedEnquiries } from '../components/userCenter/userCenterData'

type UserCenterTab = 'profile' | 'listings' | 'sent' | 'received'
type SentEnquiryStatus = 'Pending' | 'Agreed' | 'Declined' | 'Cancelled'
type SentEnquiry = {
  contactEmail?: string
  date: string
  listing: (typeof listings)[number]
  message: string
  offeredListing: (typeof listings)[number]
  owner: string
  ownerResponse: string
  status: SentEnquiryStatus
  type: string
}

const initialSentEnquiries: SentEnquiry[] = [
  {
    contactEmail: undefined,
    date: '22 Jun',
    listing: listings[0],
    message: 'I would love to discuss a direct exchange for our upcoming trip.',
    offeredListing: listings[1],
    owner: 'suebirdnz',
    ownerResponse: 'No response yet.',
    status: 'Pending',
    type: 'Direct Exchange',
  },
  {
    contactEmail: 'john@example.com',
    date: '18 Apr',
    listing: listings[2],
    message: 'Your camper looks like a great fit for our route and travel dates.',
    offeredListing: listings[0],
    owner: 'John',
    ownerResponse: 'Happy to discuss details. Please contact me by email.',
    status: 'Agreed',
    type: 'Direct Exchange',
  },
  {
    contactEmail: undefined,
    date: '09 Mar',
    listing: listings[3],
    message: 'We were hoping to arrange a short non-simultaneous swap.',
    offeredListing: listings[1],
    owner: 'Mia',
    ownerResponse: 'Sorry, those dates will not work for us.',
    status: 'Declined',
    type: 'Direct Exchange',
  },
]

function UserCenterPage() {
  const [activeTab, setActiveTab] = useState<UserCenterTab>('profile')
  const [sentEnquiryItems, setSentEnquiryItems] = useState(initialSentEnquiries)
  const [selectedSentEnquiry, setSelectedSentEnquiry] = useState<SentEnquiry | null>(null)
  const [avatarPreview, setAvatarPreview] = useState('')
  const [bio, setBio] = useState('Tell other members about your travel style, exchange preferences, and what makes you a reliable swap partner.')
  const [comingSoonTarget, setComingSoonTarget] = useState('')
  const [comingSoonMessage, setComingSoonMessage] = useState('This feature is coming soon.')
  const [showProfileSaved, setShowProfileSaved] = useState(false)
  const userName = getSessionUserName()
  const userEmail = getSessionUserEmail()
  const isVerified = isIdentityVerified()
  const userListings = listings.slice(0, 2)

  const handleAvatarChange = (file: File | undefined) => {
    if (!file) {
      return
    }

    setAvatarPreview(URL.createObjectURL(file))
  }

  const handleComingSoonClick = (target: string, message: string) => {
    setComingSoonMessage(message)
    setComingSoonTarget(target)
    window.setTimeout(() => setComingSoonTarget(''), 2600)
  }

  const handleProfileSave = () => {
    setShowProfileSaved(true)
    window.setTimeout(() => setShowProfileSaved(false), 2200)
  }

  const getStatusDescription = (status: SentEnquiryStatus) => {
    switch (status) {
      case 'Pending':
        return 'Pending — waiting for owner response'
      case 'Agreed':
        return 'Agreed — contact details available'
      case 'Declined':
        return 'Declined — owner declined this request'
      case 'Cancelled':
        return 'Cancelled — you cancelled this request'
    }
  }

  const handleCancelSentEnquiry = (enquiry: SentEnquiry) => {
    setSentEnquiryItems((currentItems) => currentItems.map((item) => (
      item.listing.id === enquiry.listing.id && item.date === enquiry.date
        ? { ...item, ownerResponse: 'You cancelled this request before the owner accepted it.', status: 'Cancelled' }
        : item
    )))
  }

  const getContactDetailsText = (enquiry: SentEnquiry) => {
    if (enquiry.status === 'Agreed') {
      return `Email: ${enquiry.contactEmail}`
    }

    if (enquiry.status === 'Declined') {
      return 'Contact details are not available because the owner declined this request.'
    }

    if (enquiry.status === 'Cancelled') {
      return 'Contact details are not available because you cancelled this request.'
    }

    return 'Available after the owner agrees.'
  }

  if (!isAuthenticated()) {
    window.location.href = '/sign-in?returnTo=/user-center'
    return null
  }

  return (
    <main className="min-h-screen bg-blue-50 font-sans text-gray-600 antialiased">
      <Navbar variant="solid" />

      <section className="px-6 pt-40 pb-16 md:px-16 md:pt-44">
        <div className="mx-auto max-w-[1280px]">
          <div className="mb-10">
            <p className="mb-3 text-sm font-extrabold tracking-[0.18em] text-blue-500 uppercase">
              User Center
            </p>
            <h1 className="font-outfit m-0 text-4xl leading-tight font-extrabold text-gray-800 md:text-5xl">
              Manage your exchange activity.
            </h1>
          </div>

          <div className="grid gap-8 lg:grid-cols-[300px_minmax(0,1fr)]">
            <aside className="self-start rounded-4xl bg-white p-5 shadow-lg shadow-blue-100 lg:sticky lg:top-32">
              <nav className="grid gap-2" aria-label="User center navigation">
                <button
                  className={`h-12 cursor-pointer rounded-3xl border-0 px-5 text-left text-sm font-extrabold transition ${
                    activeTab === 'profile' ? 'bg-blue-50 text-blue-600' : 'bg-white text-gray-500 hover:bg-blue-50'
                  }`}
                  onClick={() => setActiveTab('profile')}
                  type="button"
                >
                  Profile
                </button>
                <button
                  className={`h-12 cursor-pointer rounded-3xl border-0 px-5 text-left text-sm font-extrabold transition ${
                    activeTab === 'listings' ? 'bg-blue-50 text-blue-600' : 'bg-white text-gray-500 hover:bg-blue-50'
                  }`}
                  onClick={() => setActiveTab('listings')}
                  type="button"
                >
                  Manage Listings
                </button>
                <div className="mt-2 border-t border-blue-50 pt-4">
                  <p className="m-0 px-5 pb-2 text-xs font-extrabold tracking-[0.12em] text-gray-400 uppercase">
                    Enquiries
                  </p>
                  <button
                    className={`h-12 w-full cursor-pointer rounded-3xl border-0 px-5 text-left text-sm font-extrabold transition ${
                      activeTab === 'sent' ? 'bg-blue-50 text-blue-600' : 'bg-white text-gray-500 hover:bg-blue-50'
                    }`}
                    onClick={() => setActiveTab('sent')}
                    type="button"
                  >
                    Sent Enquiries
                  </button>
                  <button
                    className={`h-12 w-full cursor-pointer rounded-3xl border-0 px-5 text-left text-sm font-extrabold transition ${
                      activeTab === 'received' ? 'bg-blue-50 text-blue-600' : 'bg-white text-gray-500 hover:bg-blue-50'
                    }`}
                    onClick={() => setActiveTab('received')}
                    type="button"
                  >
                    Received Enquiries
                  </button>
                </div>
                <div className="relative mt-2 border-t border-blue-50 pt-4">
                  <button
                    aria-describedby={comingSoonTarget === 'membership' ? 'membership-hint' : undefined}
                    className="h-12 w-full cursor-not-allowed rounded-3xl border-0 bg-white px-5 text-left text-sm font-extrabold text-gray-300 transition hover:bg-gray-50"
                    onClick={() => handleComingSoonClick('membership', 'Membership is coming soon.')}
                    type="button"
                  >
                    Membership
                  </button>
                  {comingSoonTarget === 'membership' ? (
                    <div
                      className="absolute left-5 bottom-[calc(100%+10px)] z-10 w-[220px] rounded-2xl bg-gray-800 px-4 py-3 text-xs leading-5 font-bold text-white shadow-lg shadow-gray-900/20"
                      id="membership-hint"
                      role="status"
                    >
                      {comingSoonMessage}
                    </div>
                  ) : null}
                </div>
              </nav>
            </aside>

            <div className="min-w-0">
              {activeTab === 'profile' ? (
                <section className="rounded-4xl bg-white p-12 shadow-lg shadow-blue-100 ">
                  <h2 className="font-outfit m-0 mb-6 text-3xl font-extrabold text-gray-800">Profile</h2>
                  <div className="grid gap-8 xl:grid-cols-[220px_1fr]">
                    <div>
                      <div className="mb-4 flex h-36 w-36 items-center justify-center overflow-hidden rounded-full bg-blue-50 text-4xl font-extrabold text-blue-500">
                        {avatarPreview ? (
                          <img alt="" className="h-full w-full object-cover" src={avatarPreview} />
                        ) : (
                          <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" className="size-16">
                            <path strokeLinecap="round" strokeLinejoin="round" d="M17.982 18.725A7.488 7.488 0 0 0 12 15.75a7.488 7.488 0 0 0-5.982 2.975m11.963 0a9 9 0 1 0-11.963 0m11.963 0A8.966 8.966 0 0 1 12 21a8.966 8.966 0 0 1-5.982-2.275M15 9.75a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
                          </svg>
                        )}
                      </div>
                      <label className="inline-flex h-11 cursor-pointer items-center justify-center rounded-4xl border border-blue-200 bg-white px-5 text-sm font-semibold text-gray-600 transition hover:bg-blue-100">
                        Change avatar
                        <input
                          accept="image/*"
                          className="sr-only"
                          onChange={(event) => handleAvatarChange(event.target.files?.[0])}
                          type="file"
                        />
                      </label>
                    </div>

                    <div className="grid gap-5">
                      <div className="grid gap-4 md:grid-cols-2">
                        <label className="grid gap-2 text-sm font-extrabold text-gray-700">
                          User name
                          <input className="h-12 rounded-3xl border border-blue-100 bg-gray-50 px-4 text-sm font-bold text-gray-500" readOnly value={userName} />
                        </label>
                        <label className="grid gap-2 text-sm font-extrabold text-gray-700">
                          Bound email
                          <input className="h-12 rounded-3xl border border-blue-100 bg-gray-50 px-4 text-sm font-bold text-gray-500" readOnly value={userEmail} />
                        </label>
                      </div>
                      <div className="rounded-3xl border border-blue-100 bg-blue-50/50 px-5 py-4">
                        <div className="flex flex-wrap items-center justify-between gap-3">
                          <div>
                            <p className="m-0 text-sm font-extrabold text-gray-800">Identity verification</p>
                            {isVerified ? (
                              <p className="mt-2 mb-0 flex items-center gap-2 text-sm font-bold text-blue-600">
                                <span className="inline-flex h-5 w-5 items-center justify-center rounded-full bg-blue-500 text-white" aria-hidden="true">
                                  <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={2.5} stroke="currentColor" className="h-3.5 w-3.5">
                                    <path strokeLinecap="round" strokeLinejoin="round" d="m4.5 12.75 6 6 9-13.5" />
                                  </svg>
                                </span>
                                Verified
                              </p>
                            ) : (
                              <p className="mt-2 mb-0 text-sm text-gray-500">Not verified</p>
                            )}
                          </div>
                          {!isVerified ? (
                            <a
                              className="inline-flex h-11 items-center justify-center rounded-4xl border border-blue-100 bg-white px-5 text-sm font-extrabold text-blue-600 no-underline transition hover:bg-blue-50"
                              href="/identity-verification"
                            >
                              Verify now
                            </a>
                          ) : null}
                        </div>
                      </div>
                      <label className="grid gap-2 text-sm font-extrabold text-gray-700">
                        About me
                        <textarea
                          className="min-h-40 resize-none rounded-3xl border border-blue-100 px-4 py-3 font-normal text-sm leading-6  text-gray-700 outline-none focus:border-blue-400"
                          onChange={(event) => setBio(event.target.value)}
                          value={bio}
                        />
                      </label>
                      <div className="flex flex-col items-start  gap-3">
                        <p className="m-0 text-xs text-gray-400">
                          Save your avatar and introduction changes before leaving this page.
                        </p>
                        <button
                          className="font-outfit h-12 cursor-pointer rounded-4xl border-0 bg-blue-500 px-8 text-sm font-extrabold text-white shadow-lg shadow-blue-200 transition hover:bg-blue-600"
                          onClick={handleProfileSave}
                          type="button"
                        >
                          Save
                        </button>
       
                      </div>
                      {showProfileSaved ? (
                        <p className="m-0 rounded-3xl bg-blue-50 px-4 py-3 text-sm font-bold text-blue-600">
                          Profile changes saved.
                        </p>
                      ) : null}
                    </div>
                  </div>
                </section>
              ) : null}

              {activeTab === 'listings' ? (
                <section className="rounded-4xl bg-white p-7 shadow-lg shadow-blue-100 md:p-8">
                  <div className="mb-6 flex flex-wrap items-center justify-between gap-4">
                    <div>
                      <h2 className="font-outfit m-0 text-3xl font-extrabold text-gray-800">Manage Listings</h2>
                      <p className="mt-2 mb-0 text-sm text-gray-400">Published listings connected to your account.</p>
                    </div>
                    <div className="relative">
                      <button
                        aria-describedby={comingSoonTarget === 'add-listing' ? 'add-listing-hint' : undefined}
                        className="h-12 cursor-not-allowed rounded-4xl border border-gray-100 bg-gray-50 px-6 text-sm font-extrabold text-gray-300"
                        onClick={() => handleComingSoonClick('add-listing', 'Add listing is coming soon.')}
                        type="button"
                      >
                        Add New Listing
                      </button>
                      {comingSoonTarget === 'add-listing' ? (
                        <div
                          className="absolute right-0 bottom-[calc(100%+10px)] z-10 w-[220px] rounded-2xl bg-gray-800 px-4 py-3 text-xs leading-5 font-bold text-white shadow-lg shadow-gray-900/20"
                          id="add-listing-hint"
                          role="status"
                        >
                          {comingSoonMessage}
                        </div>
                      ) : null}
                    </div>
                  </div>

                  <div className="overflow-x-auto">
                    <table className="w-full min-w-[760px] border-separate border-spacing-y-3 text-left text-sm">
                      <thead>
                        <tr className="text-gray-400">
                          <th className="px-4 py-3">Title</th>
                          <th className="px-4 py-3">Category</th>
                          <th className="px-4 py-3">Location</th>
                          <th className="px-4 py-3">Available For</th>
                          <th className="px-4 py-3">Created</th>
                          <th className="px-4 py-3">Status</th>
                          <th className="px-4 py-3">Enquiries</th>
                          <th className="px-4 py-3">Action</th>
                        </tr>
                      </thead>
                      <tbody>
                        {userListings.map((listing, index) => (
                          <tr className="bg-blue-50/50 text-gray-600" key={listing.id}>
                            <td className="rounded-l-3xl px-4 py-4">
                              <a className="font-extrabold text-blue-500 no-underline hover:text-blue-600" href={`/listings/${listing.id}`}>
                                {listing.title}
                              </a>
                            </td>
                            <td className="px-4 py-4">{listing.listingType}</td>
                            <td className="px-4 py-4">{listing.currentLocation}</td>
                            <td className="px-4 py-4">{listing.exchangeTypes.join(', ')}</td>
                            <td className="px-4 py-4">{listing.createdAt}</td>
                            <td className="px-4 py-4">Active</td>
                            <td className="px-4 py-4">{index + 1}</td>
                            <td className="rounded-r-3xl px-4 py-4">
                              <div className="relative flex gap-3">
                                <div className="relative">
                                  <button
                                    aria-describedby={comingSoonTarget === `edit-${listing.id}` ? `edit-${listing.id}-hint` : undefined}
                                    className="cursor-not-allowed border-0 bg-transparent p-0 text-sm  text-gray-300"
                                    onClick={() => handleComingSoonClick(`edit-${listing.id}`, 'Edit listing is coming soon.')}
                                    type="button"
                                  >
                                    Edit
                                  </button>
                                  {comingSoonTarget === `edit-${listing.id}` ? (
                                    <div
                                      className="absolute right-0 bottom-[calc(100%+10px)] z-10 w-[220px] rounded-2xl bg-gray-800 px-4 py-3 text-xs leading-5 font-bold text-white shadow-lg shadow-gray-900/20"
                                      id={`edit-${listing.id}-hint`}
                                      role="status"
                                    >
                                      {comingSoonMessage}
                                    </div>
                                  ) : null}
                                </div>
                                <div className="relative">
                                  <button
                                    aria-describedby={comingSoonTarget === `delete-${listing.id}` ? `delete-${listing.id}-hint` : undefined}
                                    className="cursor-not-allowed border-0 bg-transparent p-0 text-sm  text-gray-300"
                                    onClick={() => handleComingSoonClick(`delete-${listing.id}`, 'Delete listing is coming soon.')}
                                    type="button"
                                  >
                                    Delete
                                  </button>
                                  {comingSoonTarget === `delete-${listing.id}` ? (
                                    <div
                                      className="absolute right-0 bottom-[calc(100%+10px)] z-10 w-[220px] rounded-2xl bg-gray-800 px-4 py-3 text-xs leading-5 font-bold text-white shadow-lg shadow-gray-900/20"
                                      id={`delete-${listing.id}-hint`}
                                      role="status"
                                    >
                                      {comingSoonMessage}
                                    </div>
                                  ) : null}
                                </div>
                              </div>
                            </td>
                          </tr>
                        ))}
                      </tbody>
                    </table>
                  </div>
                </section>
              ) : null}

              {activeTab === 'sent' ? (
                <section className="rounded-4xl bg-white p-7 shadow-lg shadow-blue-100 md:p-8">
                  <h2 className="font-outfit m-0 mb-2 text-3xl font-extrabold text-gray-800">
                    Sent Enquiries
                  </h2>
                  <p className="mt-0 mb-6 text-sm text-gray-400">
                    Track your outgoing swap requests and follow up when an owner responds.
                  </p>
                  <div className="overflow-x-auto">
                    <table className="w-full min-w-[920px] border-separate border-spacing-y-3 text-left text-sm">
                      <thead>
                        <tr className="text-gray-400">
                          <th className="px-4 py-3">Listing</th>
                          <th className="px-4 py-3">Owner</th>
                          <th className="px-4 py-3">Type</th>
                          <th className="px-4 py-3">Date sent</th>
                          <th className="px-4 py-3">Status</th>
                          <th className="px-4 py-3">Actions</th>
                        </tr>
                      </thead>
                      <tbody>
                        {sentEnquiryItems.map((enquiry) => (
                          <tr className="bg-blue-50/50 text-gray-600" key={`${enquiry.listing.id}-${enquiry.date}`}>
                            <td className="rounded-l-3xl px-4 py-4">
                              <a className="font-extrabold text-blue-500 no-underline hover:text-blue-600" href={`/listings/${enquiry.listing.id}`}>
                                {enquiry.listing.title}
                              </a>
                            </td>
                            <td className="px-4 py-4">{enquiry.owner}</td>
                            <td className="px-4 py-4">{enquiry.type}</td>
                            <td className="px-4 py-4">{enquiry.date}</td>
                            <td className="px-4 py-4">
                              <span className="block font-extrabold text-gray-700">{enquiry.status}</span>
                              <span className="block max-w-[230px] text-xs leading-5 text-gray-400">
                                {getStatusDescription(enquiry.status)}
                              </span>
                            </td>
                            <td className="rounded-r-3xl px-4 py-4">
                              <div className="flex flex-wrap gap-2">
                                <button
                                  className="h-9 cursor-pointer rounded-4xl border border-blue-100 bg-white px-4 text-xs font-extrabold text-blue-600 transition hover:bg-blue-50"
                                  onClick={() => setSelectedSentEnquiry(enquiry)}
                                  type="button"
                                >
                                  View details
                                </button>
                                {enquiry.status === 'Pending' ? (
                                  <button
                                    className="h-9 cursor-pointer rounded-4xl border border-red-100 bg-red-50 px-4 text-xs font-extrabold text-red-500 transition hover:bg-red-100"
                                    onClick={() => handleCancelSentEnquiry(enquiry)}
                                    type="button"
                                  >
                                    Cancel request
                                  </button>
                                ) : null}
                              </div>
                            </td>
                          </tr>
                        ))}
                      </tbody>
                    </table>
                  </div>
                </section>
              ) : null}

              {activeTab === 'received' ? (
                <section className="rounded-4xl bg-white p-7 shadow-lg shadow-blue-100 md:p-8">
                  <h2 className="font-outfit m-0 mb-2 text-3xl font-extrabold text-gray-800">
                    Received Enquiries
                  </h2>
                  <p className="mt-0  text-sm text-gray-400">
                    * Review incoming swap requests and decide whether to continue the discussion.
                  </p>
                  <p className="mt-0 mb-6 text-sm text-gray-400">
                    * Once you accept an enquiry and agree to discuss, your email address will be shared with the enquirer so they can contact you directly for more details.
                  </p>

                  <div className="overflow-x-auto">
                    <table className="w-full min-w-[920px] border-separate border-spacing-y-3 text-left text-sm">
                      <thead>
                        <tr className="text-gray-400">
                          <th className="px-4 py-3">Listing</th>
                          <th className="px-4 py-3">Sender</th>
                          <th className="px-4 py-3">Type</th>
                          <th className="px-4 py-3">Date received</th>
                          <th className="px-4 py-3">Status</th>
                          <th className="px-4 py-3">Actions</th>
                        </tr>
                      </thead>
                      <tbody>
                        {receivedEnquiries.map((enquiry) => (
                          <tr className="bg-blue-50/50 text-gray-600" key={enquiry.id}>
                            <td className="rounded-l-3xl px-4 py-4">
                              <a className="font-extrabold text-blue-500 no-underline hover:text-blue-600" href={`/listings/${enquiry.yourListing.id}`}>
                                {enquiry.yourListing.title}
                              </a>
                            </td>
                            <td className="px-4 py-4">{enquiry.senderName}</td>
                            <td className="px-4 py-4">{enquiry.type}</td>
                            <td className="px-4 py-4">{enquiry.dateReceived}</td>
                            <td className="px-4 py-4">
                              <span className="block font-extrabold text-gray-700">{enquiry.status}</span>
                              <span className="block max-w-[220px] text-xs leading-5 text-gray-400">
                                {getReceivedStatusDescription(enquiry.status)}
                              </span>
                            </td>
                            <td className="rounded-r-3xl px-4 py-4">
                              <a
                                className="inline-flex h-9 items-center justify-center rounded-4xl border border-blue-100 bg-white px-4 text-xs font-extrabold text-blue-600 no-underline transition hover:bg-blue-50"
                                href={`/user-center/enquiries/received/${enquiry.id}`}
                                rel="noreferrer"
                                target="_blank"
                              >
                                View details
                              </a>
                            </td>
                          </tr>
                        ))}
                      </tbody>
                    </table>
                  </div>
                </section>
              ) : null}
            </div>
          </div>
        </div>
      </section>

      {selectedSentEnquiry ? (
        <div
          aria-labelledby="sent-enquiry-detail-title"
          aria-modal="true"
          className="fixed inset-0 z-40 flex items-center justify-center bg-gray-900/40 px-6 backdrop-blur-sm"
          role="dialog"
        >
          <div className="max-h-[88vh] w-full max-w-[980px] overflow-y-auto rounded-4xl bg-white p-7 shadow-2xl shadow-gray-900/20 md:p-8">
            <div className="mb-6 flex items-start justify-between gap-6">
              <div>
                <p className="mb-2 text-xs font-extrabold tracking-[0.16em] text-blue-500 uppercase">
                  Enquiry details
                </p>
                <h2 id="sent-enquiry-detail-title" className="font-outfit m-0 text-2xl font-extrabold text-gray-800">
                  {selectedSentEnquiry.listing.title}
                </h2>
              </div>
              <button
                aria-label="Close enquiry details"
                className="flex h-10 w-10 shrink-0 cursor-pointer items-center justify-center rounded-full border border-blue-100 bg-blue-50 text-xl font-bold text-gray-700"
                onClick={() => setSelectedSentEnquiry(null)}
                type="button"
              >
                x
              </button>
            </div>

            <div className="grid gap-4">
              <div className="grid gap-4 lg:grid-cols-2">
                <section className="rounded-3xl border border-blue-100 px-4 py-4">
                  <h3 className="font-outfit m-0 mb-3 text-base font-extrabold text-gray-800">Owner and listing</h3>
                  <dl className="m-0 grid gap-3">
                    <div className="grid gap-1 sm:grid-cols-[120px_1fr]">
                      <dt className="text-sm font-extrabold text-gray-700">Listing title</dt>
                      <dd className="m-0 text-sm">
                        <a className="font-extrabold text-blue-500 no-underline hover:text-blue-600" href={`/listings/${selectedSentEnquiry.listing.id}`}>
                          {selectedSentEnquiry.listing.title}
                        </a>
                      </dd>
                    </div>
                    <div className="grid gap-1 sm:grid-cols-[120px_1fr]">
                      <dt className="text-sm font-extrabold text-gray-700">Owner</dt>
                      <dd className="m-0 text-sm text-gray-600">{selectedSentEnquiry.owner}</dd>
                    </div>
                  </dl>

                  <div className="mt-5 rounded-3xl bg-gray-50 px-4 py-4">
                    <h4 className="font-outfit m-0 mb-3 text-sm font-extrabold text-gray-800">Owner looking for</h4>
                    <div className="grid gap-4">
                      <div>
                        <p className="m-0 mb-2 text-xs font-extrabold tracking-[0.1em] text-gray-400 uppercase">
                          Wanted destinations
                        </p>
                        <div className="flex flex-wrap gap-2">
                          {selectedSentEnquiry.listing.wantedDestinations.map((destination) => (
                            <span className="rounded-4xl border border-gray-200 bg-white px-3 py-1.5 text-xs text-gray-600" key={destination}>
                              {destination}
                            </span>
                          ))}
                        </div>
                      </div>
                      <div>
                        <p className="m-0 mb-2 text-xs font-extrabold tracking-[0.1em] text-gray-400 uppercase">
                          Wanted assets
                        </p>
                        <div className="flex flex-wrap gap-2">
                          {selectedSentEnquiry.listing.wantedAssets.map((asset) => (
                            <span className="rounded-4xl border border-gray-200 bg-white px-3 py-1.5 text-xs text-gray-600" key={asset}>
                              {asset}
                            </span>
                          ))}
                        </div>
                      </div>
                    </div>
                  </div>
                </section>

                <section className="rounded-3xl border border-blue-100 px-4 py-4">
                  <h3 className="font-outfit m-0 mb-3 text-base font-extrabold text-gray-800">Your side</h3>
                  <div className="grid gap-4">
                    <div className="grid gap-1 sm:grid-cols-[120px_1fr]">
                      <span className="text-sm font-extrabold text-gray-700">Your offer</span>
                      <a className="text-sm font-extrabold text-blue-500 no-underline hover:text-blue-600" href={`/listings/${selectedSentEnquiry.offeredListing.id}`}>
                        {selectedSentEnquiry.offeredListing.title}
                      </a>
                    </div>
                    <div>
                      <h4 className="font-outfit m-0 mb-2 text-sm font-extrabold text-gray-800">Your message</h4>
                      <p className="m-0 text-sm leading-6 text-gray-500">{selectedSentEnquiry.message}</p>
                    </div>
                  </div>
                </section>
              </div>

              <section className="rounded-3xl bg-blue-50 px-4 py-4">
                <h3 className="font-outfit m-0 mb-3 text-base font-extrabold text-gray-800">Request status</h3>
                <div className="grid gap-4 lg:grid-cols-3">
                  <div>
                    <p className="m-0 mb-1 text-xs font-extrabold tracking-[0.1em] text-gray-400 uppercase">Status</p>
                    <p className="m-0 text-sm leading-6 text-gray-600">{getStatusDescription(selectedSentEnquiry.status)}</p>
                  </div>
                  <div>
                    <p className="m-0 mb-1 text-xs font-extrabold tracking-[0.1em] text-gray-400 uppercase">Owner response</p>
                    <p className="m-0 text-sm leading-6 text-gray-600">{selectedSentEnquiry.ownerResponse}</p>
                  </div>
                  <div>
                    <p className="m-0 mb-1 text-xs font-extrabold tracking-[0.1em] text-gray-400 uppercase">Contact details</p>
                    <p className="m-0 text-sm leading-6 text-gray-600">
                      {getContactDetailsText(selectedSentEnquiry)}
                    </p>
                  </div>
                </div>
              </section>
            </div>
          </div>
        </div>
      ) : null}
    </main>
  )
}

export default UserCenterPage
