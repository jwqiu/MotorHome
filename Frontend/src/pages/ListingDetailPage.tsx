import { useMemo, useState } from 'react'
import DetailGallery from '../components/detail/DetailGallery'
import EnquiryModal from '../components/detail/EnquiryModal'
import ListingDetailSections from '../components/detail/ListingDetailSections'
import OwnerContactCard from '../components/detail/OwnerContactCard'
import { sharedListingDetail } from '../components/detail/listingDetailData'
import { listings } from '../components/listing/listingData'
import Navbar from '../components/layout/Navbar'

function getListingIdFromPath() {
  return window.location.pathname.split('/').filter(Boolean)[1] ?? ''
}

function ListingDetailPage() {
  const [isEnquiryOpen, setIsEnquiryOpen] = useState(false)
  const listingId = getListingIdFromPath()
  const listing = listings.find((item) => item.id === listingId)
  const galleryPhotos = useMemo(() => {
    if (!listing) {
      return []
    }

    return [
      listing.imageSrc,
      ...listings
        .filter((item) => item.id !== listing.id)
        .slice(0, 4)
        .map((item) => item.imageSrc),
    ]
  }, [listing])

  if (!listing) {
    return (
      <main className="min-h-screen bg-blue-50 font-sans text-gray-600 antialiased">
        <Navbar variant="solid" />
        <section className="px-6 pt-40 pb-16 md:px-16 md:pt-44">
          <div className="mx-auto max-w-[920px] rounded-4xl bg-white p-8 text-center shadow-lg shadow-blue-100">
            <h1 className="font-outfit m-0 text-3xl font-extrabold text-gray-800">Listing not found</h1>
            <p className="mt-3 mb-0 text-sm text-gray-500">The listing you are looking for is not available.</p>
          </div>
        </section>
      </main>
    )
  }

  return (
    <main className="min-h-screen bg-blue-50 font-sans text-gray-600 antialiased">
      <Navbar variant="solid" />

      <section className="px-6 pt-20 pb-16 md:px-16 md:pt-44">
        <div className="mx-auto max-w-[1280px]">
          <div className="grid items-start gap-10 xl:grid-cols-[minmax(0,1fr)_360px]">
            <div className="min-w-0">
              <DetailGallery imageLabel={listing.imageLabel} photos={galleryPhotos} />

              <section className="mt-8 rounded-4xl bg-white p-7 shadow-lg shadow-blue-100 md:p-8">

                <h1 className="font-outfit mb-4 text-4xl leading-tight font-extrabold text-gray-800 md:text-5xl">
                  {listing.title}
                </h1>
                <p className="m-0 max-w-[760px] mb-4 text-base leading-7 text-gray-500">{listing.description}</p>
                <div className="">
                  <dd className="m-0 mt-2 flex flex-wrap gap-2">
                    {listing.exchangeTypes.map((type) => (
                      <span className="rounded-4xl border bg-gray-50 px-3 py-1.5 text-sm  text-gray-600" key={type}>
                        {type}
                      </span>
                    ))}
                    <span className="rounded-4xl border bg-gray-50 px-3 py-1.5 text-sm  text-gray-600">
                      {listing.listingType}
                    </span>
                  </dd>
                </div>
                <dl className="mt-4 grid gap-4 ">
                  <div className="flex items-center gap-2 ">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" className="size-5">
                      <path strokeLinecap="round" strokeLinejoin="round" d="M15 10.5a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
                      <path strokeLinecap="round" strokeLinejoin="round" d="M19.5 10.5c0 7.142-7.5 11.25-7.5 11.25S4.5 17.642 4.5 10.5a7.5 7.5 0 1 1 15 0Z" />
                    </svg>
                    <dd className="m-0  text-sm  text-gray-800">{listing.currentLocation}</dd>
                  </div>
    
                  <div className="flex items-center gap-2 ">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" className="size-5">
                      <path strokeLinecap="round" strokeLinejoin="round" d="M6.75 3v2.25M17.25 3v2.25M3 18.75V7.5a2.25 2.25 0 0 1 2.25-2.25h13.5A2.25 2.25 0 0 1 21 7.5v11.25m-18 0A2.25 2.25 0 0 0 5.25 21h13.5A2.25 2.25 0 0 0 21 18.75m-18 0v-7.5A2.25 2.25 0 0 1 5.25 9h13.5A2.25 2.25 0 0 1 21 11.25v7.5" />
                    </svg>
                    <dt className="text-sm text-gray-800 ">Availability</dt>
                    <dd className="m-0 text-sm text-gray-400 whitespace-nowrap">
                      please contact the owner for availability information.
                    </dd>
                  </div>
                  <hr className="my-2 border-t border-gray-200" />
                  <h4 className="font-outfit m-0 text-sm font-extrabold text-gray-800">Owner Looking For</h4>

                  <div className="flex items-center gap-2 ">

                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" className="size-5">
                      <path strokeLinecap="round" strokeLinejoin="round" d="M12.75 3.03v.568c0 .334.148.65.405.864l1.068.89c.442.369.535 1.01.216 1.49l-.51.766a2.25 2.25 0 0 1-1.161.886l-.143.048a1.107 1.107 0 0 0-.57 1.664c.369.555.169 1.307-.427 1.605L9 13.125l.423 1.059a.956.956 0 0 1-1.652.928l-.679-.906a1.125 1.125 0 0 0-1.906.172L4.5 15.75l-.612.153M12.75 3.031a9 9 0 0 0-8.862 12.872M12.75 3.031a9 9 0 0 1 6.69 14.036m0 0-.177-.529A2.25 2.25 0 0 0 17.128 15H16.5l-.324-.324a1.453 1.453 0 0 0-2.328.377l-.036.073a1.586 1.586 0 0 1-.982.816l-.99.282c-.55.157-.894.702-.8 1.267l.073.438c.08.474.49.821.97.821.846 0 1.598.542 1.865 1.345l.215.643m5.276-3.67a9.012 9.012 0 0 1-5.276 3.67m0 0a9 9 0 0 1-10.275-4.835M15.75 9c0 .896-.393 1.7-1.016 2.25" />
                    </svg>

                    <dd className="m-0 flex flex-wrap gap-2">
                      {listing.wantedDestinations.map((destination) => (
                        <span className="rounded-4xl bg-gray-100 shadow-md px-3 py-1.5 text-xs text-gray-600" key={destination}>
                          {destination}
                        </span>
                      ))}
                    </dd>
                  </div>
                  <div className="flex items-center gap-2 ">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" className="size-5">
                      <path strokeLinecap="round" strokeLinejoin="round" d="M19.5 12c0-1.232-.046-2.453-.138-3.662a4.006 4.006 0 0 0-3.7-3.7 48.678 48.678 0 0 0-7.324 0 4.006 4.006 0 0 0-3.7 3.7c-.017.22-.032.441-.046.662M19.5 12l3-3m-3 3-3-3m-12 3c0 1.232.046 2.453.138 3.662a4.006 4.006 0 0 0 3.7 3.7 48.656 48.656 0 0 0 7.324 0 4.006 4.006 0 0 0 3.7-3.7c.017-.22.032-.441.046-.662M4.5 12l3 3m-3-3-3 3" />
                    </svg>
                    <div className="flex items-center gap-4">
                      <dd className="">
                        {listing.wantedAssets.map((asset) => (
                          <span className="rounded-4xl bg-gray-100 shadow-md px-3 py-1.5 text-xs text-gray-600" key={asset}>
                            {asset}
                          </span>
                        ))}
                      </dd>
                    </div>
                  </div>
                </dl>
              </section>

              <ListingDetailSections
                groups={sharedListingDetail.detailGroups}
                notices={sharedListingDetail.notices}
                overview={sharedListingDetail.overview}
              />
            </div>

            <OwnerContactCard
              certification={sharedListingDetail.certification}
              listingTitle={listing.title}
              owner={sharedListingDetail.owner}
              roadPoints={sharedListingDetail.roadPoints}
              onOpenEnquiry={() => setIsEnquiryOpen(true)}
            />
          </div>
        </div>
      </section>

      {isEnquiryOpen ? (
        <EnquiryModal listingTitle={listing.title} onClose={() => setIsEnquiryOpen(false)} />
      ) : null}
    </main>
  )
}

export default ListingDetailPage
