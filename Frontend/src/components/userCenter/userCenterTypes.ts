import type { Listing } from '../listing/listingData'
import type { ReceivedEnquiry, ReceivedEnquiryStatus } from './userCenterData'

export type UserCenterTab = 'profile' | 'listings' | 'sent' | 'received'

export type SentEnquiryStatus = 'Pending' | 'Agreed' | 'Declined' | 'Cancelled'

export type SentEnquiry = {
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

export type ManageReceivedEnquiry = ReceivedEnquiry & {
  listingId: number
}

export type { ReceivedEnquiryStatus }
