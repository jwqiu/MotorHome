import listing01 from '../../assets/listings/listing-01.jpg'
import listing02 from '../../assets/listings/listing-02.jpg'
import listing03 from '../../assets/listings/listing-03.jpg'
import listing04 from '../../assets/listings/listing-04.jpg'
import listing05 from '../../assets/listings/listing-05.jpg'
import listing06 from '../../assets/listings/listing-06.jpg'
import listing07 from '../../assets/listings/listing-07.jpg'
import listing08 from '../../assets/listings/listing-08.jpg'
import listing09 from '../../assets/listings/listing-09.jpg'
import listing10 from '../../assets/listings/listing-10.jpg'

export type Listing = {
  availableFrom: string
  availableTo: string
  category: 'Vehicles' | 'Accommodation' | 'Canal Boats'
  city: string
  country: string
  createdAt: string
  exchangeMethod: 'Direct Exchange' | 'Point Exchange'
  exchangeTimings: string[]
  id: string
  title: string
  imageLabel: string
  imageSrc: string
  listingType: string
  currentLocation: string
  wantedAssets: string[]
  wantedDestinations: string[]
  exchangeTypes: string[]
  description: string
}

export type ListingFiltersValue = {
  availableFrom: string
  availableTo: string
  category: string
  city: string
  country: string
  exchangeMethod: string
  exchangeTimings: string[]
  listingType: string
}

export const defaultListingFilters: ListingFiltersValue = {
  availableFrom: '2026-01-01',
  availableTo: '2027-12-31',
  category: '',
  city: '',
  country: '',
  exchangeMethod: 'Direct Exchange',
  exchangeTimings: ['Simultaneous'],
  listingType: '',
}

export function listingMatchesFilters(listing: Listing, filters: ListingFiltersValue) {
  const matchesCountry = !filters.country || listing.country === filters.country
  const matchesCity = !filters.city || listing.city === filters.city
  const matchesCategory = !filters.category || listing.category === filters.category
  const matchesListingType = !filters.listingType || listing.listingType === filters.listingType
  const matchesExchangeMethod = listing.exchangeMethod === filters.exchangeMethod
  const matchesExchangeTimings = filters.exchangeTimings.length === 0 ||
    filters.exchangeTimings.some((timing) => listing.exchangeTimings.includes(timing))
  const matchesAvailableDates = listing.availableFrom <= filters.availableTo &&
    listing.availableTo >= filters.availableFrom

  return matchesCountry &&
    matchesCity &&
    matchesCategory &&
    matchesListingType &&
    matchesExchangeMethod &&
    matchesExchangeTimings &&
    matchesAvailableDates
}

