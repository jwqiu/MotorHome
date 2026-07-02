import type { Listing } from './listingData'

type ListingCardProps = {
  listing: Listing
}

function ListingCard({ listing }: ListingCardProps) {
  return (
    <a
      className="group grid overflow-hidden rounded-4xl bg-white text-gray-500 no-underline shadow-lg shadow-blue-100 transition-transform duration-200 hover:scale-[1.01] hover:shadow-xl hover:shadow-blue-100 focus-visible:outline-2 focus-visible:outline-offset-4 focus-visible:outline-blue-500 lg:grid-cols-[340px_1fr] min-[1400px]:grid-cols-[280px_1fr]"
      href={`/listings/${listing.id}`}
    >
      <div className="relative aspect-[16/10] overflow-hidden lg:aspect-auto lg:min-h-[260px] min-[1400px]:min-h-full" aria-label={listing.imageLabel}>
        <img
          className="absolute inset-0 h-full w-full object-cover transition-transform duration-300 group-hover:scale-105"
          src={listing.imageSrc}
          alt=""
        />
        <div className="absolute inset-0 bg-gradient-to-t from-gray-900/35 to-transparent" aria-hidden="true" />
        <span className="absolute bottom-5 left-5 rounded-4xl bg-white/90 px-4 py-2 text-xs font-extrabold text-blue-500 shadow-md shadow-gray-900/10">
          Motorhome/RV
        </span>
      </div>

      <article className="min-w-0 p-7 md:p-8">
        <div className="mb-4">
          <div>
            <h3 className="font-outfit mb-2 text-2xl font-extrabold text-gray-800 transition-colors group-hover:text-blue-600">
              {listing.title}
            </h3>
            <p className="m-0 max-w-[560px] text-sm leading-6 font-medium text-gray-400">
              {listing.description}
            </p>
          </div>
        </div>

        <dl className="m-0 space-y-3 text-sm font-semibold text-gray-500">
          <div className="flex items-start gap-3">
 
            <dd className="m-0">
              <span className="font-extrabold text-gray-700">From: </span>
              {listing.currentLocation}
            </dd>
          </div>

          {listing.lookingFor ? (
            <div className="flex items-start gap-3">
  
              <dd className="m-0">
                <span className="font-extrabold text-gray-700">Wanted destinations: </span>
                {listing.lookingFor}
              </dd>
            </div>
          ) : null}

          <div className="flex flex-wrap items-center gap-3">
            <dt className="font-extrabold text-gray-700">Open to:</dt>
            <dd className="m-0 flex flex-wrap gap-2">
              {listing.exchangeTypes.map((type) => (
                <span
                  className="rounded-4xl border border-blue-100 bg-blue-50 px-3 py-1.5 text-[11px] font-extrabold text-blue-500"
                  key={type}
                >
                  {type}
                </span>
              ))}
            </dd>
          </div>

          <div className="pt-2">
            <span className="font-outfit inline-flex items-center text-sm font-extrabold text-blue-500">
              View details
              <span className="ml-2 transition-transform group-hover:translate-x-1" aria-hidden="true">
                -&gt;
              </span>
            </span>
          </div>
        </dl>
      </article>
    </a>
  )
}

export default ListingCard
