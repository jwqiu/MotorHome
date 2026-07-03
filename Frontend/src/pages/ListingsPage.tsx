import { useMemo, useState } from 'react'
import ListingFilters from '../components/listing/ListingFilters'
import ListingPagination from '../components/listing/ListingPagination'
import ListingResults from '../components/listing/ListingResults'
import {
  defaultListingFilters,
  listingMatchesFilters,
  listings,
  type ListingFiltersValue,
} from '../components/listing/listingData'
import Navbar from '../components/layout/Navbar'

function getInitialFilters() {
  const params = new URLSearchParams(window.location.search)

  return {
    ...defaultListingFilters,
    category: params.get('category') ?? defaultListingFilters.category,
    city: params.get('city') ?? defaultListingFilters.city,
    country: params.get('country') ?? defaultListingFilters.country,
    listingType: params.get('listingType') ?? defaultListingFilters.listingType,
  }
}

function ListingsPage() {
  const [appliedFilters, setAppliedFilters] = useState<ListingFiltersValue>(getInitialFilters)
  const filteredListings = useMemo(
    () => listings.filter((listing) => listingMatchesFilters(listing, appliedFilters)),
    [appliedFilters],
  )

  const handleApplyFilters = (filters: ListingFiltersValue) => {
    setAppliedFilters(filters)
    window.scrollTo({ top: 0, behavior: 'smooth' })
  }

  return (
    <main className="min-h-screen bg-white font-sans text-gray-600 antialiased">
      <Navbar activePage="listings" variant="solid" />

      <section className="bg-blue-50 px-6 pt-40 pb-14 md:px-16 md:pt-44">
        <div className="mx-auto max-w-[1280px]">
          <div className="mb-10 max-w-[680px]">
            <p className="mb-3 text-sm font-extrabold tracking-[0.18em] text-blue-500 uppercase">
              Browse Listings
            </p>
            <h1 className="font-outfit m-0 text-4xl leading-tight font-extrabold text-gray-800 md:text-5xl">
              Find the right exchange for your next adventure.
            </h1>
          </div>

          <div className="grid items-start gap-10 xl:grid-cols-[400px_minmax(0,1fr)]">
            <div className="2xl:sticky 2xl:top-32 2xl:max-h-[calc(100vh-9rem)] xl:overflow-y-auto xl:pr-2">
              <ListingFilters initialFilters={appliedFilters} onApplyFilters={handleApplyFilters} />
            </div>
            <div className="min-w-0">
              <ListingResults listings={filteredListings} />
              <div className="mt-8">
                <ListingPagination totalListings={filteredListings.length} />
              </div>
            </div>
          </div>
        </div>
      </section>
    </main>
  )
}

export default ListingsPage
