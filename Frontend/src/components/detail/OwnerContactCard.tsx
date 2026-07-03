type OwnerContactCardProps = {
  listingTitle: string
  owner: {
    about: string
    displayName: string
    location: string
    memberSince: string
    spokenLanguages: string
  }
  onOpenEnquiry: () => void
}

function OwnerContactCard({
  listingTitle,
  owner,
  onOpenEnquiry,
}: OwnerContactCardProps) {
  const initials = owner.displayName.slice(0, 2).toUpperCase()

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

      <div className="mt-6  border-blue-50 pt-6">
        <p className="m-0 text-sm leading-6 text-gray-500">{owner.about}</p>
        <dl className="mt-5 grid gap-3 text-sm">
          <div>
            <dt className="font-extrabold text-gray-800">Member since</dt>
            <dd className="m-0 text-gray-500">{owner.memberSince}</dd>
          </div>
          <div>
            <dt className="font-extrabold text-gray-800">Spoken language(s)</dt>
            <dd className="m-0 text-gray-500">{owner.spokenLanguages}</dd>
          </div>
        </dl>
      </div>

      <div className="mt-7 grid gap-3">
        {/* <button
          className="font-outfit h-13 cursor-pointer rounded-4xl border-0 bg-blue-500 text-base font-extrabold text-white shadow-lg shadow-blue-200 transition hover:bg-blue-600"
          onClick={onOpenEnquiry}
          type="button"
        >
          Send a message
        </button> */}
        <button
          className="font-outfit h-13 cursor-pointer rounded-4xl border border-blue-100 bg-blue-500 text-base font-extrabold text-white transition hover:border-blue-200 hover:bg-blue-100"
          onClick={onOpenEnquiry}
          type="button"
        >
          Request a swap
        </button>
      </div>

      <p className="mt-5 mb-0 text-center text-xs leading-5 text-gray-400">
        Ask about availability, timing, and swap details for {listingTitle}.
      </p>
    </aside>
  )
}

export default OwnerContactCard
