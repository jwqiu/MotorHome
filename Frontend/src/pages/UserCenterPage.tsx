import { useEffect, useState } from 'react'
import {
  getSessionUserEmail,
  getSessionUserId,
  getSessionUserName,
  isIdentityVerified,
  isAuthenticated,
} from '../components/auth/authSession'
import { getProfile, updateIntroduction } from '../components/auth/profileApi'
import { cancelEnquiry, getUserEnquiries, type UserEnquiryItemResponse } from '../components/detail/enquiryApi'
import { listingFromEnquirySummary } from '../components/detail/enquiryListingMapper'
import { deleteListing, getOwnerListings } from '../components/listing/listingApi'
import type { Listing } from '../components/listing/listingData'
import Navbar from '../components/layout/Navbar'
import { getReceivedStatusDescription, type ReceivedEnquiry, type ReceivedEnquiryStatus } from '../components/userCenter/userCenterData'

type UserCenterTab = 'profile' | 'listings' | 'sent' | 'received'
type SentEnquiryStatus = 'Pending' | 'Agreed' | 'Declined' | 'Cancelled'
type SentEnquiry = {
  contactEmail?: string
  date: string
  id: number
  listing: Listing
  message: string
  offeredListing: Listing
  owner: string
  status: SentEnquiryStatus
  type: string
}
type ManageReceivedEnquiry = ReceivedEnquiry & {
  listingId: number
}

