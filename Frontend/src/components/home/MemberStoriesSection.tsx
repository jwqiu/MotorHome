const memberStories = [
  {
    name: 'Member Name',
    quote:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean euismod bibendum laoreet.',
  },
  {
    name: 'Member Name',
    quote:
      'Proin gravida dolor sit amet lacus accumsan et viverra justo commodo.',
  },
  {
    name: 'Member Name',
    quote:
      'Sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.',
  },
  {
    name: 'Member Name',
    quote:
      'Nam fermentum, nulla luctus pharetra vulputate, felis tellus mollis orci.',
  },
]

function MemberStoriesSection() {
  return (
    <section className="w-full px-16 py-16 mb-16" aria-labelledby="member-stories-title">
      <h2
        id="member-stories-title"
        className="font-outfit mb-12 text-center text-2xl font-bold text-gray-700"
      >
        What our members say
      </h2>

      <div className="rounded-4xl bg-gray-50 px-16 py-14 shadow-lg shadow-gray-200">
        <div className="grid grid-cols-2 gap-12">
          {memberStories.map((story, index) => (
            <article
              className="grid grid-cols-[180px_1fr] gap-8 rounded-4xl bg-white p-6 shadow-md shadow-gray-200 transition-transform duration-200 hover:scale-105"
              key={`${story.name}-${index}`}
            >
              <div className="h-[150px] rounded-4xl bg-gray-100" aria-hidden="true" />

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
