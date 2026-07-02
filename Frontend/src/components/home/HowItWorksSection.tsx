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
    <section className="w-full px-16 mb-16" aria-labelledby="how-it-works-title">
      <h2
        id="how-it-works-title"
        className="font-outfit mb-12 text-center text-2xl font-bold text-gray-700"
      >
        How it works
      </h2>

      <div className="rounded-4xl bg-blue-50 px-16 py-14 shadow-lg shadow-gray-200">
        <div className="grid grid-cols-3 gap-12">
          {steps.map((step) => (
            <article
              className="rounded-4xl bg-white p-8 shadow-md shadow-gray-200 transition-transform duration-200 hover:scale-105"
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
