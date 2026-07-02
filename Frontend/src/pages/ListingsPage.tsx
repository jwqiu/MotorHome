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

function ListingsPage() {
  const [appliedFilters, setAppliedFilters] = useState<ListingFiltersValue>(defaultListingFilters)
  const filteredListings = useMemo(
    () => listings.filter((listing) => listingMatchesFilters(listing, appliedFilters)),
    [appliedFilters],
  )

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

          <div className="grid items-start gap-10 min-[1400px]:grid-cols-[420px_minmax(0,1fr)]">
            <ListingFilters onApplyFilters={setAppliedFilters} />
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
