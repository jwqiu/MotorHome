import { getListingImageByListingId, type Listing, type ListingFiltersValue } from './listingData'

export type ListingOwnerResponse = {
  about: string
  displayName: string
  id: string
  location: string
  memberSince: string
  spokenLanguages: string
}

type ListingDetailResponse = {
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
  owner: ListingOwnerResponse
  title: string
  wantedAssets: string[]
  wantedDestinations: string[]
}

export type ListingDetail = {
  listing: Listing
  owner: ListingOwnerResponse
}

type ErrorResponse = {
  message?: string
}

export type SaveListingPayload = {
  availableFrom?: string
  availableTo?: string
  category: string
  city: string
  country: string
  currentLocation: string
  description: string
  exchangeMethod: string
  exchangeTimings: string[]
  imageAssetKey?: string
  imageLabel?: string
  listingType: string
  ownerId: string
  title: string
  wantedAssets: string[]
  wantedDestinations: string[]
}

export async function getListingDetail(slug: string) {
  const response = await window.fetch(`/api/listing/${encodeURIComponent(slug)}`)

  if (!response.ok) {
    let errorMessage = 'Unable to load listing details. Please try again.'

    try {
      const error = (await response.json()) as ErrorResponse
      errorMessage = error.message || errorMessage
    } catch {
      // Keep the generic message when the server returns a non-JSON error.
    }

    throw new Error(errorMessage)
  }

  const detail = (await response.json()) as ListingDetailResponse
  return mapListingDetail(detail)
}

export async function getListings(filters: ListingFiltersValue) {
  const params = new URLSearchParams()

  appendSearchParam(params, 'availableFrom', filters.availableFrom)
  appendSearchParam(params, 'availableTo', filters.availableTo)
  appendSearchParam(params, 'category', filters.category)
  appendSearchParam(params, 'city', filters.city)
  appendSearchParam(params, 'country', filters.country)
  appendSearchParam(params, 'exchangeMethod', filters.exchangeMethod)
  appendSearchParam(params, 'listingType', filters.listingType)

  filters.exchangeTimings.forEach((timing) => {
    appendSearchParam(params, 'exchangeTimings', timing)
  })

  const queryString = params.toString()
  const response = await window.fetch(`/api/listing${queryString ? `?${queryString}` : ''}`)

  if (!response.ok) {
    let errorMessage = 'Unable to load listings. Please try again.'

    try {
      const error = (await response.json()) as ErrorResponse
      errorMessage = error.message || errorMessage
    } catch {
      // Keep the generic message when the server returns a non-JSON error.
    }

    throw new Error(errorMessage)
  }

  const details = (await response.json()) as ListingDetailResponse[]
  return details.map((detail) => mapListingDetail(detail).listing)
}

export async function getOwnerListings(ownerId: string) {
  const response = await window.fetch(`/api/listing/owner/${encodeURIComponent(ownerId)}`)

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

  const details = (await response.json()) as ListingDetailResponse[]
  return details.map((detail) => mapListingDetail(detail).listing)
}

export async function createListing(payload: SaveListingPayload) {
  const response = await window.fetch('/api/listing', {
    body: JSON.stringify(payload),
    headers: {
      'Content-Type': 'application/json',
    },
    method: 'POST',
  })

  return parseSavedListingResponse(response, 'Unable to create listing. Please try again.')
}

export async function updateListing(listingId: number, payload: SaveListingPayload) {
  const response = await window.fetch(`/api/listing/${listingId}`, {
    body: JSON.stringify(payload),
    headers: {
      'Content-Type': 'application/json',
    },
    method: 'PUT',
  })

  return parseSavedListingResponse(response, 'Unable to update listing. Please try again.')
}

export async function deleteListing(listingId: number, ownerId: string) {
  const response = await window.fetch(`/api/listing/${listingId}?ownerId=${encodeURIComponent(ownerId)}`, {
    method: 'DELETE',
  })

  if (!response.ok) {
    let errorMessage = 'Unable to delete listing. Please try again.'

    try {
      const error = (await response.json()) as ErrorResponse
      errorMessage = error.message || errorMessage
    } catch {
      // Keep the generic message when the server returns a non-JSON error.
    }

    throw new Error(errorMessage)
  }

  return response.json() as Promise<{ deletedEnquiries: number, listingId: number }>
}

function appendSearchParam(params: URLSearchParams, key: string, value: string) {
  if (!value.trim()) {
    return
  }

  params.append(key, value.trim())
}

async function parseSavedListingResponse(response: Response, fallbackMessage: string) {
  if (!response.ok) {
    let errorMessage = fallbackMessage

    try {
      const error = (await response.json()) as ErrorResponse
      errorMessage = error.message || errorMessage
    } catch {
      // Keep the generic message when the server returns a non-JSON error.
    }

    throw new Error(errorMessage)
  }

  const detail = (await response.json()) as ListingDetailResponse
  return mapListingDetail(detail)
}

function mapListingDetail(detail: ListingDetailResponse): ListingDetail {
  const listing: Listing = {
    availableFrom: detail.availableFrom || '',
    availableTo: detail.availableTo || '',
    category: toListingCategory(detail.category),
    city: detail.city,
    country: detail.country,
    createdAt: detail.createdAt,
    currentLocation: detail.currentLocation,
    description: detail.description,
    exchangeMethod: toExchangeMethod(detail.exchangeMethod),
    exchangeTimings: detail.exchangeTimings,
    exchangeTypes: detail.exchangeTypes,
    id: detail.id,
    imageLabel: detail.imageLabel || detail.title,
    imageSrc: getListingImageByListingId(detail.listingId),
    listingId: detail.listingId,
    listingType: detail.listingType,
    title: detail.title,
    wantedAssets: detail.wantedAssets,
    wantedDestinations: detail.wantedDestinations,
  }

  return {
    listing,
    owner: detail.owner,
  }
}

function toListingCategory(category: string): Listing['category'] {
  if (category === 'Accommodation' || category === 'Canal Boats') {
    return category
  }

  return 'Vehicles'
}

function toExchangeMethod(exchangeMethod: string): Listing['exchangeMethod'] {
  if (exchangeMethod === 'Point Exchange') {
    return 'Point Exchange'
  }

  return 'Direct Exchange'
}
