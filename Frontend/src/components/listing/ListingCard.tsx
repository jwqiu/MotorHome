import type { Listing } from './listingData'

type ListingCardProps = {
  listing: Listing
}

function InfoPill({ children }: { children: string }) {
  return (
    <span className="rounded-4xl  bg-gray-50 shadow-md px-3 py-1.5 text-[11px] text-gray-700">
      {children}
    </span>
  )
}

function ListingCard({ listing }: ListingCardProps) {
  return (
    <a
      className="group grid overflow-hidden rounded-4xl bg-white text-gray-500 no-underline shadow-lg shadow-blue-100 transition-transform duration-200 hover:scale-[1.01] hover:shadow-xl hover:shadow-blue-100 focus-visible:outline-2 focus-visible:outline-offset-4 focus-visible:outline-blue-500 lg:grid-cols-[340px_1fr] min-[1400px]:grid-cols-[280px_1fr]"
      href={`/listings/${listing.id}`}
      rel="noreferrer"
      target="_blank"
    >
      <div className="relative aspect-[16/10] overflow-hidden lg:aspect-auto lg:min-h-[260px] min-[1400px]:min-h-full" aria-label={listing.imageLabel}>
        <img
          className="absolute inset-0 h-full w-full object-contain transition-transform duration-300 group-hover:scale-105"
          src={listing.imageSrc}
          alt=""
        />
        <div className="absolute inset-0 bg-gradient-to-t from-gray-900/35 to-transparent" aria-hidden="true" />
      </div>

      <article className="min-w-0 p-8">
        <div className="mb-3">
          <div>
            <h3 className="font-outfit mb-3 text-2xl font-extrabold text-gray-800 transition-colors group-hover:text-blue-600">
              {listing.title}
            </h3>
            <p className="m-0 max-w-[560px] text-sm leading-6 text-sm text-gray-400">
              {listing.description}
            </p>
          </div>
        </div>
        <div className="mb-5 flex items-center gap-1 text-sm text-gray-500">
          <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" className="size-5">
            <path strokeLinecap="round" strokeLinejoin="round" d="M15 10.5a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
            <path strokeLinecap="round" strokeLinejoin="round" d="M19.5 10.5c0 7.142-7.5 11.25-7.5 11.25S4.5 17.642 4.5 10.5a7.5 7.5 0 1 1 15 0Z" />
          </svg>
          <dd className="text-sm text-gray-700">{listing.currentLocation}</dd>
        </div>
        {/* <div className="mb-5">
          <dd className="m-0 flex flex-wrap gap-2">
            {listing.exchangeTypes.map((type) => (
              <InfoPill key={type}>{type}</InfoPill>
            ))}
          </dd>
        </div> */}
        <div className="flex flex-col gap-4 ">
          <section className="">
            <h4 className="font-outfit m-0 mb-4 text-sm font-extrabold text-gray-800">Owner Looking For</h4>
            <dl className="m-0 text-sm flex flex-col gap-3 text-gray-500">
              <div className="flex items-center gap-3">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" className="size-6">
                  <path strokeLinecap="round" strokeLinejoin="round" d="M12.75 3.03v.568c0 .334.148.65.405.864l1.068.89c.442.369.535 1.01.216 1.49l-.51.766a2.25 2.25 0 0 1-1.161.886l-.143.048a1.107 1.107 0 0 0-.57 1.664c.369.555.169 1.307-.427 1.605L9 13.125l.423 1.059a.956.956 0 0 1-1.652.928l-.679-.906a1.125 1.125 0 0 0-1.906.172L4.5 15.75l-.612.153M12.75 3.031a9 9 0 0 0-8.862 12.872M12.75 3.031a9 9 0 0 1 6.69 14.036m0 0-.177-.529A2.25 2.25 0 0 0 17.128 15H16.5l-.324-.324a1.453 1.453 0 0 0-2.328.377l-.036.073a1.586 1.586 0 0 1-.982.816l-.99.282c-.55.157-.894.702-.8 1.267l.073.438c.08.474.49.821.97.821.846 0 1.598.542 1.865 1.345l.215.643m5.276-3.67a9.012 9.012 0 0 1-5.276 3.67m0 0a9 9 0 0 1-10.275-4.835M15.75 9c0 .896-.393 1.7-1.016 2.25" />
                </svg>
                <dd className="flex flex-wrap gap-1">
                  {listing.wantedDestinations.map((destination) => (
                    <InfoPill key={destination}>{destination}</InfoPill>
                  ))}
                </dd>
              </div>
              <div className="flex items-center gap-3">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" className="size-6">
                  <path strokeLinecap="round" strokeLinejoin="round" d="M19.5 12c0-1.232-.046-2.453-.138-3.662a4.006 4.006 0 0 0-3.7-3.7 48.678 48.678 0 0 0-7.324 0 4.006 4.006 0 0 0-3.7 3.7c-.017.22-.032.441-.046.662M19.5 12l3-3m-3 3-3-3m-12 3c0 1.232.046 2.453.138 3.662a4.006 4.006 0 0 0 3.7 3.7 48.656 48.656 0 0 0 7.324 0 4.006 4.006 0 0 0 3.7-3.7c.017-.22.032-.441.046-.662M4.5 12l3 3m-3-3-3 3" />
                </svg>
                <dd className="flex flex-wrap gap-1">
                  {listing.wantedAssets.map((asset) => (
                    <InfoPill key={asset}>{asset}</InfoPill>
                  ))}
                </dd>
              </div>
            </dl>
          </section>
        </div>

       
      </article>
    </a>
  )
}

export default ListingCard
