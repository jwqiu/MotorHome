import type { DetailGroup } from './listingDetailData'

type ListingDetailSectionsProps = {
  groups: DetailGroup[]
  notices: string[]
  overview: string
}

function DetailSection({ group }: { group: DetailGroup }) {
  return (
    <section className="rounded-4xl bg-white p-7 shadow-lg shadow-blue-100 md:p-8">
      <h2 className="font-outfit m-0 mb-5 text-2xl font-extrabold text-gray-800">{group.title}</h2>
      <dl className="m-0 grid gap-4">
        {group.items.map((item) => (
          <div className="grid gap-1 border-b border-blue-50 pb-4 last:border-b-0 last:pb-0 md:grid-cols-[210px_1fr] md:gap-5" key={item.label}>
            <dt className="text-sm font-extrabold text-gray-700">{item.label}</dt>
            <dd className="m-0 text-sm leading-6 text-gray-500">{item.value}</dd>
          </div>
        ))}
      </dl>
    </section>
  )
}

function ListingDetailSections({ groups, notices, overview }: ListingDetailSectionsProps) {
  return (
    <div className="mt-8 grid gap-6">
      <section className="rounded-4xl bg-white p-7 shadow-lg shadow-blue-100 md:p-8" id="overview">
        <p className="mb-3 text-xs font-extrabold tracking-[0.16em] text-blue-500 uppercase">Overview</p>
        <h2 className="font-outfit m-0 mb-4 text-2xl font-extrabold text-gray-800">Vehicle Brief Information</h2>
        <p className="m-0 text-sm leading-7 text-gray-500">{overview}</p>
      </section>

      <section className="rounded-4xl bg-white p-7 shadow-lg shadow-blue-100 md:p-8" id="notices">
        <p className="mb-3 text-xs font-extrabold tracking-[0.16em] text-blue-500 uppercase">Notices</p>
        <h2 className="font-outfit m-0 mb-5 text-2xl font-extrabold text-gray-800">Owner Notes</h2>
        <ul className="m-0 flex list-none gap-3 p-0">
          {notices.map((notice) => (
            <li className="rounded-3xl border border-blue-100 bg-blue-50 px-4 py-3 text-sm font-bold text-gray-700" key={notice}>
              {notice}
            </li>
          ))}
        </ul>
      </section>

      {groups.map((group) => (
        <DetailSection group={group} key={group.title} />
      ))}
    </div>
  )
}

export default ListingDetailSections
