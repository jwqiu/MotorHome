const categoryGroups = [
  {
    icon: '🚐',
    title: 'Recreational Vehicles',
    items: ['Motorhomes', 'Campervans', 'Caravans'],
  },
  {
    icon: '🏡',
    title: 'Accommodation',
    items: ['Homes', 'Holiday Homes'],
  },
  {
    icon: '🛶',
    title: 'Canal Boats',
    items: ['Canal Boats'],
  },
]

const latestListings = [
  {
    title: 'Coastal Motorhome',
    location: 'Auckland',
    postedAt: '2 days ago',
  },
  {
    title: 'Family Holiday Home',
    location: 'Queenstown',
    postedAt: '3 days ago',
  },
  {
    title: 'Compact Campervan',
    location: 'Christchurch',
    postedAt: '5 days ago',
  },
  {
    title: 'Classic Canal Boat',
    location: 'Hamilton',
    postedAt: '1 week ago',
  },
]

function BrowseListingsSection() {
  return (
    <section className="w-full bg-white px-16 py-16 mb-16" aria-labelledby="browse-listings-title">
      <h2
        id="browse-listings-title"
        className="font-outfit mb-12 text-center text-2xl font-bold text-gray-700"
      >
        Find exchange opportunities for your next adventure
      </h2>

      <div className="rounded-4xl bg-gray-50 px-16 py-14 shadow-lg shadow-gray-200">
        <div className="mb-12">
          <h3 className="font-outfit mb-6 text-2xl font-bold text-gray-700">
            Browse by Category
          </h3>

          <div className="grid grid-cols-3 gap-12">
            {categoryGroups.map((group) => (
              <article
                className="rounded-4xl bg-white p-8 shadow-md shadow-gray-200 transition-transform duration-200 hover:scale-105"
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
                    <li key={item}>
                      <a
                        className="inline-flex font-semibold text-gray-500 no-underline transition-colors duration-200 hover:text-blue-500"
                        href="/listings"
                      >
                        {item}
                      </a>
                    </li>
                  ))}
                </ul>
              </article>
            ))}
          </div>
        </div>

        <div>
          <h3 className="font-outfit mb-6 text-2xl font-bold text-gray-700">
            Latest Listings
          </h3>

          <div className="grid grid-cols-4 gap-10">
            {latestListings.map((listing) => (
              <article
                className="rounded-4xl bg-white p-4 shadow-md shadow-gray-200 transition-transform duration-200 hover:scale-105"
                key={listing.title}
              >
                <div className="mb-4 h-[180px] rounded-4xl bg-gray-100" aria-hidden="true" />
                <h4 className="mb-2 text-base font-bold text-gray-700">{listing.title}</h4>
                <div className="flex items-center justify-between text-sm font-medium text-gray-500">
                  <span>{listing.location}</span>
                  <span>{listing.postedAt}</span>
                </div>
              </article>
            ))}
          </div>
        </div>
      </div>
    </section>
  )
}

export default BrowseListingsSection
