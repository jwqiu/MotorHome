import { listings } from '../listing/listingData'

const categoryGroups = [
  {
    icon: '🚐',
    title: 'Recreational Vehicles',
    items: [
      { label: 'Motorhomes', category: 'Vehicles', listingType: 'MotorHome/RV' },
      { label: 'Campervans', category: 'Vehicles', listingType: 'Campervan' },
      { label: 'Caravans', category: 'Vehicles', listingType: 'Caravan' },
    ],
  },
  {
    icon: '🏡',
    title: 'Accommodation',
    items: [
      { label: 'Homes', category: 'Accommodation', listingType: 'Home' },
      { label: 'Holiday Homes', category: 'Accommodation', listingType: 'Holiday Home' },
    ],
  },
  {
    icon: '🛶',
    title: 'Canal Boats',
    items: [
      { label: 'Canal Boats', category: 'Canal Boats', listingType: 'Canal Boats' },
    ],
  },
]

const latestListings = [listings[0], listings[2], listings[6], listings[9]]

function buildCategoryHref(category: string, listingType: string) {
  const params = new URLSearchParams({
    category,
    listingType,
  })

  return `/listings?${params.toString()}`
}

function getPostedAt(createdAt: string) {
  const createdDate = new Date(`${createdAt}T00:00:00`)
  const newestDate = new Date('2026-06-15T00:00:00')
  const dayDifference = Math.max(
    0,
    Math.round((newestDate.getTime() - createdDate.getTime()) / (1000 * 60 * 60 * 24)),
  )

  if (dayDifference === 0) {
    return 'Today'
  }

  if (dayDifference < 7) {
    return `${dayDifference} days ago`
  }

  const weekDifference = Math.floor(dayDifference / 7)

  return `${weekDifference} ${weekDifference === 1 ? 'week' : 'weeks'} ago`
}

function BrowseListingsSection() {
  return (
    <section className="mb-12 w-full bg-white px-4 py-10 sm:px-8 sm:py-12 lg:mb-16 lg:px-16 lg:py-16" aria-labelledby="browse-listings-title">
      {/* <h2
        id="browse-listings-title"
        className="font-outfit mb-8 text-center text-lg sm:text-2xl font-bold text-gray-700 sm:mb-12"
      >
        Find exchange opportunities for your next adventure
      </h2> */}

      <div className="rounded-4xl sm:bg-gray-50 px-4 py-7 sm:shadow-lg sm:shadow-gray-200 sm:px-8 sm:py-10 lg:px-16 lg:py-14">
        <div className="mb-12">
          <h3 className="font-outfit mb-6 text-lg sm:text-2xl text-gray-700">
            Browse by Category
          </h3>

          <div className="grid grid-cols-1 gap-5 md:grid-cols-3 lg:gap-12">
            {categoryGroups.map((group) => (
              <article
                className="rounded-4xl bg-gray-50 sm:bg-white p-6 shadow-md shadow-gray-200 transition-transform duration-200 hover:scale-105 lg:p-8"
                key={group.title}
              >
                <h4 className="mb-6 flex items-center gap-3 text-xl font-bold text-gray-700">
                  <span className="text-2xl" aria-hidden="true">
                    {group.icon}
                  </span>
                  <span>{group.title}</span>
                </h4>

                <ul className="m-0 list-none space-y-4 p-0">
                  {group.items.map((item) => (
                    <li key={item.label}>
                      <a
                        className="inline-flex font-semibold text-gray-500 no-underline transition-colors duration-200 hover:text-blue-500"
                        href={buildCategoryHref(item.category, item.listingType)}
                      >
                        {item.label}
                      </a>
                    </li>
                  ))}
                </ul>
              </article>
            ))}
          </div>
        </div>

        <div>
          <h3 className="font-outfit mb-6 sm:text-2xl text-gray-700">
            Latest Listings
          </h3>

          <div className="grid  gap-6 grid-cols-2 lg:grid-cols-4 lg:gap-10">
            {latestListings.map((listing) => (
              <a
                className="rounded-4xl bg-white  text-gray-500 no-underline shadow-md shadow-gray-200 transition-transform duration-200 hover:scale-105"
                href={`/listings/${listing.id}`}
                key={listing.id}
              >
                <img
                  className="sm:h-[180px] w-full rounded-t-4xl bg-gray-100 object-cover"
                  src={listing.imageSrc}
                  alt=""
                />
                <div className="flex flex-col bg-white/40 gap-1 p-4">
                  <h4 className="mb-2 line-clamp-2 min-h-[24px] text-base leading-6 font-bold text-gray-700">
                    {listing.title}
                  </h4>
                  <div className="flex flex-col gap-1 text-sm font-medium text-gray-500 xl:flex-row xl:items-center xl:justify-between">
                    <span>{listing.city}</span>
                    <span>{getPostedAt(listing.createdAt)}</span>
                  </div>
                </div>
              
              </a>
            ))}
          </div>
        </div>
      </div>
    </section>
  )
}

export default BrowseListingsSection
