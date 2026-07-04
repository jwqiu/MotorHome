type OwnerContactCardProps = {
  listingTitle: string
  owner: {
    about: string
    displayName: string
    location: string
    memberSince: string
    spokenLanguages: string
  }
  isEnquiryPending: boolean
  isEnquiryStatusLoading: boolean
  isOwnListing: boolean
  onOpenEnquiry: () => void
}

function OwnerContactCard({
  listingTitle,
  isEnquiryPending,
  isEnquiryStatusLoading,
  isOwnListing,
  owner,
  onOpenEnquiry,
}: OwnerContactCardProps) {
  const initials = owner.displayName.slice(0, 2).toUpperCase()
  const isRequestDisabled = isOwnListing || isEnquiryPending || isEnquiryStatusLoading
  const ownerAbout = owner.about.trim() || "No introduction yet."
  const memberSince = owner.memberSince.trim() || 'Not available'
  const spokenLanguages = owner.spokenLanguages.trim() || 'Not specified'
  const requestButtonLabel = isEnquiryStatusLoading
    ? 'Checking...'
    : isOwnListing
      ? 'Your Listing'
      : isEnquiryPending
        ? 'Awaiting Response'
        : 'Request a swap'

  return (
    <aside className="self-start rounded-4xl bg-white p-7 shadow-lg shadow-blue-100 md:p-8 xl:sticky xl:top-32">
      <div className="mx-auto mb-5 flex h-24 w-24 items-center justify-center rounded-full bg-blue-50 text-2xl font-extrabold text-blue-500">
        {initials}
      </div>
      <div className="text-center">
        <h2 className="font-outfit m-0 text-3xl font-extrabold text-gray-800">{owner.displayName}</h2>
        <p className="mt-1 mb-0 text-xs font-bold text-gray-400">{owner.location}</p>
      </div>

      {/* <div className="mt-6 grid gap-3">
        <div className="rounded-3xl border border-blue-100 bg-blue-50 px-4 py-3 text-center text-sm font-extrabold text-blue-600">
          {certification}
        </div>
        <div className="rounded-3xl border border-blue-100 bg-white px-4 py-3 text-center text-sm font-extrabold text-gray-700">
          {roadPoints}
        </div>
      </div> */}

      <div className="  border-blue-50 pt-6">
        <p className="m-0 mt-3 text-sm text-center leading-6 text-gray-400">{ownerAbout}</p>
        <dl className="mt-8 grid gap-3 text-sm">
          <div>
            <dt className="font-extrabold text-gray-800">Member since</dt>
            <dd className="m-0 text-gray-500">{memberSince}</dd>
          </div>
          <div>
            <dt className="font-extrabold text-gray-800">Spoken language(s)</dt>
            <dd className="m-0 text-gray-500">{spokenLanguages}</dd>
          </div>
        </dl>
      </div>

      <div className="mt-7 grid gap-3">
        <button
          className={`font-outfit h-13 rounded-4xl border text-base font-extrabold transition ${
            isRequestDisabled
              ? 'cursor-not-allowed border-gray-200 bg-gray-100 text-gray-400 shadow-none'
              : 'cursor-pointer border-blue-100 bg-blue-500 text-white shadow-lg shadow-blue-200 hover:border-blue-200 hover:bg-blue-600'
          }`}
          disabled={isRequestDisabled}
          onClick={onOpenEnquiry}
          type="button"
        >
          {requestButtonLabel}
        </button>
      </div>

      <p className="mt-5 mb-0 text-center text-xs leading-5 text-gray-400">
        {isOwnListing
          ? "This is your listing. You can't request an exchange with yourself."
          : `Ask about availability, timing, and swap details for ${listingTitle}.`}
      </p>
    </aside>
  )
}

export default OwnerContactCard
