import { useEffect, useState } from 'react'
import ListingFilters from '../components/listing/ListingFilters'
import ListingPagination from '../components/listing/ListingPagination'
import ListingResults from '../components/listing/ListingResults'
import { getListings } from '../components/listing/listingApi'
import { defaultListingFilters, type Listing, type ListingFiltersValue } from '../components/listing/listingData'
import Navbar from '../components/layout/Navbar'

function getInitialFilters() {
  const params = new URLSearchParams(window.location.search)

  return {
    ...defaultListingFilters,
    availableFrom: params.get('availableFrom') ?? defaultListingFilters.availableFrom,
    availableTo: params.get('availableTo') ?? defaultListingFilters.availableTo,
    category: params.get('category') ?? defaultListingFilters.category,
    city: params.get('city') ?? defaultListingFilters.city,
    country: params.get('country') ?? defaultListingFilters.country,
    exchangeMethod: params.get('exchangeMethod') ?? defaultListingFilters.exchangeMethod,
    exchangeTimings: params.getAll('exchangeTimings').length > 0
      ? params.getAll('exchangeTimings')
      : defaultListingFilters.exchangeTimings,
    listingType: params.get('listingType') ?? defaultListingFilters.listingType,
  }
}

function ListingsPage() {
  const [appliedFilters, setAppliedFilters] = useState<ListingFiltersValue>(getInitialFilters)
  const [filteredListings, setFilteredListings] = useState<Listing[]>([])
  const [isLoadingListings, setIsLoadingListings] = useState(true)
  const [listingLoadMessage, setListingLoadMessage] = useState('')

  useEffect(() => {
    let shouldIgnoreResponse = false

    setIsLoadingListings(true)
    setListingLoadMessage('')

    getListings(appliedFilters)
      .then((nextListings) => {
        if (shouldIgnoreResponse) {
          return
        }

        setFilteredListings(nextListings)
      })
      .catch((error: Error) => {
        if (shouldIgnoreResponse) {
          return
        }

        setFilteredListings([])
        setListingLoadMessage(error.message)
      })
      .finally(() => {
        if (!shouldIgnoreResponse) {
          setIsLoadingListings(false)
        }
      })

    return () => {
      shouldIgnoreResponse = true
    }
  }, [appliedFilters])

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
              {listingLoadMessage ? (
                <div className="mb-6 rounded-3xl bg-red-50 px-6 py-4 text-sm font-extrabold text-red-500">
                  {listingLoadMessage}
                </div>
              ) : null}
              {isLoadingListings ? (
                <div>
                  <div className="mb-6 hidden min-h-12 xl:flex" aria-hidden="true" />
                  <div className="flex min-h-[180px] items-center justify-center rounded-4xl bg-white p-10 text-center shadow-lg shadow-blue-100">
                    <div className="flex items-center justify-center gap-3">
                      <span
                        className="h-6 w-6 animate-spin rounded-full border-3 border-blue-100 border-t-blue-500"
                        aria-hidden="true"
                      />
                      <p className="font-outfit m-0 text-2xl font-extrabold text-gray-800">Loading results...</p>
                    </div>
                  </div>
                </div>
              ) : (
                <ListingResults listings={filteredListings} />
              )}
              {!isLoadingListings ? (
                <div className="mt-8">
                  <ListingPagination totalListings={filteredListings.length} />
                </div>
              ) : null}
            </div>
          </div>
        </div>
      </section>
    </main>
  )
}

export default ListingsPage
