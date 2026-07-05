import type { SentEnquiry, SentEnquiryStatus } from './userCenterTypes'

type SentEnquiriesPanelProps = {
  cancellingEnquiryId: number | null
  enquiryLoadMessage: string
  getStatusDescription: (status: SentEnquiryStatus) => string
  onCancelSentEnquiry: (enquiry: SentEnquiry) => void
  sentEnquiryItems: SentEnquiry[]
}

function SentEnquiriesPanel({
  cancellingEnquiryId,
  enquiryLoadMessage,
  getStatusDescription,
  onCancelSentEnquiry,
  sentEnquiryItems,
}: SentEnquiriesPanelProps) {
  return (
    <section className="rounded-4xl bg-white p-7 shadow-lg shadow-blue-100 md:p-8">
      <h2 className="font-outfit m-0 mb-2 text-3xl font-extrabold text-gray-800">
        Sent Enquiries
      </h2>
      <p className="mt-0 mb-6 text-sm text-gray-400">
        Track your outgoing swap requests and follow up when an owner responds.
      </p>
      {enquiryLoadMessage ? (
        <p className="m-0 mb-4 rounded-3xl bg-red-50 px-4 py-3 text-sm font-bold text-red-500">
          {enquiryLoadMessage}
        </p>
      ) : null}
      <div className="overflow-x-auto">
        <table className="w-full min-w-[920px] border-separate border-spacing-y-3 text-left text-sm">
          <thead>
            <tr className="text-gray-400">
              <th className="px-4 py-3">Listing</th>
              <th className="px-4 py-3">Owner</th>
              <th className="px-4 py-3">Type</th>
              <th className="px-4 py-3">Date sent</th>
              <th className="px-4 py-3">Status</th>
              <th className="px-4 py-3">Actions</th>
            </tr>
          </thead>
          <tbody>
            {sentEnquiryItems.map((enquiry) => (
              <tr className="bg-blue-50/50 text-gray-600" key={enquiry.id}>
                <td className="rounded-l-3xl px-4 py-4">
                  <a className=" text-blue-500 no-underline hover:text-blue-600" href={`/listings/${enquiry.listing.id}`}>
                    {enquiry.listing.title}
                  </a>
                </td>
                <td className="px-4 py-4">{enquiry.owner}</td>
                <td className="px-4 py-4">{enquiry.type}</td>
                <td className="px-4 py-4">{enquiry.date}</td>
                <td className="px-4 py-4">
                  <span className="block font-extrabold text-gray-700">{enquiry.status}</span>
                  <span className="block max-w-[230px] text-xs leading-5 text-gray-400">
                    {getStatusDescription(enquiry.status)}
                  </span>
                </td>
                <td className="rounded-r-3xl px-4 py-4">
                  <div className="flex flex-wrap gap-2">
                    <a
                      className="inline-flex h-9 items-center justify-center rounded-4xl border border-blue-100 bg-white px-4 text-xs text-blue-600 no-underline transition hover:bg-blue-50"
                      href={`/user-center/enquiries/sent/${enquiry.id}`}
                      rel="noreferrer"
                      target="_blank"
                    >
                      View details
                    </a>
                    {enquiry.status === 'Pending' ? (
                      <button
                        className="h-9 cursor-pointer rounded-4xl border border-red-100 bg-red-50 px-4 text-xs font-extrabold text-red-500 transition hover:bg-red-100"
                        disabled={cancellingEnquiryId === enquiry.id}
                        onClick={() => onCancelSentEnquiry(enquiry)}
                        type="button"
                      >
                        {cancellingEnquiryId === enquiry.id ? 'Cancelling...' : 'Cancel request'}
                      </button>
                    ) : null}
                  </div>
                </td>
              </tr>
            ))}
            {sentEnquiryItems.length === 0 ? (
              <tr>
                <td className="rounded-3xl bg-blue-50/50 px-4 py-5 text-sm text-gray-400" colSpan={6}>
                  No sent enquiries yet.
                </td>
              </tr>
            ) : null}
          </tbody>
        </table>
      </div>
    </section>
  )
}

export default SentEnquiriesPanel
