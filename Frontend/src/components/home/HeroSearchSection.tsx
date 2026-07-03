import { type FormEvent, useState } from 'react'
import heroBackground from '../../assets/FMA-Motorhome-Seniors_1040286186.jpg'
import ModernSelect from '../listing/ModernSelect'

const citiesByCountry: Record<string, string[]> = {
  'New Zealand': ['Auckland', 'Wellington', 'Christchurch', 'Queenstown', 'Hamilton'],
  Australia: ['Sydney', 'Melbourne', 'Brisbane', 'Perth', 'Adelaide'],
  Canada: ['Toronto', 'Vancouver', 'Montreal', 'Calgary', 'Ottawa'],
  'United States': ['New York', 'Los Angeles', 'Chicago', 'Houston', 'San Francisco'],
  'United Kingdom': ['London', 'Manchester', 'Birmingham', 'Edinburgh', 'Glasgow'],
}

function HeroSearchSection() {
  const [selectedCountry, setSelectedCountry] = useState('')
  const [selectedCity, setSelectedCity] = useState('')
  const countryOptions = Object.keys(citiesByCountry)
  const cityOptions = selectedCountry ? citiesByCountry[selectedCountry] : []

  const handleCountryChange = (country: string) => {
    setSelectedCountry(country)
    setSelectedCity('')
  }

  const handleSubmit = (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault()

    if (!selectedCountry || !selectedCity) {
      return
    }

    const params = new URLSearchParams({
      city: selectedCity,
      country: selectedCountry,
    })

    window.location.href = `/listings?${params.toString()}`
  }

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
          className="flex  w-full flex-col gap-3 rounded-4xl  sm:flex-row sm:items-center"
          onSubmit={handleSubmit}
          role="search"
        >
          <ModernSelect
            ariaLabel="Destination country"
            className={selectedCountry ? 'flex-1' : 'w-full'}
            onChange={handleCountryChange}
            options={countryOptions}
            placeholder="Select Country"
            value={selectedCountry}
          />

          {selectedCountry ? (
            <ModernSelect
              ariaLabel="Destination city"
              className="flex-1"
              onChange={setSelectedCity}
              options={cityOptions}
              placeholder="Select City"
              value={selectedCity}
            />
          ) : null}

          {selectedCity ? (
            <button
              className="font-outfit min-h-12 cursor-pointer rounded-4xl border-0 bg-blue-500 px-9 text-base font-extrabold text-white transition hover:bg-blue-600 sm:min-w-[128px]"
              type="submit"
            >
              Search
            </button>
          ) : null}

        </form>
      </div>
    </section>
  )
}

export default HeroSearchSection
