const listingsPerPage = 5

function getCurrentPage(totalPages: number) {
  const page = Number(new URLSearchParams(window.location.search).get('page') ?? '1')

  if (!Number.isInteger(page) || page < 1) {
    return 1
  }

  return Math.min(page, totalPages)
}

type ListingPaginationProps = {
  totalListings: number
}

function ListingPagination({ totalListings }: ListingPaginationProps) {
  const totalPages = Math.ceil(totalListings / listingsPerPage)

  if (totalPages <= 1) {
    return null
  }

  const currentPage = getCurrentPage(totalPages)
  const pages = Array.from({ length: totalPages }, (_, index) => index + 1)

  return (
    <nav className="flex justify-center md:justify-start" aria-label="Listings pagination">
      <ol className="m-0 flex list-none gap-3 rounded-4xl bg-white p-2 shadow-lg shadow-blue-100">
        {pages.map((page) => {
          const isActive = page === currentPage

          return (
            <li key={page}>
              <a
                className={`flex h-10 w-10 items-center justify-center rounded-full text-sm font-extrabold no-underline transition-colors ${
                  isActive
                    ? 'bg-blue-500 text-white shadow-md shadow-blue-200'
                    : 'bg-white text-gray-500 hover:bg-blue-50 hover:text-blue-600'
                }`}
                href={`/listings?page=${page}`}
                aria-current={isActive ? 'page' : undefined}
              >
                {page}
              </a>
            </li>
          )
        })}
      </ol>
    </nav>
  )
}

export default ListingPagination
