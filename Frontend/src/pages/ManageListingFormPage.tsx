import { type FormEvent, useEffect, useState } from 'react'
import { getSessionUserId, isAuthenticated } from '../components/auth/authSession'
import {
  createListing,
  getListingDetail,
  updateListing,
  type ListingDetail,
  type SaveListingPayload,
} from '../components/listing/listingApi'
import Navbar from '../components/layout/Navbar'

const categories = ['Vehicles', 'Accommodation', 'Canal Boats']
const listingTypesByCategory: Record<string, string[]> = {
  Vehicles: ['MotorHome/RV', 'Campervan', 'Caravan'],
  Accommodation: ['Home', 'Holiday Home'],
  'Canal Boats': ['Canal Boats'],
}
const countries = ['New Zealand', 'Australia', 'Canada', 'United States', 'United Kingdom']
const citiesByCountry: Record<string, string[]> = {
  'New Zealand': ['Auckland', 'Wellington', 'Christchurch', 'Queenstown', 'Hamilton'],
  Australia: ['Sydney', 'Melbourne', 'Brisbane', 'Perth', 'Adelaide'],
  Canada: ['Toronto', 'Vancouver', 'Montreal', 'Calgary', 'Ottawa'],
  'United States': ['New York', 'Los Angeles', 'Chicago', 'Houston', 'San Francisco'],
  'United Kingdom': ['London', 'Manchester', 'Birmingham', 'Edinburgh', 'Glasgow'],
}
const exchangeTimings = ['Simultaneous', 'Non-simultaneous']
const wantedAssetOptions = ['MotorHome/RV', 'Campervan', 'Caravan', 'Home', 'Holiday Home', 'Canal Boats']

const futureFields = [
  'Sleeping capacity',
  'Berths and bed layout',
  'Transmission and fuel type',
  'Vehicle length and driving requirements',
  'Kitchen equipment',
  'Bathroom and shower setup',
  'Power, water, and battery setup',
  'Insurance and roadside assistance',
  'Pickup and return instructions',
  'House rules, pets, and smoking policy',
]

type ListingFormState = {
  availableFrom: string
  availableTo: string
  category: string
  city: string
  country: string
  currentLocation: string
  description: string
  exchangeMethod: string
  exchangeTimings: string[]
  imageLabel: string
  listingType: string
  title: string
  wantedAssets: string[]
  wantedDestinations: string[]
}

const emptyForm: ListingFormState = {
  availableFrom: '',
  availableTo: '',
  category: 'Vehicles',
  city: '',
  country: '',
  currentLocation: '',
  description: '',
  exchangeMethod: 'Direct Exchange',
  exchangeTimings: ['Simultaneous'],
  imageLabel: '',
  listingType: 'MotorHome/RV',
  title: '',
  wantedAssets: [],
  wantedDestinations: [],
}

function getEditSlugFromPath() {
  const parts = window.location.pathname.split('/').filter(Boolean)
  return parts[2] ?? ''
}

function TextField({
  helperText,
  label,
  onChange,
  placeholder,
  required = false,
  type = 'text',
  value,
}: {
  helperText?: string
  label: string
  onChange: (value: string) => void
  placeholder?: string
  required?: boolean
  type?: string
  value: string
}) {
  return (
    <label className="block min-w-0">
      <span className="mb-2 block text-sm font-extrabold text-gray-700">{label}</span>
      <input
        className="h-12 w-full rounded-4xl border border-blue-100 bg-white px-5 text-sm placeholder:font-normal font-bold text-gray-700 outline-0 transition focus:border-blue-500 focus:ring-4 focus:ring-blue-100"
        onChange={(event) => onChange(event.target.value)}
        placeholder={placeholder}
        required={required}
        type={type}
        value={value}
      />
      {helperText ? (
        <span className="mt-2 block text-xs leading-5 font-medium text-gray-400">{helperText}</span>
      ) : null}
    </label>
  )
}

function SelectField({
  label,
  onChange,
  options,
  value,
}: {
  label: string
  onChange: (value: string) => void
  options: string[]
  value: string
}) {
  return (
    <label className="block min-w-0">
      <span className="mb-2 block text-sm font-extrabold text-gray-700">{label}</span>
      <select
        className="h-12 w-full cursor-pointer rounded-4xl border border-blue-100 bg-white px-5 text-sm font-bold text-gray-700 outline-0 transition focus:border-blue-500 focus:ring-4 focus:ring-blue-100"
        onChange={(event) => onChange(event.target.value)}
        value={value}
      >
        <option value="">Select</option>
        {options.map((option) => (
          <option key={option} value={option}>
            {option}
          </option>
        ))}
      </select>
    </label>
  )
}

