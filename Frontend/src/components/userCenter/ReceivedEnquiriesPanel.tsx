import { getReceivedStatusDescription } from './userCenterData'
import type { ManageReceivedEnquiry } from './userCenterTypes'

type ReceivedEnquiriesPanelProps = {
  enquiryLoadMessage: string
  receivedEnquiryItems: ManageReceivedEnquiry[]
}

function ReceivedEnquiriesPanel({
  enquiryLoadMessage,
  receivedEnquiryItems,
}: ReceivedEnquiriesPanelProps) {
  return (
    <section className="rounded-4xl bg-white p-7 shadow-lg shadow-blue-100 md:p-8">
      <h2 className="font-outfit m-0 mb-2 text-3xl font-extrabold text-gray-800">
        Received Enquiries
      </h2>
      <p className="mt-0 text-sm text-gray-400">
        * Review incoming swap requests and decide whether to continue the discussion.
      </p>
      <p className="mt-0 mb-6 text-sm text-gray-400">
        * Once you accept an enquiry and agree to discuss, your email address will be shared with the enquirer so they can contact you directly for more details.
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
              <th className="px-4 py-3">Sender</th>
              <th className="px-4 py-3">Type</th>
              <th className="px-4 py-3">Date received</th>
              <th className="px-4 py-3">Status</th>
              <th className="px-4 py-3">Actions</th>
            </tr>
          </thead>
          <tbody>
            {receivedEnquiryItems.map((enquiry) => (
              <tr className="bg-blue-50/50 text-gray-600" key={enquiry.id}>
                <td className="rounded-l-3xl px-4 py-4">
                  <a className="font-extrabold text-blue-500 no-underline hover:text-blue-600" href={`/listings/${enquiry.yourListing.id}`}>
                    {enquiry.yourListing.title}
                  </a>
                </td>
                <td className="px-4 py-4">{enquiry.senderName}</td>
                <td className="px-4 py-4">{enquiry.type}</td>
                <td className="px-4 py-4">{enquiry.dateReceived}</td>
                <td className="px-4 py-4">
                  <span className="block font-extrabold text-gray-700">{enquiry.status}</span>
                  <span className="block max-w-[220px] text-xs leading-5 text-gray-400">
                    {getReceivedStatusDescription(enquiry.status)}
                  </span>
                </td>
                <td className="rounded-r-3xl px-4 py-4">
                  <a
                    className="inline-flex h-9 items-center justify-center rounded-4xl border border-blue-100 bg-white px-4 text-xs font-extrabold text-blue-600 no-underline transition hover:bg-blue-50"
                    href={`/user-center/enquiries/received/${enquiry.id}`}
                    rel="noreferrer"
                    target="_blank"
                  >
                    View details
                  </a>
                </td>
              </tr>
            ))}
            {receivedEnquiryItems.length === 0 ? (
              <tr>
                <td className="rounded-3xl bg-blue-50/50 px-4 py-5 text-sm text-gray-400" colSpan={6}>
                  No received enquiries yet.
                </td>
              </tr>
            ) : null}
          </tbody>
        </table>
      </div>
    </section>
  )
}

export default ReceivedEnquiriesPanel