export const listings: Listing[] = [
  {
    availableFrom: '2026-06-01',
    availableTo: '2026-10-01',
    category: 'Vehicles',
    city: 'Christchurch',
    country: 'New Zealand',
    createdAt: '2026-06-15',
    exchangeMethod: 'Direct Exchange',
    exchangeTimings: ['Simultaneous', 'Non-simultaneous'],
    id: 'modern-family-motorhome',
    title: 'Modern Family Motorhome',
    imageLabel: 'Modern motorhome',
    imageSrc: listing01,
    listingType: 'MotorHome/RV',
    currentLocation: 'Christchurch, New Zealand',
    wantedAssets: ['MotorHome/RV', 'Campervan'],
    wantedDestinations: ['United Kingdom', 'United States', 'Australia'],
    exchangeTypes: ['Simultaneous', 'Non-simultaneous'],
    description: 'A bright, easy-driving motorhome set up for family trips and long stays.',
  },
  {
    availableFrom: '2026-07-15',
    availableTo: '2026-12-15',
    category: 'Vehicles',
    city: 'Auckland',
    country: 'New Zealand',
    createdAt: '2026-06-12',
    exchangeMethod: 'Direct Exchange',
    exchangeTimings: ['Simultaneous', 'Non-simultaneous'],
    id: 'two-year-old-family-motorhome',
    title: '2-Year-Old Family Motorhome',
    imageLabel: 'Family motorhome',
    imageSrc: listing02,
    listingType: 'MotorHome/RV',
    currentLocation: 'Auckland, New Zealand',
    wantedAssets: ['MotorHome/RV'],
    wantedDestinations: ['United States'],
    exchangeTypes: ['Simultaneous', 'Non-simultaneous'],
    description: 'Recently fitted interior, generous storage, and a comfortable layout for four.',
  },
  {
    availableFrom: '2026-05-20',
    availableTo: '2026-09-30',
    category: 'Vehicles',
    city: 'Wellington',
    country: 'New Zealand',
    createdAt: '2026-06-09',
    exchangeMethod: 'Direct Exchange',
    exchangeTimings: ['Non-simultaneous'],
    id: 'near-new-luxury-camper',
    title: 'Near - New Luxury Camper',
    imageLabel: 'Luxury camper',
    imageSrc: listing03,
    listingType: 'MotorHome/RV',
    currentLocation: 'Wellington, New Zealand',
    wantedAssets: ['MotorHome/RV', 'Holiday Home'],
    wantedDestinations: ['Canada', 'Australia'],
    exchangeTypes: ['Non-simultaneous'],
    description: 'Near-new camper with premium finishes, compact handling, and coastal trip comfort.',
  },
  {
    availableFrom: '2026-08-01',
    availableTo: '2026-11-30',
    category: 'Vehicles',
    city: 'Hamilton',
    country: 'New Zealand',
    createdAt: '2026-06-04',
    exchangeMethod: 'Direct Exchange',
    exchangeTimings: ['Simultaneous'],
    id: 'classic-coastal-campervan',
    title: 'Classic Coastal Campervan',
    imageLabel: 'Classic campervan',
    imageSrc: listing04,
    listingType: 'MotorHome/RV',
    currentLocation: 'Hamilton, New Zealand',
    wantedAssets: ['MotorHome/RV', 'Campervan'],
    wantedDestinations: ['Canada', 'United Kingdom'],
    exchangeTypes: ['Simultaneous'],
    description: 'A character-filled campervan with a simple, reliable setup for relaxed coastal touring.',
  },
  {
    availableFrom: '2026-06-10',
    availableTo: '2026-08-31',
    category: 'Vehicles',
    city: 'Melbourne',
    country: 'Australia',
    createdAt: '2026-05-29',
    exchangeMethod: 'Direct Exchange',
    exchangeTimings: ['Non-simultaneous'],
    id: 'compact-weekender-caravan',
    title: 'Compact Weekender Motorhome',
    imageLabel: 'Compact motorhome',
    imageSrc: listing05,
    listingType: 'MotorHome/RV',
    currentLocation: 'Melbourne, Australia',
    wantedAssets: ['MotorHome/RV'],
    wantedDestinations: ['New Zealand', 'Canada'],
    exchangeTypes: ['Non-simultaneous'],
    description: 'A tidy compact motorhome suited to couples who want an easy base for short scenic escapes.',
  },
  {
    availableFrom: '2026-09-01',
    availableTo: '2027-01-15',
    category: 'Vehicles',
    city: 'Calgary',
    country: 'Canada',
    createdAt: '2026-05-23',
    exchangeMethod: 'Direct Exchange',
    exchangeTimings: ['Simultaneous'],
    id: 'heritage-travel-trailer',
    title: 'Heritage Touring Motorhome',
    imageLabel: 'Heritage motorhome',
    imageSrc: listing06,
    listingType: 'MotorHome/RV',
    currentLocation: 'Calgary, Canada',
    wantedAssets: ['MotorHome/RV', 'Home'],
    wantedDestinations: ['Australia', 'New Zealand'],
    exchangeTypes: ['Simultaneous'],
    description: 'A vintage-inspired motorhome for slow road trips, quiet campgrounds, and open landscapes.',
  },
  {
    availableFrom: '2026-06-20',
    availableTo: '2026-10-20',
    category: 'Vehicles',
    city: 'London',
    country: 'United Kingdom',
    createdAt: '2026-05-18',
    exchangeMethod: 'Direct Exchange',
    exchangeTimings: ['Simultaneous', 'Non-simultaneous'],
    id: 'bright-ducato-camper',
    title: 'Bright Ducato Camper',
    imageLabel: 'Bright Ducato camper',
    imageSrc: listing07,
    listingType: 'MotorHome/RV',
    currentLocation: 'London, United Kingdom',
    wantedAssets: ['MotorHome/RV', 'Campervan'],
    wantedDestinations: ['United States', 'New Zealand'],
    exchangeTypes: ['Simultaneous', 'Non-simultaneous'],
    description: 'A practical coachbuilt camper with generous living space and a clean, comfortable cabin.',
  },
  {
    availableFrom: '2026-04-01',
    availableTo: '2026-07-31',
    category: 'Vehicles',
    city: 'Manchester',
    country: 'United Kingdom',
    createdAt: '2026-05-12',
    exchangeMethod: 'Direct Exchange',
    exchangeTimings: ['Non-simultaneous'],
    id: 'autosleeper-clubman-escape',
    title: 'Autosleeper Clubman Escape',
    imageLabel: 'Autosleeper campervan',
    imageSrc: listing08,
    listingType: 'MotorHome/RV',
    currentLocation: 'Manchester, United Kingdom',
    wantedAssets: ['MotorHome/RV'],
    wantedDestinations: ['Canada', 'Australia'],
    exchangeTypes: ['Non-simultaneous'],
    description: 'A compact European campervan that is easy to park, easy to drive, and ready for village stays.',
  },
  {
    availableFrom: '2026-10-01',
    availableTo: '2027-02-28',
    category: 'Vehicles',
    city: 'San Francisco',
    country: 'United States',
    createdAt: '2026-05-06',
    exchangeMethod: 'Direct Exchange',
    exchangeTimings: ['Simultaneous'],
    id: 'off-road-sprinter-adventure',
    title: 'Off-Road Sprinter Adventure',
    imageLabel: 'Off-road sprinter campervan',
    imageSrc: listing09,
    listingType: 'MotorHome/RV',
    currentLocation: 'San Francisco, United States',
    wantedAssets: ['MotorHome/RV', 'Canal Boats'],
    wantedDestinations: ['New Zealand', 'United Kingdom'],
    exchangeTypes: ['Simultaneous'],
    description: 'A rugged Sprinter-based camper for travelers who prefer gravel roads and remote trailheads.',
  },
  {
    availableFrom: '2026-07-01',
    availableTo: '2026-09-15',
    category: 'Vehicles',
    city: 'Montreal',
    country: 'Canada',
    createdAt: '2026-04-28',
    exchangeMethod: 'Direct Exchange',
    exchangeTimings: ['Simultaneous', 'Non-simultaneous'],
    id: 'citroen-h-van-retreat',
    title: 'Citroen H Van Retreat',
    imageLabel: 'Citroen H van camper',
    imageSrc: listing10,
    listingType: 'MotorHome/RV',
    currentLocation: 'Montreal, Canada',
    wantedAssets: ['MotorHome/RV', 'Holiday Home'],
    wantedDestinations: ['France', 'United Kingdom', 'Australia'],
    exchangeTypes: ['Simultaneous', 'Non-simultaneous'],
    description: 'A distinctive classic van conversion with charm, compact facilities, and weekend-trip appeal.',
  },
]
