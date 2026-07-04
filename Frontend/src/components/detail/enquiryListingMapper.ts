import {
  getListingImageByListingId,
  getListingPlaceholderImage,
  listings,
  type Listing,
} from '../listing/listingData'
import type { UserEnquiryListing } from './enquiryApi'

function toListingCategory(category: string): Listing['category'] {
  if (category === 'Accommodation' || category === 'Canal Boats') {
    return category
  }

  return 'Vehicles'
}

function toExchangeMethod(exchangeMethod: string): Listing['exchangeMethod'] {
  return exchangeMethod === 'Point Exchange' ? 'Point Exchange' : 'Direct Exchange'
}

function unavailableListing(title: string, description: string): Listing {
  return {
    availableFrom: '',
    availableTo: '',
    category: 'Vehicles',
    city: '',
    country: '',
    createdAt: '',
    currentLocation: 'Not available',
    description,
    exchangeMethod: 'Direct Exchange',
    exchangeTimings: [],
    exchangeTypes: [],
    id: '',
    imageLabel: 'Placeholder listing',
    imageSrc: getListingPlaceholderImage(),
    listingId: 0,
    listingType: 'Not specified',
    title,
    wantedAssets: [],
    wantedDestinations: [],
  }
}

export function listingFromEnquirySummary(
  summary?: UserEnquiryListing,
  fallbackListingId?: number,
  missingTitle = 'Listing unavailable',
  missingDescription = 'This listing is no longer available.',
): Listing {
  if (summary) {
    return {
      availableFrom: summary.availableFrom || '',
      availableTo: summary.availableTo || '',
      category: toListingCategory(summary.category),
      city: summary.city,
      country: summary.country,
      createdAt: summary.createdAt,
      currentLocation: summary.currentLocation || [summary.city, summary.country].filter(Boolean).join(', '),
      description: summary.description,
      exchangeMethod: toExchangeMethod(summary.exchangeMethod),
      exchangeTimings: summary.exchangeTimings,
      exchangeTypes: summary.exchangeTypes,
      id: summary.id,
      imageLabel: summary.imageLabel || summary.title,
      imageSrc: getListingImageByListingId(summary.listingId),
      listingId: summary.listingId,
      listingType: summary.listingType,
      title: summary.title,
      wantedAssets: summary.wantedAssets,
      wantedDestinations: summary.wantedDestinations,
    }
  }

  const staticListing = listings.find((listing) => listing.listingId === fallbackListingId)
  if (staticListing) {
    return staticListing
  }

  return unavailableListing(missingTitle, missingDescription)
}
