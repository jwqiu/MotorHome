import type { Listing } from '../listing/listingData'

type ManageListingsPanelProps = {
  getReceivedEnquiryCount: (listingId: number) => number
  listingLoadMessage: string
  onRequestDelete: (listing: Listing) => void
  userListings: Listing[]
}

function ManageListingsPanel({
  getReceivedEnquiryCount,
  listingLoadMessage,
  onRequestDelete,
  userListings,
}: ManageListingsPanelProps) {
  return (
    <section className="rounded-4xl bg-white p-7 shadow-lg shadow-blue-100 md:p-8">
      <div className="mb-6 flex flex-wrap items-center justify-between gap-4">
        <div>
          <h2 className="font-outfit m-0 text-3xl font-extrabold text-gray-800">Manage Listings</h2>
          <p className="mt-2 mb-0 text-sm text-gray-400">Published listings connected to your account.</p>
        </div>
        <div>
          <a
            className="inline-flex h-12 items-center rounded-4xl border-0 bg-blue-500 px-6 text-sm font-extrabold text-white no-underline shadow-lg shadow-blue-200 transition hover:bg-blue-600"
            href="/user-center/listings/new"
          >
            Add New Listing
          </a>
        </div>
      </div>
      {listingLoadMessage ? (
        <p className="m-0 mb-4 rounded-3xl bg-red-50 px-4 py-3 text-sm font-bold text-red-500">
          {listingLoadMessage}
        </p>
      ) : null}

      <div className="overflow-x-auto">
        <table className="w-full min-w-[760px] border-separate border-spacing-y-3 text-left text-sm">
          <thead>
            <tr className="text-gray-400">
              <th className="px-4 py-3">Title</th>
              <th className="px-4 py-3">Category</th>
              <th className="px-4 py-3">Location</th>
              <th className="px-4 py-3">Available For</th>
              <th className="px-4 py-3">Created</th>
              <th className="px-4 py-3">Status</th>
              <th className="px-4 py-3">Enquiries</th>
              <th className="px-4 py-3">Action</th>
            </tr>
          </thead>
          <tbody>
            {userListings.map((listing) => (
              <tr className="bg-blue-50/50 text-gray-600" key={listing.id}>
                <td className="rounded-l-3xl px-4 py-4">
                  <a className="font-extrabold text-blue-500 no-underline hover:text-blue-600" href={`/listings/${listing.id}`}>
                    {listing.title}
                  </a>
                </td>
                <td className="px-4 py-4">{listing.listingType}</td>
                <td className="px-4 py-4">{listing.currentLocation}</td>
                <td className="px-4 py-4">{listing.exchangeTypes.join(', ')}</td>
                <td className="px-4 py-4">{listing.createdAt}</td>
                <td className="px-4 py-4">Active</td>
                <td className="px-4 py-4">{getReceivedEnquiryCount(listing.listingId)}</td>
                <td className="rounded-r-3xl px-4 py-4">
                  <div className="relative flex gap-3">
                    <div>
                      <a
                        className="text-sm font-bold text-blue-500 no-underline hover:text-blue-600"
                        href={`/user-center/listings/${listing.id}/edit`}
                      >
                        Edit
                      </a>
                    </div>
                    <div>
                      <button
                        className="cursor-pointer border-0 bg-transparent p-0 text-sm font-bold text-red-400 hover:text-red-500"
                        onClick={() => onRequestDelete(listing)}
                        type="button"
                      >
                        Delete
                      </button>
                    </div>
                  </div>
                </td>
              </tr>
            ))}
            {userListings.length === 0 ? (
              <tr>
                <td className="rounded-3xl bg-blue-50/50 px-4 py-5 text-sm text-gray-400" colSpan={8}>
                  No listings connected to your account yet.
                </td>
              </tr>
            ) : null}
          </tbody>
        </table>
      </div>
    </section>
  )
}

export default ManageListingsPanel
