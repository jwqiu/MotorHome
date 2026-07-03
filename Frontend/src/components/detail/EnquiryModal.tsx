type EnquiryModalProps = {
  listingTitle: string
  onClose: () => void
}

function EnquiryModal({ listingTitle, onClose }: EnquiryModalProps) {
  return (
    <div
      aria-labelledby="enquiry-modal-title"
      aria-modal="true"
      className="fixed inset-0 z-40 flex items-center justify-center bg-gray-900/40 px-6 backdrop-blur-sm"
      role="dialog"
    >
      <div className="w-full max-w-[520px] rounded-4xl bg-white p-7 shadow-2xl shadow-gray-900/20 md:p-8">
        <div className="mb-6 flex items-start justify-between gap-6">
          <div>
            <p className="mb-2 text-xs font-extrabold tracking-[0.16em] text-blue-500 uppercase">Send enquiry</p>
            <h2 id="enquiry-modal-title" className="font-outfit m-0 text-2xl font-extrabold text-gray-800">
              Ask about {listingTitle}
            </h2>
          </div>
          <button
            aria-label="Close enquiry form"
            className="flex h-10 w-10 shrink-0 cursor-pointer items-center justify-center rounded-full border border-blue-100 bg-blue-50 text-xl font-bold text-gray-700"
            onClick={onClose}
            type="button"
          >
            x
          </button>
        </div>

        <form className="grid gap-4">
          <label className="grid gap-2 text-sm font-extrabold text-gray-700">
            Name
            <input className="h-12 rounded-3xl border border-blue-100 px-4 text-sm font-semibold text-gray-700 outline-none focus:border-blue-400" />
          </label>
          <label className="grid gap-2 text-sm font-extrabold text-gray-700">
            Email
            <input className="h-12 rounded-3xl border border-blue-100 px-4 text-sm font-semibold text-gray-700 outline-none focus:border-blue-400" type="email" />
          </label>
          <label className="grid gap-2 text-sm font-extrabold text-gray-700">
            Message
            <textarea
              className="min-h-32 resize-none rounded-3xl border border-blue-100 px-4 py-3 text-sm font-semibold text-gray-700 outline-none focus:border-blue-400"
              defaultValue={`Hi, I am interested in ${listingTitle}.`}
            />
          </label>
          <button
            className="font-outfit mt-2 h-13 cursor-pointer rounded-4xl border-0 bg-blue-500 text-lg font-extrabold text-white shadow-lg shadow-blue-200 transition hover:bg-blue-600"
            type="button"
          >
            Send Message
          </button>
        </form>
      </div>
    </div>
  )
}

export default EnquiryModal
