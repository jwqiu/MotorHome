import type { Listing } from '../listing/listingData'

type DeleteListingDialogProps = {
  isDeletingListing: boolean
  listingDeleteMessage: string
  listingToDelete: Listing | null
  onCancel: () => void
  onConfirm: () => void
}

function DeleteListingDialog({
  isDeletingListing,
  listingDeleteMessage,
  listingToDelete,
  onCancel,
  onConfirm,
}: DeleteListingDialogProps) {
  if (!listingToDelete) {
    return null
  }

  return (
    <div
      aria-labelledby="delete-listing-title"
      aria-modal="true"
      className="fixed inset-0 z-50 flex items-center justify-center bg-gray-900/40 px-6 backdrop-blur-sm"
      role="dialog"
    >
      <div className="w-full max-w-[520px] rounded-4xl bg-white p-8 shadow-2xl shadow-gray-900/20">
        <h2 id="delete-listing-title" className="font-outfit m-0 text-2xl font-extrabold text-gray-800">
          Delete listing?
        </h2>
        <p className="mt-4 mb-0 text-sm leading-6 text-gray-500">
          This will permanently delete "{listingToDelete.title}". Any enquiries connected to this listing,
          including received enquiries and enquiries where it was offered, will be deleted at the same time.
        </p>
        {listingDeleteMessage ? (
          <p className="mt-4 mb-0 rounded-3xl bg-red-50 px-4 py-3 text-sm font-bold text-red-500">
            {listingDeleteMessage}
          </p>
        ) : null}
        <div className="mt-7 flex justify-end gap-3">
          <button
            className="h-11 cursor-pointer rounded-4xl border border-blue-100 bg-white px-6 text-sm font-extrabold text-gray-500 shadow-md shadow-blue-100 disabled:cursor-not-allowed disabled:bg-gray-50 disabled:text-gray-300"
            disabled={isDeletingListing}
            onClick={onCancel}
            type="button"
          >
            Cancel
          </button>
          <button
            className="h-11 cursor-pointer rounded-4xl border-0 bg-red-500 px-6 text-sm font-extrabold text-white shadow-lg shadow-red-100 transition hover:bg-red-600 disabled:cursor-not-allowed disabled:bg-gray-300 disabled:shadow-none"
            disabled={isDeletingListing}
            onClick={onConfirm}
            type="button"
          >
            {isDeletingListing ? 'Deleting...' : 'Confirm delete'}
          </button>
        </div>
      </div>
    </div>
  )
}

export default DeleteListingDialog
