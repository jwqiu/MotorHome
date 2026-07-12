const steps = [
  {
    number: '01',
    title: 'Create your account',
    description:
      'Set up your profile and prepare the basics before you start browsing or listing items.',
  },
  {
    number: '02',
    title: 'Find what you need',
    description:
      'Search by location and explore exchange opportunities that match your next adventure.',
  },
  {
    number: '03',
    title: 'Contact the owner',
    description:
      'Send a message, confirm the details, and arrange the exchange directly with the owner.',
  },
]

function HowItWorksSection() {
  return (
    <section className="mb-12 w-full px-4 sm:px-8 lg:mb-16 lg:px-16" aria-labelledby="how-it-works-title">
      <h2
        id="how-it-works-title"
        className="font-outfit mb-8 text-center text-2xl font-bold text-gray-700 sm:mb-12"
      >
        How it works
      </h2>

      <div className="rounded-4xl bg-blue-50 px-4 py-7 shadow-lg shadow-gray-200 sm:px-8 sm:py-10 lg:px-16 lg:py-14">
        <div className="grid grid-cols-1 gap-5 md:grid-cols-3 lg:gap-12">
          {steps.map((step) => (
            <article
              className="rounded-4xl bg-white p-6 shadow-md shadow-gray-200 transition-transform duration-200 hover:scale-105 lg:p-8"
              key={step.number}
            >
              <div className="mb-8 inline-flex h-12 w-12 items-center justify-center rounded-4xl bg-blue-500 text-base font-extrabold text-white">
                {step.number}
              </div>

              <h3 className="font-outfit mb-5 text-xl font-bold text-gray-700">
                {step.title}
              </h3>

              <p className="m-0 text-sm font-medium leading-6 text-gray-500">
                {step.description}
              </p>
            </article>
          ))}
        </div>
      </div>
    </section>
  )
}

export default HowItWorksSection
