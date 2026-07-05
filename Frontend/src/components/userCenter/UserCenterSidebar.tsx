import type { UserCenterTab } from './userCenterTypes'

type UserCenterSidebarProps = {
  activeTab: UserCenterTab
  comingSoonMessage: string
  comingSoonTarget: string
  onComingSoonClick: (target: string, message: string) => void
  onTabChange: (tab: UserCenterTab) => void
}

function UserCenterSidebar({
  activeTab,
  comingSoonMessage,
  comingSoonTarget,
  onComingSoonClick,
  onTabChange,
}: UserCenterSidebarProps) {
  return (
    <aside className="self-start rounded-4xl bg-white p-5 shadow-lg shadow-blue-100 lg:sticky lg:top-32">
      <nav className="grid gap-2" aria-label="User center navigation">
        <button
          className={`h-12 cursor-pointer rounded-3xl border-0 px-5 text-left text-sm font-extrabold transition ${
            activeTab === 'profile' ? 'bg-blue-50 text-blue-600' : 'bg-white text-gray-500 hover:bg-blue-50'
          }`}
          onClick={() => onTabChange('profile')}
          type="button"
        >
          Profile
        </button>
        <button
          className={`h-12 cursor-pointer rounded-3xl border-0 px-5 text-left text-sm font-extrabold transition ${
            activeTab === 'listings' ? 'bg-blue-50 text-blue-600' : 'bg-white text-gray-500 hover:bg-blue-50'
          }`}
          onClick={() => onTabChange('listings')}
          type="button"
        >
          Manage Listings
        </button>
        <div className="mt-2 border-t border-blue-50 pt-4">
          <p className="m-0 px-5 pb-2 text-xs font-extrabold tracking-[0.12em] text-gray-400 uppercase">
            Enquiries
          </p>
          <button
            className={`h-12 w-full cursor-pointer rounded-3xl border-0 px-5 text-left text-sm font-extrabold transition ${
              activeTab === 'sent' ? 'bg-blue-50 text-blue-600' : 'bg-white text-gray-500 hover:bg-blue-50'
            }`}
            onClick={() => onTabChange('sent')}
            type="button"
          >
            Sent Enquiries
          </button>
          <button
            className={`h-12 w-full cursor-pointer rounded-3xl border-0 px-5 text-left text-sm font-extrabold transition ${
              activeTab === 'received' ? 'bg-blue-50 text-blue-600' : 'bg-white text-gray-500 hover:bg-blue-50'
            }`}
            onClick={() => onTabChange('received')}
            type="button"
          >
            Received Enquiries
          </button>
        </div>
        <div className="relative mt-2 border-t border-blue-50 pt-4">
          <button
            aria-describedby={comingSoonTarget === 'membership' ? 'membership-hint' : undefined}
            className="h-12 w-full cursor-not-allowed rounded-3xl border-0 bg-white px-5 text-left text-sm font-extrabold text-gray-300 transition hover:bg-gray-50"
            onClick={() => onComingSoonClick('membership', 'Membership is coming soon.')}
            type="button"
          >
            Membership
          </button>
          {comingSoonTarget === 'membership' ? (
            <div
              className="absolute left-5 bottom-[calc(100%+10px)] z-10 w-[220px] rounded-2xl bg-gray-800 px-4 py-3 text-xs leading-5 font-bold text-white shadow-lg shadow-gray-900/20"
              id="membership-hint"
              role="status"
            >
              {comingSoonMessage}
            </div>
          ) : null}
        </div>
      </nav>
    </aside>
  )
}

export default UserCenterSidebar