function FutureFieldsPreview() {
  return (
    <section className="relative overflow-hidden rounded-4xl bg-white p-7 shadow-lg shadow-blue-100 md:p-8">
      <div className="mb-6">
        <p className="mb-3 text-xs font-extrabold tracking-[0.16em] text-blue-500 uppercase">Future detail fields</p>
        <h2 className="font-outfit m-0 text-2xl font-extrabold text-gray-800">Detailed listing content</h2>
      </div>
      <div className="grid gap-5 md:grid-cols-2">
        {futureFields.map((field) => (
          <label className="block" key={field}>
            <span className="mb-2 block text-sm font-extrabold text-gray-700">{field}</span>
            <input
              className="h-12 w-full rounded-4xl border border-blue-100 bg-white px-5 text-sm font-bold text-gray-500"
              disabled
              placeholder="To be configured"
              type="text"
            />
          </label>
        ))}
      </div>
      <div className="absolute inset-0 z-10 flex items-center justify-center rounded-4xl bg-white/60 px-6 text-center backdrop-blur-[3px]">
        <p className="m-0 max-w-[560px] rounded-3xl px-5 py-4 text-sm leading-6 font-semibold text-gray-700">
          Required detailed fields for different listing categories are still being defined. These inputs are placeholders only.
        </p>
      </div>
    </section>
  )
}

function CheckboxGrid({
  label,
  onChange,
  options,
  values,
}: {
  label: string
  onChange: (values: string[]) => void
  options: string[]
  values: string[]
}) {
  const toggleValue = (value: string) => {
    onChange(values.includes(value)
      ? values.filter((currentValue) => currentValue !== value)
      : [...values, value])
  }

  return (
    <fieldset className="border-0 p-0">
      <legend className="mb-3 text-sm font-extrabold text-gray-700">{label}</legend>
      <div className="grid gap-3 sm:grid-cols-2 lg:grid-cols-3">
        {options.map((option) => (
          <label
            className={`flex min-h-11 cursor-pointer items-center gap-3 rounded-3xl border px-4 py-3 text-sm font-bold transition ${
              values.includes(option)
                ? 'border-blue-200 bg-blue-50 text-blue-600'
                : 'border-blue-100 bg-white text-gray-600 hover:border-blue-200 hover:bg-blue-50'
            }`}
            key={option}
          >
            <input
              checked={values.includes(option)}
              className="h-4 w-4 accent-blue-500"
              onChange={() => toggleValue(option)}
              type="checkbox"
            />
            <span>{option}</span>
          </label>
        ))}
      </div>
    </fieldset>
  )
}

