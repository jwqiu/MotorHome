import { useState } from 'react'
import ModernDateInput from './ModernDateInput'
import ModernSelect from './ModernSelect'
import type { ListingFiltersValue } from './listingData'

const exchangeTypes = ['Simultaneous', 'Non-simultaneous']
const exchangeMethods = ['Direct Exchange', 'Use Points']

const citiesByCountry: Record<string, string[]> = {
  'New Zealand': ['Auckland', 'Wellington', 'Christchurch', 'Queenstown', 'Hamilton'],
  Australia: ['Sydney', 'Melbourne', 'Brisbane', 'Perth', 'Adelaide'],
  Canada: ['Toronto', 'Vancouver', 'Montreal', 'Calgary', 'Ottawa'],
  'United States': ['New York', 'Los Angeles', 'Chicago', 'Houston', 'San Francisco'],
  'United Kingdom': ['London', 'Manchester', 'Birmingham', 'Edinburgh', 'Glasgow'],
}

const listingTypesByCategory: Record<string, string[]> = {
  Vehicles: ['MotorHome/RV', 'Campervan', 'Caravan'],
  Accommodation: ['Home', 'Holiday Home'],
  'Canal Boats': ['Canal Boats'],
}

type ListingFiltersProps = {
  initialFilters: ListingFiltersValue
  onApplyFilters: (filters: ListingFiltersValue) => void
}

