import { apiFetch } from '../api/apiClient'

type EnquiryResponse = {
  id: number
  listingId: number
  message: string
  offeredListingId?: number
  ownerResponse?: string
  receiverEmail?: string
  senderEmail?: string
  status: string
}

type ErrorResponse = {
  message?: string
}

export type UserEnquiryListing = {
  availableFrom?: string
  availableTo?: string
  category: string
  city: string
  country: string
  createdAt: string
  currentLocation: string
  description: string
  exchangeMethod: string
  exchangeTimings: string[]
  exchangeTypes: string[]
  id: string
  imageLabel?: string
  listingId: number
  listingType: string
  title: string
  wantedAssets: string[]
  wantedDestinations: string[]
}

export type ExchangeListingResponse = UserEnquiryListing

export type UserEnquiryItemResponse = {
  counterpartyEmail?: string
  counterpartyName: string
  dateReceived?: string
  dateSent?: string
  enquiryType: string
  id: number
  listing?: UserEnquiryListing
  listingId: number
  message: string
  offeredListing?: UserEnquiryListing
  offeredListingId?: number
  ownerResponse?: string
  status: string
}

export type UserEnquiriesResponse = {
  received: UserEnquiryItemResponse[]
  sent: UserEnquiryItemResponse[]
}

type EnquiryStatusResponse = {
  hasPendingEnquiry: boolean
}

type SubmitEnquiryRequest = {
  disclaimerAccepted: boolean
  enquiryType: string
  listingId: number
  message: string
  offeredListingId?: number
  senderId: string
  senderName: string
}

export async function submitEnquiry(payload: SubmitEnquiryRequest) {
  const response = await apiFetch('/api/enquiries', {
    body: JSON.stringify(payload),
    headers: {
      'Content-Type': 'application/json',
    },
    method: 'POST',
  })

  if (!response.ok) {
    let errorMessage = response.status === 502 || response.status === 504
      ? 'Enquiry service is unavailable. Please make sure the backend is running.'
      : 'Unable to send enquiry. Please try again.'

    try {
      const error = (await response.json()) as ErrorResponse
      errorMessage = error.message || errorMessage
    } catch {
      // Keep the generic message when the server returns a non-JSON error.
    }

    throw new Error(errorMessage)
  }

  return (await response.json()) as EnquiryResponse
}

export async function cancelEnquiry(enquiryId: number, senderId?: string) {
  const response = await apiFetch(`/api/enquiries/${enquiryId}/cancel`, {
    body: JSON.stringify({ senderId }),
    headers: {
      'Content-Type': 'application/json',
    },
    method: 'POST',
  })

  if (!response.ok) {
    let errorMessage = 'Unable to cancel enquiry. Please try again.'

    try {
      const error = (await response.json()) as ErrorResponse
      errorMessage = error.message || errorMessage
    } catch {
      // Keep the generic message when the server returns a non-JSON error.
    }

    throw new Error(errorMessage)
  }

  return (await response.json()) as EnquiryResponse
}

export async function agreeToDiscuss(enquiryId: number, receiverId: string, ownerResponse?: string) {
  return submitEnquiryDecision(enquiryId, 'agree-to-discuss', receiverId, ownerResponse)
}

export async function declineEnquiry(enquiryId: number, receiverId: string, ownerResponse?: string) {
  return submitEnquiryDecision(enquiryId, 'decline', receiverId, ownerResponse)
}

export async function getUserEnquiries(userId: string) {
  const response = await apiFetch(`/api/enquiries/user/${encodeURIComponent(userId)}`)

  if (!response.ok) {
    let errorMessage = 'Unable to load enquiries. Please try again.'

    try {
      const error = (await response.json()) as ErrorResponse
      errorMessage = error.message || errorMessage
    } catch {
      // Keep the generic message when the server returns a non-JSON error.
    }

    throw new Error(errorMessage)
  }

  return (await response.json()) as UserEnquiriesResponse
}

export async function getExchangeListings(userId: string, excludeListingId: number) {
  const response = await apiFetch(
    `/api/enquiries/exchange-listings/${encodeURIComponent(userId)}?excludeListingId=${encodeURIComponent(excludeListingId)}`,
  )

  if (!response.ok) {
    let errorMessage = 'Unable to load your listings. Please try again.'

    try {
      const error = (await response.json()) as ErrorResponse
      errorMessage = error.message || errorMessage
    } catch {
      // Keep the generic message when the server returns a non-JSON error.
    }

    throw new Error(errorMessage)
  }

  return (await response.json()) as ExchangeListingResponse[]
}

export async function getEnquiryStatus(listingId: number, senderId: string) {
  const response = await apiFetch(
    `/api/enquiries/status?listingId=${encodeURIComponent(listingId)}&senderId=${encodeURIComponent(senderId)}`,
  )

  if (!response.ok) {
    let errorMessage = 'Unable to check enquiry status. Please try again.'

    try {
      const error = (await response.json()) as ErrorResponse
      errorMessage = error.message || errorMessage
    } catch {
      // Keep the generic message when the server returns a non-JSON error.
    }

    throw new Error(errorMessage)
  }

  return (await response.json()) as EnquiryStatusResponse
}

async function submitEnquiryDecision(
  enquiryId: number,
  action: 'agree-to-discuss' | 'decline',
  receiverId: string,
  ownerResponse?: string,
) {
  const response = await apiFetch(`/api/enquiries/${enquiryId}/${action}`, {
    body: JSON.stringify({ ownerResponse, receiverId }),
    headers: {
      'Content-Type': 'application/json',
    },
    method: 'POST',
  })

  if (!response.ok) {
    let errorMessage = 'Unable to update enquiry. Please try again.'

    try {
      const error = (await response.json()) as ErrorResponse
      errorMessage = error.message || errorMessage
    } catch {
      // Keep the generic message when the server returns a non-JSON error.
    }

    throw new Error(errorMessage)
  }

  return (await response.json()) as EnquiryResponse
}
