import { type FormEvent, useState } from 'react'
import heroBackground from '../../assets/FMA-Motorhome-Seniors_1040286186.jpg'
import ModernSelect from '../listing/ModernSelect'

const categoryOptions = ['Vehicles', 'Accommodation', 'Canal Boats']
const listingTypesByCategory: Record<string, string[]> = {
  Vehicles: ['MotorHome/RV', 'Campervan', 'Caravan'],
  Accommodation: ['Home', 'Holiday Home'],
  'Canal Boats': ['Canal Boats'],
}

function HeroSearchSection() {
  const [selectedCategory, setSelectedCategory] = useState('')
  const [selectedListingType, setSelectedListingType] = useState('')
  const listingTypeOptions = selectedCategory ? listingTypesByCategory[selectedCategory] : []

  const handleCategoryChange = (category: string) => {
    setSelectedCategory(category)
    setSelectedListingType(listingTypesByCategory[category].length === 1 ? listingTypesByCategory[category][0] : '')
  }

  const handleSubmit = (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault()

    if (!selectedCategory || !selectedListingType) {
      return
    }

    const params = new URLSearchParams({
      category: selectedCategory,
      listingType: selectedListingType,
    })

    window.location.href = `/listings?${params.toString()}`
  }

  return (
    <section
      className="relative mb-0 sm:mb-6 grid min-h-[540px] w-full place-items-center overflow-hidden sm:min-h-[620px]"
      aria-labelledby="hero-search-title"
    >
      <img
        className="absolute inset-0 h-full w-full object-cover"
        src={heroBackground}
        alt=""
        aria-hidden="true"
      />
      <div className="absolute inset-0 bg-black/30" aria-hidden="true" />

      <div className="relative flex w-full max-w-[860px] flex-col items-center gap-7 px-4 sm:-translate-y-[18px] sm:gap-9 sm:px-6">
        <h1
          id="hero-search-title"
          className="font-outfit m-0 text-center text-lg sm:text-2xl leading-[1.2] font-medium text-white"
        >
          Exchange what you have for your next adventure
        </h1>

        <form
          className="flex w-1/2 sm:w-full flex-col gap-3 rounded-4xl  sm:flex-row sm:items-center"
          onSubmit={handleSubmit}
          role="search"
        >
          <ModernSelect
            ariaLabel="Listing category"
            className={selectedCategory ? 'flex-1' : 'w-full'}
            onChange={handleCategoryChange}
            options={categoryOptions}
            placeholder="What are you looking for?"
            value={selectedCategory}
          />

          {selectedCategory ? (
            <ModernSelect
              ariaLabel="Listing type"
              className="flex-1"
              onChange={setSelectedListingType}
              options={listingTypeOptions}
              placeholder="Select a type"
              value={selectedListingType}
            />
          ) : null}

          {selectedListingType ? (
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
