type ListingDeleteNotificationsProps = {
  onCloseBlocked: () => void
  showListingDeleted: boolean
  showListingDeleteBlocked: boolean
}

function ListingDeleteNotifications({
  onCloseBlocked,
  showListingDeleted,
  showListingDeleteBlocked,
}: ListingDeleteNotificationsProps) {
  return (
    <>
      {showListingDeleted ? (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-gray-900/15 px-6 backdrop-blur-sm">
          <div className="pointer-events-auto flex items-center justify-between gap-3 rounded-3xl border border-gray-100 bg-white px-6 py-4 text-center shadow-2xl shadow-gray-900/20">
            <p className="m-0 text-sm font-extrabold text-gray-900">Listing deleted successfully</p>
          </div>
        </div>
      ) : null}
      {showListingDeleteBlocked ? (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-gray-900/15 px-6 backdrop-blur-sm">
          <div className="pointer-events-auto relative flex max-w-[620px] items-start gap-4 rounded-3xl border border-gray-100 bg-white px-7 py-6 pr-14 text-left shadow-2xl shadow-gray-900/20">
            <button
              aria-label="Close delete warning"
              className="absolute top-4 right-4 cursor-pointer border-0 bg-transparent p-1 text-xl leading-none font-extrabold text-gray-300 transition hover:text-gray-500"
              onClick={onCloseBlocked}
              type="button"
            >
              x
            </button>
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.8} stroke="currentColor" className="mt-0.5 h-7 w-7 shrink-0 text-red-500">
              <path strokeLinecap="round" strokeLinejoin="round" d="M12 9v3.75m0 3.75h.008v.008H12V16.5Zm9-4.5a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z" />
            </svg>
            <div>
              <h2 className="m-0 text-lg leading-7 font-extrabold text-gray-900">Unable to Delete Listing</h2>
              <p className="mt-2 mb-0 text-sm leading-6 font-bold text-gray-700">
                This listing is linked to active exchange enquiries. Please complete, decline, or cancel the related enquiries before deleting it.
              </p>
            </div>
          </div>
        </div>
      ) : null}
    </>
  )
}

export default ListingDeleteNotifications
