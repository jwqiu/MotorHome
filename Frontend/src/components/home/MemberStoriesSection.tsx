const memberStories = [
  {
    name: 'James Whitaker',
    initials: 'JW',
    avatarClassName: 'bg-sky-100 text-sky-700',
    quote:
      'We swapped our Auckland motorhome for three weeks in Devon. The listing details were accurate, the handover was easy, and we felt looked after from the first message.',
  },
  {
    name: 'Emma Collins',
    initials: 'EC',
    avatarClassName: 'bg-rose-100 text-rose-700',
    quote:
      'The enquiry process made it simple to compare dates, insurance notes, and vehicle features. We found a tidy campervan for the South Island in less than a week.',
  },
  {
    name: 'Daniel Moore',
    initials: 'DM',
    avatarClassName: 'bg-emerald-100 text-emerald-700',
    quote:
      'I liked being able to speak directly with another owner before committing. It made the exchange feel personal, practical, and much less stressful.',
  },
  {
    name: 'Sophie Laurent',
    initials: 'SL',
    avatarClassName: 'bg-amber-100 text-amber-700',
    quote:
      'Our family used the site to arrange a summer rental near Queenstown. The photos matched the vehicle, the owner replied quickly, and the whole trip felt smooth.',
  },
]

function MemberStoriesSection() {
  return (
    <section className="mb-12 w-full px-4 py-10 sm:px-8 sm:py-12 lg:mb-16 lg:px-16 lg:py-16" aria-labelledby="member-stories-title">
      <h2
        id="member-stories-title"
        className="font-outfit mb-8 text-center text-2xl font-bold text-gray-700 sm:mb-12"
      >
        What our members say
      </h2>

      <div className="rounded-4xl bg-gray-50 px-4 py-7 shadow-lg shadow-gray-200 sm:px-8 sm:py-10 lg:px-16 lg:py-14">
        <div className="grid grid-cols-2 gap-4 lg:gap-12">
          {memberStories.map((story, index) => (
            <article
              className="grid grid-cols-1 gap-5 rounded-4xl bg-white p-5 shadow-md shadow-gray-200 transition-transform duration-200 hover:scale-105 sm:grid-cols-[150px_1fr] sm:gap-6 sm:p-6 xl:grid-cols-[180px_1fr] xl:gap-8"
              key={`${story.name}-${index}`}
            >
              <div
                className={`font-outfit flex h-24 w-full items-center justify-center rounded-4xl text-4xl font-bold sm:h-[150px] ${story.avatarClassName}`}
                aria-hidden="true"
              >
                {story.initials}
              </div>

              <div className="flex flex-col justify-center">
                <h3 className="font-outfit mb-3 text-lg font-bold text-gray-700">
                  {story.name}
                </h3>

                <p className="m-0 text-sm font-medium leading-6 text-gray-500">
                  {story.quote}
                </p>
              </div>
            </article>
          ))}
        </div>
      </div>
    </section>
  )
}

export default MemberStoriesSection
