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
import DeleteListingDialog from '../components/userCenter/DeleteListingDialog'
import ListingDeleteNotifications from '../components/userCenter/ListingDeleteNotifications'
import ManageListingsPanel from '../components/userCenter/ManageListingsPanel'
import ProfilePanel from '../components/userCenter/ProfilePanel'
import ReceivedEnquiriesPanel from '../components/userCenter/ReceivedEnquiriesPanel'
import SentEnquiriesPanel from '../components/userCenter/SentEnquiriesPanel'
import UserCenterSidebar from '../components/userCenter/UserCenterSidebar'
import type {
  ManageReceivedEnquiry,
  ReceivedEnquiryStatus,
  SentEnquiry,
  SentEnquiryStatus,
  UserCenterTab,
} from '../components/userCenter/userCenterTypes'

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
            <UserCenterSidebar
              activeTab={activeTab}
              comingSoonMessage={comingSoonMessage}
              comingSoonTarget={comingSoonTarget}
              onComingSoonClick={handleComingSoonClick}
              onTabChange={setActiveTab}
            />

            <div className="min-w-0">
              {activeTab === 'profile' ? (
                <ProfilePanel
                  bio={bio}
                  comingSoonMessage={comingSoonMessage}
                  comingSoonTarget={comingSoonTarget}
                  isSavingProfile={isSavingProfile}
                  onBioChange={setBio}
                  onComingSoonClick={handleComingSoonClick}
                  onSave={handleProfileSave}
                  profileEmail={profileEmail}
                  profileIdentityVerified={profileIdentityVerified}
                  profileLoadMessage={profileLoadMessage}
                  profileSaveMessage={profileSaveMessage}
                  profileUserName={profileUserName}
                  showProfileSaved={showProfileSaved}
                />
              ) : null}

              {activeTab === 'listings' ? (
                <ManageListingsPanel
                  getReceivedEnquiryCount={getReceivedEnquiryCount}
                  listingLoadMessage={listingLoadMessage}
                  onRequestDelete={(listing) => {
                    setListingDeleteMessage('')
                    setListingToDelete(listing)
                  }}
                  userListings={userListings}
                />
              ) : null}

              {activeTab === 'sent' ? (
                <SentEnquiriesPanel
                  cancellingEnquiryId={cancellingEnquiryId}
                  enquiryLoadMessage={enquiryLoadMessage}
                  getStatusDescription={getStatusDescription}
                  onCancelSentEnquiry={handleCancelSentEnquiry}
                  sentEnquiryItems={sentEnquiryItems}
                />
              ) : null}

              {activeTab === 'received' ? (
                <ReceivedEnquiriesPanel
                  enquiryLoadMessage={enquiryLoadMessage}
                  receivedEnquiryItems={receivedEnquiryItems}
                />
              ) : null}
            </div>
          </div>
        </div>
      </section>

      <DeleteListingDialog
        isDeletingListing={isDeletingListing}
        listingDeleteMessage={listingDeleteMessage}
        listingToDelete={listingToDelete}
        onCancel={() => {
          setListingDeleteMessage('')
          setListingToDelete(null)
        }}
        onConfirm={handleDeleteListing}
      />
      <ListingDeleteNotifications
        onCloseBlocked={() => setShowListingDeleteBlocked(false)}
        showListingDeleted={showListingDeleted}
        showListingDeleteBlocked={showListingDeleteBlocked}
      />
    </main>
  )
}

function getStatusDescription(status: SentEnquiryStatus) {
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
