type ProfilePanelProps = {
  bio: string
  comingSoonMessage: string
  comingSoonTarget: string
  isSavingProfile: boolean
  onBioChange: (bio: string) => void
  onComingSoonClick: (target: string, message: string) => void
  onSave: () => void
  profileEmail: string
  profileIdentityVerified: boolean
  profileLoadMessage: string
  profileSaveMessage: string
  profileUserName: string
  showProfileSaved: boolean
}

function ProfilePanel({
  bio,
  comingSoonMessage,
  comingSoonTarget,
  isSavingProfile,
  onBioChange,
  onComingSoonClick,
  onSave,
  profileEmail,
  profileIdentityVerified,
  profileLoadMessage,
  profileSaveMessage,
  profileUserName,
  showProfileSaved,
}: ProfilePanelProps) {
  return (
    <section className="rounded-4xl bg-white p-12 shadow-lg shadow-blue-100 ">
      <h2 className="font-outfit m-0 mb-6 text-3xl font-extrabold text-gray-800">Profile</h2>
      <div className="grid gap-8 xl:grid-cols-[220px_1fr]">
        <div>
          <div className="mb-4 flex h-36 w-36 items-center justify-center overflow-hidden rounded-full bg-blue-50 text-4xl font-extrabold text-blue-500">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" className="size-16">
              <path strokeLinecap="round" strokeLinejoin="round" d="M17.982 18.725A7.488 7.488 0 0 0 12 15.75a7.488 7.488 0 0 0-5.982 2.975m11.963 0a9 9 0 1 0-11.963 0m11.963 0A8.966 8.966 0 0 1 12 21a8.966 8.966 0 0 1-5.982-2.275M15 9.75a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
            </svg>
          </div>
          <div className="relative inline-flex">
            <button
              aria-describedby={comingSoonTarget === 'avatar' ? 'avatar-hint' : undefined}
              aria-disabled="true"
              className="inline-flex h-11 cursor-not-allowed items-center justify-center rounded-4xl border border-gray-200 bg-gray-50 px-5 text-sm font-semibold text-gray-400 shadow-none transition hover:border-gray-200 hover:bg-gray-50"
              onClick={() => onComingSoonClick('avatar', 'Change avatar will be supported soon.')}
              type="button"
            >
              Change avatar
            </button>
            {comingSoonTarget === 'avatar' ? (
              <div
                className="absolute left-0 bottom-[calc(100%+10px)] z-10 w-[230px] rounded-2xl bg-gray-800 px-4 py-3 text-xs leading-5 font-bold text-white shadow-lg shadow-gray-900/20"
                id="avatar-hint"
                role="status"
              >
                {comingSoonMessage}
              </div>
            ) : null}
          </div>
        </div>

        <div className="grid gap-5">
          <div className="grid gap-4 md:grid-cols-2">
            <label className="grid gap-2 text-sm font-extrabold text-gray-700">
              User name
              <input className="h-12 rounded-3xl border border-blue-100 bg-gray-50 px-4 text-sm font-bold text-gray-500" readOnly value={profileUserName} />
            </label>
            <label className="grid gap-2 text-sm font-extrabold text-gray-700">
              Bound email
              <input className="h-12 rounded-3xl border border-blue-100 bg-gray-50 px-4 text-sm font-bold text-gray-500" readOnly value={profileEmail} />
            </label>
          </div>
          {profileLoadMessage ? (
            <p className="m-0 rounded-3xl bg-red-50 px-4 py-3 text-sm font-bold text-red-500">
              {profileLoadMessage}
            </p>
          ) : null}
          <div className="rounded-3xl border border-blue-100 bg-blue-50/50 px-5 py-4">
            <div className="flex flex-wrap items-center justify-between gap-3">
              <div>
                <p className="m-0 text-sm font-extrabold text-gray-800">Identity verification</p>
                {profileIdentityVerified ? (
                  <p className="mt-2 mb-0 flex items-center gap-2 text-sm font-bold text-blue-600">
                    <span className="inline-flex h-5 w-5 items-center justify-center rounded-full bg-blue-500 text-white" aria-hidden="true">
                      <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={2.5} stroke="currentColor" className="h-3.5 w-3.5">
                        <path strokeLinecap="round" strokeLinejoin="round" d="m4.5 12.75 6 6 9-13.5" />
                      </svg>
                    </span>
                    Verified
                  </p>
                ) : (
                  <p className="mt-2 mb-0 text-sm text-gray-500">Not verified</p>
                )}
              </div>
              {!profileIdentityVerified ? (
                <a
                  className="inline-flex h-11 items-center justify-center rounded-4xl border border-blue-100 bg-white px-5 text-sm font-extrabold text-blue-600 no-underline transition hover:bg-blue-50"
                  href="/identity-verification"
                >
                  Verify now
                </a>
              ) : null}
            </div>
          </div>
          <label className="grid gap-2 text-sm font-extrabold text-gray-700">
            About me
            <textarea
              className="min-h-40 resize-none rounded-3xl border border-blue-100 px-4 py-3 font-normal text-sm leading-6 text-gray-700 outline-none focus:border-blue-400"
              onChange={(event) => onBioChange(event.target.value)}
              value={bio}
            />
          </label>
          <div className="flex flex-col items-start gap-3">
            <p className="m-0 text-xs text-gray-400">
              Save your avatar and introduction changes before leaving this page.
            </p>
            <button
              className="font-outfit h-12 cursor-pointer rounded-4xl border-0 bg-blue-500 px-8 text-sm font-extrabold text-white shadow-lg shadow-blue-200 transition hover:bg-blue-600 disabled:cursor-not-allowed disabled:bg-gray-300 disabled:shadow-none"
              disabled={isSavingProfile}
              onClick={onSave}
              type="button"
            >
              {isSavingProfile ? 'Saving...' : 'Save'}
            </button>
          </div>
          {profileSaveMessage ? (
            <p className="m-0 rounded-3xl bg-red-50 px-4 py-3 text-sm font-bold text-red-500">
              {profileSaveMessage}
            </p>
          ) : null}
          {showProfileSaved ? (
            <p className="m-0 rounded-3xl bg-blue-50 px-4 py-3 text-sm font-bold text-blue-600">
              Profile changes saved.
            </p>
          ) : null}
        </div>
      </div>
    </section>
  )
}

export default ProfilePanel
