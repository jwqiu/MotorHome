type SignInRequiredModalProps = {
  createAccountHref: string
  onClose: () => void
  signInHref: string
}

function SignInRequiredModal({ createAccountHref, onClose, signInHref }: SignInRequiredModalProps) {
  return (
    <div
      aria-labelledby="sign-in-required-title"
      aria-modal="true"
      className="fixed inset-0 z-40 flex items-center justify-center bg-gray-900/40 px-6 backdrop-blur-sm"
      role="dialog"
    >
      <div className="w-full max-w-[500px] rounded-4xl bg-white p-8 shadow-2xl shadow-gray-900/20">
        <div className="mb-6 flex items-start justify-between gap-6">
          <div>
            <p className="mb-3 text-xs font-extrabold tracking-[0.16em] text-blue-500 uppercase">
              Request a swap
            </p>
            <h2 id="sign-in-required-title" className="font-outfit m-0 text-3xl font-extrabold text-gray-800">
              Sign in to request a swap
            </h2>
          </div>
          <button
            aria-label="Close sign in prompt"
            className="flex h-10 w-10 shrink-0 cursor-pointer items-center justify-center rounded-full border border-blue-100 bg-blue-50 text-xl font-bold text-gray-700"
            onClick={onClose}
            type="button"
          >
            x
          </button>
        </div>

        <p className="m-0 text-sm leading-6 text-gray-500">
          To contact the owner and send a swap request, please sign in or create an account first.
        </p>

        <div className="mt-7 grid gap-3 sm:grid-cols-2">
          <a
            className="font-outfit flex h-13 items-center justify-center rounded-4xl bg-blue-500 text-base font-extrabold text-white no-underline shadow-lg shadow-blue-200 transition hover:bg-blue-600"
            href={signInHref}
          >
            Sign in
          </a>
          <a
            className="font-outfit flex h-13 items-center justify-center rounded-4xl border border-blue-100 bg-blue-50 text-base font-extrabold text-blue-600 no-underline transition hover:bg-blue-100"
            href={createAccountHref}
          >
            Create account
          </a>
        </div>

        <p className="mt-5 mb-0 text-center text-xs leading-5 text-gray-400">
          You&apos;ll be returned to this listing after signing in.
        </p>
      </div>
    </div>
  )
}

export default SignInRequiredModal
