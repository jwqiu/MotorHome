import heroBackground from '../../assets/FMA-Motorhome-Seniors_1040286186.jpg'

function HeroSearchSection() {
  return (
    <section
      className="relative mb-7 grid min-h-[620px] w-full place-items-center overflow-hidden"
      aria-labelledby="hero-search-title"
    >
      <img
        className="absolute inset-0 h-full w-full object-cover"
        src={heroBackground}
        alt=""
        aria-hidden="true"
      />
      <div className="absolute inset-0 bg-black/30" aria-hidden="true" />

      <div className="relative flex w-full max-w-[860px] -translate-y-[18px] flex-col items-center gap-9 px-6">
        <h1
          id="hero-search-title"
          className="font-outfit m-0 text-center text-2xl leading-[1.2] font-medium text-white"
        >
          Exchange what you need for your next adventure.
        </h1>

        <form
          className="flex px-2 min-h-[58px] w-full  items-center rounded-4xl bg-white py-2 "
          role="search"
        >
          <label className="flex flex-1 h-[38px] min-w-0 items-center  ">
            <input
              className="w-full min-w-0 pl-20 text-center border-0 bg-transparent text-md text-gray-600 outline-0 placeholder:text-gray-300"
              type="text"
              placeholder="Where are you going?"
            />
          </label>
          <button
            className="min-h-[42px] min-w-[98px] cursor-pointer rounded-4xl border-0 bg-blue-500 hover:bg-blue-600 text-base font-extrabold text-white"
            type="submit"
          >
            Search
          </button>

        </form>
      </div>
    </section>
  )
}

export default HeroSearchSection