function ManageListingFormPage() {
  const isEditMode = window.location.pathname.endsWith('/edit')
  const editSlug = getEditSlugFromPath()
  const userId = getSessionUserId()
  const [form, setForm] = useState<ListingFormState>(emptyForm)
  const [loadedListing, setLoadedListing] = useState<ListingDetail | null>(null)
  const [pageMessage, setPageMessage] = useState('')
  const [isSubmitting, setIsSubmitting] = useState(false)

  useEffect(() => {
    let isActive = true

    if (!isAuthenticated()) {
      window.location.href = `/sign-in?returnTo=${encodeURIComponent(window.location.pathname)}`
      return () => {
        isActive = false
      }
    }

    if (!isEditMode || !editSlug) {
      return () => {
        isActive = false
      }
    }

    getListingDetail(editSlug)
      .then((detail) => {
        if (!isActive) {
          return
        }

        setLoadedListing(detail)
        setForm({
          availableFrom: detail.listing.availableFrom,
          availableTo: detail.listing.availableTo,
          category: detail.listing.category,
          city: detail.listing.city,
          country: detail.listing.country,
          currentLocation: detail.listing.currentLocation,
          description: detail.listing.description,
          exchangeMethod: detail.listing.exchangeMethod,
          exchangeTimings: detail.listing.exchangeTimings,
          imageLabel: detail.listing.imageLabel,
          listingType: detail.listing.listingType,
          title: detail.listing.title,
          wantedAssets: detail.listing.wantedAssets,
          wantedDestinations: detail.listing.wantedDestinations,
        })
      })
      .catch((error) => {
        if (isActive) {
          setPageMessage(error instanceof Error ? error.message : 'Unable to load listing.')
        }
      })

    return () => {
      isActive = false
    }
  }, [editSlug, isEditMode])

  const setField = (key: keyof ListingFormState, value: string | string[]) => {
    setForm((currentForm) => ({
      ...currentForm,
      [key]: value,
    }))
  }

  const handleCountryChange = (country: string) => {
    setForm((currentForm) => ({
      ...currentForm,
      city: '',
      country,
      currentLocation: country,
    }))
  }

  const handleCityChange = (city: string) => {
    setForm((currentForm) => ({
      ...currentForm,
      city,
      currentLocation: city && currentForm.country ? `${city}, ${currentForm.country}` : currentForm.currentLocation,
    }))
  }

  const handleCategoryChange = (category: string) => {
    setForm((currentForm) => ({
      ...currentForm,
      category,
      listingType: listingTypesByCategory[category]?.[0] ?? '',
    }))
  }

  const toggleExchangeTiming = (timing: string) => {
    setForm((currentForm) => {
      const nextTimings = currentForm.exchangeTimings.includes(timing)
        ? currentForm.exchangeTimings.filter((currentTiming) => currentTiming !== timing)
        : [...currentForm.exchangeTimings, timing]

      return {
        ...currentForm,
        exchangeTimings: nextTimings.length > 0 ? nextTimings : currentForm.exchangeTimings,
      }
    })
  }

  const handleSubmit = (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault()

    if (!userId) {
      setPageMessage('Please sign in before saving a listing.')
      return
    }

    const payload: SaveListingPayload = {
      availableFrom: form.availableFrom || undefined,
      availableTo: form.availableTo || undefined,
      category: form.category,
      city: form.city,
      country: form.country,
      currentLocation,
      description: form.description,
      exchangeMethod: form.exchangeMethod,
      exchangeTimings: form.exchangeTimings,
      imageLabel: form.title,
      listingType: form.listingType,
      ownerId: userId,
      title: form.title,
      wantedAssets: form.wantedAssets,
      wantedDestinations: form.wantedDestinations,
    }

    setIsSubmitting(true)
    setPageMessage('')

    const saveRequest = isEditMode && loadedListing
      ? updateListing(loadedListing.listing.listingId, payload)
      : createListing(payload)

    saveRequest
      .then((detail) => {
        window.location.href = `/listings/${detail.listing.id}`
      })
      .catch((error) => {
        setPageMessage(error instanceof Error ? error.message : 'Unable to save listing.')
      })
      .finally(() => setIsSubmitting(false))
  }

  const cityOptions = form.country ? citiesByCountry[form.country] : []
  const listingTypeOptions = form.category ? listingTypesByCategory[form.category] : []
  const currentLocation = form.city && form.country ? `${form.city}, ${form.country}` : form.country

  return (
    <main className="min-h-screen bg-blue-50 font-sans text-gray-600 antialiased">
      <Navbar variant="solid" />

      <section className="px-6 pt-40 pb-16 md:px-16 md:pt-44">
        <form className="mx-auto grid max-w-[1120px] gap-8" onSubmit={handleSubmit}>
          <div>
            <p className="mb-3 text-sm font-extrabold tracking-[0.18em] text-blue-500 uppercase">
              Manage Listing
            </p>
            <h1 className="font-outfit m-0 text-4xl leading-tight font-extrabold text-gray-800 md:text-5xl">
              {isEditMode ? 'Edit listing' : 'Add new listing'}
            </h1>
          </div>

          {pageMessage ? (
            <p className="m-0 rounded-3xl bg-red-50 px-5 py-4 text-sm font-bold text-red-500">
              {pageMessage}
            </p>
          ) : null}

          <section className="rounded-4xl bg-white shadow-lg shadow-blue-100 p-12">
            <div className="mb-6">
              <h2 className="font-outfit m-0 text-2xl font-extrabold text-gray-800">
                Tell us what you offer
              </h2>
              <p className="mt-2 mb-0 text-sm text-gray-400">
                Provide the details of what you'd like to offer to other members.
              </p>
            </div>

            <div className="grid gap-5 md:grid-cols-3">
              <SelectField label="Category" onChange={handleCategoryChange} options={categories} value={form.category} />
              <SelectField label="Listing type" onChange={(value) => setField('listingType', value)} options={listingTypeOptions} value={form.listingType} />
            </div>
            <div className="mt-5 grid gap-5 md:grid-cols-3">
              <SelectField label="Country" onChange={handleCountryChange} options={countries} value={form.country} />
              <SelectField label="City" onChange={handleCityChange} options={cityOptions} value={form.city} />

            </div>

            <div className="mt-5 grid gap-5 md:grid-cols-3">
              <TextField label="Available from" onChange={(value) => setField('availableFrom', value)} type="date" value={form.availableFrom} />
              <TextField label="Available until" onChange={(value) => setField('availableTo', value)} type="date" value={form.availableTo} />
            </div>

            <label className="mt-5 block w-2/3">
              <TextField
                label="Listing title"
                onChange={(value) => setField('title', value)}
                placeholder="Give your listing a short, descriptive title"
                
                required
                value={form.title}
              />
              <span className="mb-2 mt-5 block text-sm font-extrabold text-gray-700">Description</span>
              <textarea
                className="min-h-32 w-full resize-y rounded-4xl border placeholder:font-normal border-blue-100 bg-white px-5 py-4 text-sm font-bold text-gray-700 outline-0 transition focus:border-blue-500 focus:ring-4 focus:ring-blue-100"
                onChange={(event) => setField('description', event.target.value)}
                placeholder="Describe what you're offering, its condition, key features, and anything members should know.."
                required
                value={form.description}
              />
            </label>

            <div className="mt-5 flex justify-between w-2/3 ">
              <div className="items-center">
                <p className="font-outfit m-0 text-sm font-extrabold text-gray-700">Add Images</p>
                <p className="mt-2 mb-0 whitespace-nowrap text-sm font-medium text-gray-400">Image upload will be supported soon.</p>

              </div>
              <div className="flex flex-col justify-end items-end">
                <button
                  className="h-11 cursor-not-allowed rounded-4xl border border-gray-100 bg-gray-50 px-6 text-sm font-extrabold text-gray-300"
                  disabled
                  type="button"
                >
                  Add image
                </button>

              </div>
            </div>
          </section>

          <section className="rounded-4xl bg-white shadow-lg shadow-blue-100 p-12">
          

            <section>
              <div className="mb-5">
                <h3 className="font-outfit m-0 text-xl font-extrabold text-gray-800">Exchange preferences</h3>
                <p className="mt-2 mb-0 text-sm font-medium text-gray-400">
                  Choose how you are open to exchanging, and what you are looking for in return.
                </p>
              </div>
              <fieldset className="border-0 p-0">
                <legend className="mb-3 text-sm font-extrabold text-gray-700">How would you like to exchange?</legend>
                <div className="grid gap-3 grid-cols-3">
                  <button
                    aria-pressed={form.exchangeMethod === 'Direct Exchange'}
                    className="h-11 cursor-pointer rounded-4xl border border-blue-200 bg-blue-50 px-5 text-sm font-extrabold text-blue-600"
                    onClick={() => setField('exchangeMethod', 'Direct Exchange')}
                    type="button"
                  >
                    Direct Exchange
                  </button>
                  <button
                    aria-disabled="true"
                    className="h-11 cursor-not-allowed rounded-4xl border border-gray-100 bg-gray-50 px-5 text-sm font-extrabold text-gray-300"
                    disabled
                    type="button"
                  >
                    Points exchange
                  </button>
                </div>
                <p className="mt-2 mb-0 text-xs font-medium text-gray-400">Point exchange will be supported soon.</p>
              </fieldset>

              <fieldset className="mt-5 border-0 p-0">
                <legend className="mb-3 text-sm font-extrabold text-gray-700">Timing preference</legend>
                <div className="grid gap-3 grid-cols-3">
                  {exchangeTimings.map((timing) => (
                    <button
                      aria-pressed={form.exchangeTimings.includes(timing)}
                      className={`h-11 cursor-pointer rounded-4xl border px-5 text-sm font-extrabold transition ${
                        form.exchangeTimings.includes(timing)
                          ? 'border-blue-200 bg-blue-50 text-blue-600'
                          : 'border-blue-100 bg-white text-gray-500'
                      }`}
                      key={timing}
                      onClick={() => toggleExchangeTiming(timing)}
                      type="button"
                    >
                      {timing}
                    </button>
                  ))}
                </div>
              </fieldset>
            </section>

            <div className=" grid gap-7  pt-7">
              <CheckboxGrid
                label="Preferred exchange countries"
                onChange={(values) => setField('wantedDestinations', values)}
                options={countries}
                values={form.wantedDestinations}
              />
              <CheckboxGrid
                label="What are you looking for?"
                onChange={(values) => setField('wantedAssets', values)}
                options={wantedAssetOptions}
                values={form.wantedAssets}
              />
            </div>
          </section>

          <FutureFieldsPreview />

          <div className="flex flex-wrap justify-center gap-3">
            <a
              className="inline-flex h-12 items-center rounded-4xl border border-blue-100 bg-white px-7 text-sm font-extrabold text-gray-500 no-underline shadow-md shadow-blue-100"
              href="/user-center"
            >
              Cancel
            </a>
            <button
              className="font-outfit h-12 cursor-pointer rounded-4xl border-0 bg-blue-500 px-8 text-sm font-extrabold text-white shadow-lg shadow-blue-200 transition hover:bg-blue-600 disabled:cursor-not-allowed disabled:bg-gray-300 disabled:shadow-none"
              disabled={isSubmitting}
              type="submit"
            >
              {isSubmitting ? 'Saving...' : 'Submit'}
            </button>
          </div>
        </form>
      </section>
    </main>
  )
}

export default ManageListingFormPage
