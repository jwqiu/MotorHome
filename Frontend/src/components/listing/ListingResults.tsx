import { useState } from 'react'
import ListingCard from './ListingCard'
import ModernSelect from './ModernSelect'
import type { Listing } from './listingData'

const listingsPerPage = 5

function getCurrentPage(totalPages: number) {
  const page = Number(new URLSearchParams(window.location.search).get('page') ?? '1')

  if (!Number.isInteger(page) || page < 1) {
    return 1
  }

  return Math.min(page, totalPages)
}

type ListingResultsProps = {
  listings: Listing[]
}

function ListingResults({ listings }: ListingResultsProps) {
  const [sortBy, setSortBy] = useState('Newest first')
  const totalPages = Math.ceil(listings.length / listingsPerPage)
  const currentPage = getCurrentPage(Math.max(totalPages, 1))
  const startIndex = (currentPage - 1) * listingsPerPage
  const sortedListings = [...listings].sort((a, b) => (
    sortBy === 'Oldest first'
      ? a.createdAt.localeCompare(b.createdAt)
      : b.createdAt.localeCompare(a.createdAt)
  ))
  const visibleListings = sortedListings.slice(startIndex, startIndex + listingsPerPage)

  return (
    <section className="min-w-0 flex-1" aria-labelledby="listing-results-title">
      <div className="mb-6 flex min-h-12 flex-col gap-4 sm:flex-row sm:items-end sm:justify-between">
        <div>
          <h2 id="listing-results-title" className="font-outfit m-0 text-2xl font-extrabold text-gray-800">
            {listings.length} Results Found
          </h2>
        </div>

        <ModernSelect
          ariaLabel="Sort listings"
          className="w-full sm:w-[190px]"
          onChange={setSortBy}
          options={['Newest first', 'Oldest first']}
          value={sortBy}
        />
      </div>

      <div className="space-y-6">
        {visibleListings.length > 0 ? (
          visibleListings.map((listing) => (
            <ListingCard listing={listing} key={listing.id} />
          ))
        ) : (
          <div className="rounded-4xl bg-white p-10 text-center shadow-lg shadow-blue-100">
            <p className="font-outfit m-0 text-2xl font-extrabold text-gray-800">No listings found</p>
            <p className="mx-auto mt-3 mb-0 max-w-[420px] text-sm leading-6 font-medium text-gray-400">
              Try broadening your filters or choosing MotorHome/RV under Vehicles.
            </p>
          </div>
        )}
      </div>
    </section>
  )
}

export default ListingResults