function ListingFilters({ initialFilters, onApplyFilters }: ListingFiltersProps) {
  const initialExchangeTimings =
    initialFilters.exchangeMethod === 'Direct Exchange' && initialFilters.exchangeTimings.length === 0
      ? [exchangeTypes[0]]
      : initialFilters.exchangeTimings
  const [selectedCountry, setSelectedCountry] = useState(initialFilters.country)
  const [selectedCity, setSelectedCity] = useState(initialFilters.city)
  const [selectedCategory, setSelectedCategory] = useState(initialFilters.category)
  const [selectedListingType, setSelectedListingType] = useState(initialFilters.listingType)
  const [selectedExchangeTimings, setSelectedExchangeTimings] = useState<string[]>(initialExchangeTimings)
  const [selectedExchangeMethod, setSelectedExchangeMethod] = useState(initialFilters.exchangeMethod)
  const [showPointExchangeHint, setShowPointExchangeHint] = useState(false)
  const [showExchangeTimingHint, setShowExchangeTimingHint] = useState(false)
  const [showMoreFiltersHint, setShowMoreFiltersHint] = useState(false)
  const [availableFrom, setAvailableFrom] = useState(initialFilters.availableFrom)
  const [availableTo, setAvailableTo] = useState(initialFilters.availableTo)

  const countryOptions = Object.keys(citiesByCountry)
  const cityOptions = selectedCountry ? citiesByCountry[selectedCountry] : []
  const categoryOptions = Object.keys(listingTypesByCategory)
  const listingTypeOptions = selectedCategory ? listingTypesByCategory[selectedCategory] : []

  const handleCountryChange = (country: string) => {
    setSelectedCountry(country)
    setSelectedCity('')
  }

  const handleCategoryChange = (category: string) => {
    setSelectedCategory(category)
    setSelectedListingType(listingTypesByCategory[category].length === 1 ? listingTypesByCategory[category][0] : '')
  }

  const toggleExchangeTiming = (timing: string) => {
    if (
      selectedExchangeMethod === 'Direct Exchange' &&
      selectedExchangeTimings.includes(timing) &&
      selectedExchangeTimings.length === 1
    ) {
      setShowExchangeTimingHint(true)
      window.setTimeout(() => setShowExchangeTimingHint(false), 2600)
      return
    }

    setShowExchangeTimingHint(false)
    setSelectedExchangeTimings((currentTimings) => (
      currentTimings.includes(timing)
        ? currentTimings.filter((currentTiming) => currentTiming !== timing)
        : [...currentTimings, timing]
    ))
  }

  const handleExchangeMethodClick = (method: string) => {
    if (method === 'Use Points') {
      setShowPointExchangeHint(true)
      window.setTimeout(() => setShowPointExchangeHint(false), 2600)
      return
    }

    setShowPointExchangeHint(false)
    if (method === selectedExchangeMethod) {
      return
    }

    setSelectedExchangeMethod(method)
    setSelectedExchangeTimings((currentTimings) => (currentTimings.length > 0 ? currentTimings : [exchangeTypes[0]]))
  }

  const handleMoreFiltersClick = () => {
    setShowMoreFiltersHint(true)
    window.setTimeout(() => setShowMoreFiltersHint(false), 2600)
  }

  const applyFilters = () => {
    onApplyFilters({
      availableFrom,
      availableTo,
      category: selectedCategory,
      city: selectedCity,
      country: selectedCountry,
      exchangeMethod: selectedExchangeMethod,
      exchangeTimings: selectedExchangeTimings,
      listingType: selectedListingType,
    })
  }

  return (
    <aside className="w-full" aria-labelledby="listing-filters-title">
      <div className="mb-6 flex min-h-12 items-end">
        <h2 id="listing-filters-title" className="font-outfit m-0 text-2xl font-extrabold text-gray-800">
          Filters
        </h2>
      </div>
      <form
        className="rounded-4xl bg-white p-7 shadow-lg shadow-blue-100 md:p-8"
        onSubmit={(event) => {
          event.preventDefault()
          applyFilters()
        }}
      >
        <div className="grid gap-8 md:grid-cols-2 xl:grid-cols-1">
          <fieldset className="border-0 p-0">
            <legend className="mb-3 text-sm font-extrabold text-gray-700">
              Where do you want to go?
            </legend>
            <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 md:grid-cols-1 xl:grid-cols-2">
              <ModernSelect
                ariaLabel="Destination country"
                onChange={handleCountryChange}
                options={countryOptions}
                placeholder="Select Country"
                value={selectedCountry}
              />
              {selectedCountry ? (
                <ModernSelect
                  ariaLabel="Destination city"
                  onChange={setSelectedCity}
                  options={cityOptions}
                  placeholder="Select City"
                  value={selectedCity}
                />
              ) : null}
            </div>
          </fieldset>

          <fieldset className="border-0 p-0">
            <legend className="mb-3 text-sm font-extrabold text-gray-700">
              What are you looking for?
            </legend>
            <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 md:grid-cols-1 xl:grid-cols-2">
              <ModernSelect
                ariaLabel="Listing category"
                onChange={handleCategoryChange}
                options={categoryOptions}
                placeholder="Select Category"
                value={selectedCategory}
              />
              {selectedCategory ? (
                <ModernSelect
                  ariaLabel="Listing type"
                  onChange={setSelectedListingType}
                  options={listingTypeOptions}
                  value={selectedListingType}
                />
              ) : null}
            </div>
          </fieldset>
        </div>

        <div className="mt-8 grid gap-8 md:grid-cols-2 xl:grid-cols-1">
          <fieldset className="border-0 p-0">
            <legend className="mb-4 text-sm font-extrabold text-gray-700">Exchange Method</legend>
            <div className="grid grid-cols-1 gap-4 sm:grid-cols-2">
              {exchangeMethods.map((method) => {
                const isPointExchange = method === 'Use Points'
                const isSelected = selectedExchangeMethod === method

                return (
                  <div className="relative" key={method}>
                    <button
                      aria-describedby={isPointExchange && showPointExchangeHint ? 'point-exchange-hint' : undefined}
                      aria-disabled={isPointExchange}
                      aria-pressed={isSelected}
                      className={`inline-flex h-12 w-full items-center justify-center rounded-4xl border px-5 text-sm transition-colors ${
                        isPointExchange
                          ? 'cursor-not-allowed border-gray-100 bg-gray-50 text-gray-300'
                          : isSelected
                            ? 'cursor-pointer border-blue-200 bg-blue-50 font-extrabold text-blue-600'
                            : 'cursor-pointer border-blue-100 bg-white text-gray-600 shadow-md shadow-blue-100/70 hover:border-blue-200 hover:bg-blue-50 hover:text-blue-500'
                      }`}
                      onClick={() => handleExchangeMethodClick(method)}
                      type="button"
                    >
                      <span>{method}</span>
                    </button>

                    {isPointExchange && showPointExchangeHint ? (
                      <div
                        className="absolute right-0 bottom-[calc(100%+10px)] z-10 w-[230px] rounded-2xl bg-gray-800 px-4 py-3 text-xs leading-5 font-bold text-white shadow-lg shadow-gray-900/20"
                        id="point-exchange-hint"
                        role="status"
                      >
                        The point exchange system is coming soon.
                      </div>
                    ) : null}
                  </div>
                )
              })}
            </div>
          </fieldset>

          <fieldset className="relative border-0 p-0">
            <legend className="mb-4 text-sm font-extrabold text-gray-700">Exchange Timing</legend>
            <div className="grid grid-cols-1 gap-4 sm:grid-cols-2">
              {exchangeTypes.map((type) => (
                <button
                  aria-describedby={showExchangeTimingHint ? 'exchange-timing-hint' : undefined}
                  aria-pressed={selectedExchangeTimings.includes(type)}
                  className={`inline-flex h-12 w-full cursor-pointer items-center justify-center rounded-4xl border px-5 text-sm  transition-colors ${
                    selectedExchangeTimings.includes(type)
                      ? 'border-blue-200 bg-blue-50 text-blue-600 font-extrabold'
                      : 'border-blue-100 bg-white text-gray-600 shadow-md shadow-blue-100/70 hover:border-blue-200 hover:bg-blue-50 hover:text-blue-500'
                  }`}
                  key={type}
                  onClick={() => toggleExchangeTiming(type)}
                  type="button"
                >
                  <span>{type}</span>
                </button>
              ))}
            </div>
            {showExchangeTimingHint ? (
              <div
                className="absolute right-0 bottom-[calc(100%+10px)] z-10 w-[230px] rounded-2xl bg-gray-800 px-4 py-3 text-xs leading-5 font-bold text-white shadow-lg shadow-gray-900/20"
                id="exchange-timing-hint"
                role="status"
              >
                Please select at least one exchange timing.
              </div>
            ) : null}
          </fieldset>
        </div>

        <div className="mt-8 grid gap-8 md:grid-cols-2 xl:grid-cols-1">
          <fieldset className="border-0 p-0">
            <legend className="mb-3 text-sm font-extrabold text-gray-700">Available Dates</legend>
            <div className="grid grid-cols-1 gap-4 sm:grid-cols-2">
              <label className="block min-w-0">
                <span className="mb-2 block text-[11px] tracking-[0.12em] text-gray-400 uppercase">
                  From
                </span>
                <ModernDateInput
                  ariaLabel="Available from"
                  onChange={setAvailableFrom}
                  value={availableFrom}
                />
              </label>
              <label className="block min-w-0">
                <span className="mb-2 block text-[11px]  tracking-[0.12em] text-gray-400 uppercase">
                  To
                </span>
                <ModernDateInput
                  ariaLabel="Available to"
                  onChange={setAvailableTo}
                  value={availableTo}
                />
              </label>
            </div>
          </fieldset>

          <div className="relative self-end">
            <button
              aria-describedby={showMoreFiltersHint ? 'more-filters-hint' : undefined}
              aria-disabled="true"
              className="flex h-14 w-full cursor-not-allowed items-center justify-center gap-3 rounded-4xl border-0 bg-gray-50 text-sm font-extrabold text-gray-300 transition-colors"
              onClick={handleMoreFiltersClick}
              type="button"
            >
              <span>More filters</span>
              <span className="h-2 w-2 rotate-45 border-r-2 border-b-2 border-current" aria-hidden="true" />
            </button>

            {showMoreFiltersHint ? (
              <div
                className="absolute right-0 bottom-[calc(100%+10px)] z-10 w-[220px] rounded-2xl bg-gray-800 px-4 py-3 text-xs leading-5 font-bold text-white shadow-lg shadow-gray-900/20"
                id="more-filters-hint"
                role="status"
              >
                More filters are coming soon.
              </div>
            ) : null}
          </div>
        </div>

        <button
          className="font-outfit mt-8 h-14 w-full cursor-pointer rounded-4xl border-0 bg-blue-500 text-xl font-extrabold text-white shadow-lg shadow-blue-200 transition-transform duration-200 hover:scale-[1.02] hover:bg-blue-600"
          type="submit"
        >
          Search
        </button>
      </form>
    </aside>
  )
}

export default ListingFilters