function UserCenterPage() {
  const [activeTab, setActiveTab] = useState<UserCenterTab>('profile')
  const [sentEnquiryItems, setSentEnquiryItems] = useState<SentEnquiry[]>([])
  const [receivedEnquiryItems, setReceivedEnquiryItems] = useState<ManageReceivedEnquiry[]>([])
  const [bio, setBio] = useState('Tell other members about your travel style, exchange preferences, and what makes you a reliable swap partner.')
  const [profileUserName, setProfileUserName] = useState(() => getSessionUserName())
  const [profileEmail, setProfileEmail] = useState(() => getSessionUserEmail())
  const [profileIdentityVerified, setProfileIdentityVerified] = useState(() => isIdentityVerified())
  const [comingSoonTarget, setComingSoonTarget] = useState('')
  const [comingSoonMessage, setComingSoonMessage] = useState('This feature is coming soon.')
  const [showProfileSaved, setShowProfileSaved] = useState(false)
  const [profileLoadMessage, setProfileLoadMessage] = useState('')
  const [profileSaveMessage, setProfileSaveMessage] = useState('')
  const [isSavingProfile, setIsSavingProfile] = useState(false)
  const [enquiryLoadMessage, setEnquiryLoadMessage] = useState('')
  const [cancellingEnquiryId, setCancellingEnquiryId] = useState<number | null>(null)
  const [userListings, setUserListings] = useState<Listing[]>([])
  const [listingLoadMessage, setListingLoadMessage] = useState('')
  const [listingDeleteMessage, setListingDeleteMessage] = useState('')
  const [listingToDelete, setListingToDelete] = useState<Listing | null>(null)
  const [isDeletingListing, setIsDeletingListing] = useState(false)
  const [showListingDeleted, setShowListingDeleted] = useState(false)
  const [showListingDeleteBlocked, setShowListingDeleteBlocked] = useState(false)
  const userId = getSessionUserId()

  useEffect(() => {
    let isActive = true

    if (!isAuthenticated() || !userId) {
      return () => {
        isActive = false
      }
    }

    setProfileLoadMessage('')

    getProfile(userId)
      .then((profile) => {
        if (!isActive) {
          return
        }

        setProfileUserName(profile.userName)
        setProfileEmail(profile.email)
        setProfileIdentityVerified(profile.identityVerified)
        setBio(profile.bio || '')
      })
      .catch((error) => {
        if (isActive) {
          setProfileLoadMessage(error instanceof Error ? error.message : 'Unable to load profile.')
        }
      })

    return () => {
      isActive = false
    }
  }, [userId])

  useEffect(() => {
    let isActive = true

    if (!isAuthenticated() || !userId) {
      return () => {
        isActive = false
      }
    }

    setEnquiryLoadMessage('')

    getUserEnquiries(userId)
      .then((response) => {
        if (!isActive) {
          return
        }

        setSentEnquiryItems(response.sent.map(mapSentEnquiry))
        setReceivedEnquiryItems(response.received.map(mapReceivedEnquiry))
      })
      .catch((error) => {
        if (isActive) {
          setEnquiryLoadMessage(error instanceof Error ? error.message : 'Unable to load enquiries.')
        }
      })

    return () => {
      isActive = false
    }
  }, [userId])

  useEffect(() => {
    let isActive = true

    if (!isAuthenticated() || !userId) {
      return () => {
        isActive = false
      }
    }

    setListingLoadMessage('')

    getOwnerListings(userId)
      .then((ownerListings) => {
        if (isActive) {
          setUserListings(ownerListings)
        }
      })
      .catch((error) => {
        if (isActive) {
          setListingLoadMessage(error instanceof Error ? error.message : 'Unable to load your listings.')
        }
      })

    return () => {
      isActive = false
    }
  }, [userId])

  const handleComingSoonClick = (target: string, message: string) => {
    setComingSoonMessage(message)
    setComingSoonTarget(target)
    window.setTimeout(() => setComingSoonTarget(''), 2600)
  }

  const handleProfileSave = () => {
    if (!userId) {
      setProfileSaveMessage('Please sign in before saving your profile.')
      return
    }

    setIsSavingProfile(true)
    setProfileSaveMessage('')
    setShowProfileSaved(false)

    updateIntroduction(userId, bio)
      .then((profile) => {
        setBio(profile.bio || '')
        setShowProfileSaved(true)
        window.setTimeout(() => setShowProfileSaved(false), 2200)
      })
      .catch((error) => {
        setProfileSaveMessage(error instanceof Error ? error.message : 'Unable to save introduction.')
      })
      .finally(() => setIsSavingProfile(false))
  }

  const getStatusDescription = (status: SentEnquiryStatus) => {
    switch (status) {
      case 'Pending':
        return 'Pending — waiting for owner decision'
      case 'Agreed':
        return 'Agreed — contact details available'
      case 'Declined':
        return 'Declined — owner declined this request'
      case 'Cancelled':
        return 'Cancelled — you cancelled this request'
    }
  }

  const handleCancelSentEnquiry = (enquiry: SentEnquiry) => {
    if (!userId) {
      setEnquiryLoadMessage('Please sign in before cancelling an enquiry.')
      return
    }

    setCancellingEnquiryId(enquiry.id)
    setEnquiryLoadMessage('')

    cancelEnquiry(enquiry.id, userId)
      .then(() => {
        setSentEnquiryItems((currentItems) => currentItems.map((item) => (
          item.id === enquiry.id
            ? { ...item, status: 'Cancelled' }
            : item
        )))
      })
      .catch((error) => {
        setEnquiryLoadMessage(error instanceof Error ? error.message : 'Unable to cancel enquiry.')
      })
      .finally(() => setCancellingEnquiryId(null))
  }

  const handleDeleteListing = () => {
    if (!listingToDelete || !userId) {
      return
    }

    setIsDeletingListing(true)
    setListingDeleteMessage('')

    deleteListing(listingToDelete.listingId, userId)
      .then((response) => {
        setUserListings((currentListings) => currentListings.filter((listing) => listing.listingId !== response.listingId))
        setShowListingDeleted(true)
        window.setTimeout(() => setShowListingDeleted(false), 3000)
        setListingToDelete(null)
      })
      .catch((error) => {
        const errorMessage = error instanceof Error ? error.message : 'Unable to delete listing.'
        if (errorMessage.includes('active exchange enquiries')) {
          setListingToDelete(null)
          setShowListingDeleteBlocked(true)
          window.setTimeout(() => setShowListingDeleteBlocked(false), 3000)
          return
        }

        setListingDeleteMessage(errorMessage)
      })
      .finally(() => setIsDeletingListing(false))
  }

  const getReceivedEnquiryCount = (listingId: number) => {
    return receivedEnquiryItems.filter((enquiry) => enquiry.listingId === listingId).length
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
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" className="size-16">
                          <path strokeLinecap="round" strokeLinejoin="round" d="M17.982 18.725A7.488 7.488 0 0 0 12 15.75a7.488 7.488 0 0 0-5.982 2.975m11.963 0a9 9 0 1 0-11.963 0m11.963 0A8.966 8.966 0 0 1 12 21a8.966 8.966 0 0 1-5.982-2.275M15 9.75a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
                        </svg>
                      </div>
                      <div className="relative inline-flex">
                        <button
                          aria-describedby={comingSoonTarget === 'avatar' ? 'avatar-hint' : undefined}
                          aria-disabled="true"
                          className="inline-flex h-11 cursor-not-allowed items-center justify-center rounded-4xl border border-gray-200 bg-gray-50 px-5 text-sm font-semibold text-gray-400 shadow-none transition hover:border-gray-200 hover:bg-gray-50"
                          onClick={() => handleComingSoonClick('avatar', 'Change avatar will be supported soon.')}
                          type="button"
                        >
                          Change avatar
                        </button>
                        {comingSoonTarget === 'avatar' ? (
                          <div
                            className="absolute left-0 bottom-[calc(100%+10px)] z-10 w-[230px] rounded-2xl bg-gray-800 px-4 py-3 text-xs leading-5 font-bold text-white shadow-lg shadow-gray-900/20"
                            id="avatar-hint"
                            role="status"
                          >
                            {comingSoonMessage}
                          </div>
                        ) : null}
                      </div>
                    </div>

                    <div className="grid gap-5">
                      <div className="grid gap-4 md:grid-cols-2">
                        <label className="grid gap-2 text-sm font-extrabold text-gray-700">
                          User name
                          <input className="h-12 rounded-3xl border border-blue-100 bg-gray-50 px-4 text-sm font-bold text-gray-500" readOnly value={profileUserName} />
                        </label>
                        <label className="grid gap-2 text-sm font-extrabold text-gray-700">
                          Bound email
                          <input className="h-12 rounded-3xl border border-blue-100 bg-gray-50 px-4 text-sm font-bold text-gray-500" readOnly value={profileEmail} />
                        </label>
                      </div>
                      {profileLoadMessage ? (
                        <p className="m-0 rounded-3xl bg-red-50 px-4 py-3 text-sm font-bold text-red-500">
                          {profileLoadMessage}
                        </p>
                      ) : null}
                      <div className="rounded-3xl border border-blue-100 bg-blue-50/50 px-5 py-4">
                        <div className="flex flex-wrap items-center justify-between gap-3">
                          <div>
                            <p className="m-0 text-sm font-extrabold text-gray-800">Identity verification</p>
                            {profileIdentityVerified ? (
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
                          {!profileIdentityVerified ? (
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
                          className="font-outfit h-12 cursor-pointer rounded-4xl border-0 bg-blue-500 px-8 text-sm font-extrabold text-white shadow-lg shadow-blue-200 transition hover:bg-blue-600 disabled:cursor-not-allowed disabled:bg-gray-300 disabled:shadow-none"
                          disabled={isSavingProfile}
                          onClick={handleProfileSave}
                          type="button"
                        >
                          {isSavingProfile ? 'Saving...' : 'Save'}
                        </button>
       
                      </div>
                      {profileSaveMessage ? (
                        <p className="m-0 rounded-3xl bg-red-50 px-4 py-3 text-sm font-bold text-red-500">
                          {profileSaveMessage}
                        </p>
                      ) : null}
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
                    <div>
                      <a
                        className="inline-flex h-12 items-center rounded-4xl border-0 bg-blue-500 px-6 text-sm font-extrabold text-white no-underline shadow-lg shadow-blue-200 transition hover:bg-blue-600"
                        href="/user-center/listings/new"
                      >
                        Add New Listing
                      </a>
                    </div>
                  </div>
                  {listingLoadMessage ? (
                    <p className="m-0 mb-4 rounded-3xl bg-red-50 px-4 py-3 text-sm font-bold text-red-500">
                      {listingLoadMessage}
                    </p>
                  ) : null}

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
                        {userListings.map((listing) => (
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
                            <td className="px-4 py-4">{getReceivedEnquiryCount(listing.listingId)}</td>
                            <td className="rounded-r-3xl px-4 py-4">
                              <div className="relative flex gap-3">
                                <div>
                                  <a
                                    className="text-sm font-bold text-blue-500 no-underline hover:text-blue-600"
                                    href={`/user-center/listings/${listing.id}/edit`}
                                  >
                                    Edit
                                  </a>
                                </div>
                                <div>
                                  <button
                                    className="cursor-pointer border-0 bg-transparent p-0 text-sm font-bold text-red-400 hover:text-red-500"
                                    onClick={() => {
                                      setListingDeleteMessage('')
                                      setListingToDelete(listing)
                                    }}
                                    type="button"
                                  >
                                    Delete
                                  </button>
                                </div>
                              </div>
                            </td>
                          </tr>
                        ))}
                        {userListings.length === 0 ? (
                          <tr>
                            <td className="rounded-3xl bg-blue-50/50 px-4 py-5 text-sm text-gray-400" colSpan={8}>
                              No listings connected to your account yet.
                            </td>
                          </tr>
                        ) : null}
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
                  {enquiryLoadMessage ? (
                    <p className="m-0 mb-4 rounded-3xl bg-red-50 px-4 py-3 text-sm font-bold text-red-500">
                      {enquiryLoadMessage}
                    </p>
                  ) : null}
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
                          <tr className="bg-blue-50/50 text-gray-600" key={enquiry.id}>
                            <td className="rounded-l-3xl px-4 py-4">
                              <a className=" text-blue-500 no-underline hover:text-blue-600" href={`/listings/${enquiry.listing.id}`}>
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
                                <a
                                  className="inline-flex h-9 items-center justify-center rounded-4xl border border-blue-100 bg-white px-4 text-xs  text-blue-600 no-underline transition hover:bg-blue-50"
                                  href={`/user-center/enquiries/sent/${enquiry.id}`}
                                  rel="noreferrer"
                                  target="_blank"
                                >
                                  View details
                                </a>
                                {enquiry.status === 'Pending' ? (
                                  <button
                                    className="h-9 cursor-pointer rounded-4xl border border-red-100 bg-red-50 px-4 text-xs font-extrabold text-red-500 transition hover:bg-red-100"
                                    disabled={cancellingEnquiryId === enquiry.id}
                                    onClick={() => handleCancelSentEnquiry(enquiry)}
                                    type="button"
                                  >
                                    {cancellingEnquiryId === enquiry.id ? 'Cancelling...' : 'Cancel request'}
                                  </button>
                                ) : null}
                              </div>
                            </td>
                          </tr>
                        ))}
                        {sentEnquiryItems.length === 0 ? (
                          <tr>
                            <td className="rounded-3xl bg-blue-50/50 px-4 py-5 text-sm text-gray-400" colSpan={6}>
                              No sent enquiries yet.
                            </td>
                          </tr>
                        ) : null}
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
                  {enquiryLoadMessage ? (
                    <p className="m-0 mb-4 rounded-3xl bg-red-50 px-4 py-3 text-sm font-bold text-red-500">
                      {enquiryLoadMessage}
                    </p>
                  ) : null}

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
                        {receivedEnquiryItems.map((enquiry) => (
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
                        {receivedEnquiryItems.length === 0 ? (
                          <tr>
                            <td className="rounded-3xl bg-blue-50/50 px-4 py-5 text-sm text-gray-400" colSpan={6}>
                              No received enquiries yet.
                            </td>
                          </tr>
                        ) : null}
                      </tbody>
                    </table>
                  </div>
                </section>
              ) : null}
            </div>
          </div>
        </div>
      </section>

      {listingToDelete ? (
        <div
          aria-labelledby="delete-listing-title"
          aria-modal="true"
          className="fixed inset-0 z-50 flex items-center justify-center bg-gray-900/40 px-6 backdrop-blur-sm"
          role="dialog"
        >
          <div className="w-full max-w-[520px] rounded-4xl bg-white p-8 shadow-2xl shadow-gray-900/20">
            <h2 id="delete-listing-title" className="font-outfit m-0 text-2xl font-extrabold text-gray-800">
              Delete listing?
            </h2>
            <p className="mt-4 mb-0 text-sm leading-6 text-gray-500">
              This will permanently delete "{listingToDelete.title}". Any enquiries connected to this listing,
              including received enquiries and enquiries where it was offered, will be deleted at the same time.
            </p>
            {listingDeleteMessage ? (
              <p className="mt-4 mb-0 rounded-3xl bg-red-50 px-4 py-3 text-sm font-bold text-red-500">
                {listingDeleteMessage}
              </p>
            ) : null}
            <div className="mt-7 flex justify-end gap-3">
              <button
                className="h-11 cursor-pointer rounded-4xl border border-blue-100 bg-white px-6 text-sm font-extrabold text-gray-500 shadow-md shadow-blue-100 disabled:cursor-not-allowed disabled:bg-gray-50 disabled:text-gray-300"
                disabled={isDeletingListing}
                onClick={() => {
                  setListingDeleteMessage('')
                  setListingToDelete(null)
                }}
                type="button"
              >
                Cancel
              </button>
              <button
                className="h-11 cursor-pointer rounded-4xl border-0 bg-red-500 px-6 text-sm font-extrabold text-white shadow-lg shadow-red-100 transition hover:bg-red-600 disabled:cursor-not-allowed disabled:bg-gray-300 disabled:shadow-none"
                disabled={isDeletingListing}
                onClick={handleDeleteListing}
                type="button"
              >
                {isDeletingListing ? 'Deleting...' : 'Confirm delete'}
              </button>
            </div>
          </div>
        </div>
      ) : null}
      {showListingDeleted ? (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-gray-900/15 px-6 backdrop-blur-sm">
          <div className="pointer-events-auto flex items-center justify-between gap-3 rounded-3xl border border-gray-100 bg-white px-6 py-4 text-center shadow-2xl shadow-gray-900/20">
            <p className="m-0 text-sm font-extrabold text-gray-900">Listing deleted successfully</p>
          </div>
        </div>
      ) : null}
      {showListingDeleteBlocked ? (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-gray-900/15 px-6 backdrop-blur-sm">
          <div className="pointer-events-auto relative flex max-w-[620px] items-start gap-4 rounded-3xl border border-gray-100 bg-white px-7 py-6 pr-14 text-left shadow-2xl shadow-gray-900/20">
            <button
              aria-label="Close delete warning"
              className="absolute top-4 right-4 cursor-pointer border-0 bg-transparent p-1 text-xl leading-none font-extrabold text-gray-300 transition hover:text-gray-500"
              onClick={() => setShowListingDeleteBlocked(false)}
              type="button"
            >
              x
            </button>
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.8} stroke="currentColor" className="mt-0.5 h-7 w-7 shrink-0 text-red-500">
              <path strokeLinecap="round" strokeLinejoin="round" d="M12 9v3.75m0 3.75h.008v.008H12V16.5Zm9-4.5a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z" />
            </svg>
            <div>
              <h2 className="m-0 text-lg leading-7 font-extrabold text-gray-900">Unable to Delete Listing</h2>
              <p className="mt-2 mb-0 text-sm leading-6 font-bold text-gray-700">
                This listing is linked to active exchange enquiries. Please complete, decline, or cancel the related enquiries before deleting it.
              </p>
            </div>
          </div>
        </div>
      ) : null}
    </main>
  )
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

function toReceivedStatus(status: string): ReceivedEnquiryStatus {
  if (status === 'Agreed' || status === 'Declined') {
    return status
  }

  return 'Pending'
}

function mapSentEnquiry(enquiry: UserEnquiryItemResponse): SentEnquiry {
  return {
    contactEmail: enquiry.counterpartyEmail,
    date: formatDate(enquiry.dateSent),
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

function mapReceivedEnquiry(enquiry: UserEnquiryItemResponse): ManageReceivedEnquiry {
  return {
    dateReceived: formatDate(enquiry.dateReceived || enquiry.dateSent),
    id: enquiry.id,
    listingId: enquiry.listingId,
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

export default UserCenterPage
