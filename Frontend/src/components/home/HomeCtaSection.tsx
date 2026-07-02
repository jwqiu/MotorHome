function HomeCtaSection() {
  return (
    <section className="w-full px-16 pb-16" aria-labelledby="home-cta-title">
      <h2
        id="home-cta-title"
        className="font-outfit mb-8 text-center text-2xl font-bold text-gray-700"
      >
        Ready to start your next adventure?
      </h2>

        <div className="flex items-center justify-center gap-8">
          <a
            className="inline-flex min-h-[42px] min-w-[150px] items-center justify-center rounded-4xl border border-gray-300 bg-white px-8 text-sm font-extrabold text-gray-600 no-underline transition-transform duration-200 hover:scale-110 hover:text-blue-500"
            href="/listings"
          >
            Discover Listings
          </a>

          <a
            className="inline-flex min-h-[42px] min-w-[150px] items-center justify-center rounded-4xl bg-blue-500 px-8 text-sm font-extrabold text-white no-underline transition-transform duration-200 hover:scale-110 hover:bg-blue-600"
            href="/sign-up"
          >
            Sign Up
          </a>
        </div>
    </section>
  )
}

export default HomeCtaSection
