import type { ChangeEvent } from 'react'
import { useEffect, useRef, useState } from 'react'

type ModernDateInputProps = {
  ariaLabel: string
  onChange: (value: string) => void
  value: string
}

function formatDate(value: string) {
  const [year, month, day] = value.split('-')

  if (!year || !month || !day) {
    return ''
  }

  return `${day} / ${month} / ${year}`
}

function ModernDateInput({ ariaLabel, onChange, value }: ModernDateInputProps) {
  const [inputVersion, setInputVersion] = useState(0)
  const closeTimerRef = useRef<number | null>(null)

  useEffect(() => (
    () => {
      if (closeTimerRef.current) {
        window.clearTimeout(closeTimerRef.current)
      }
    }
  ), [])

  const handleDateChange = (event: ChangeEvent<HTMLInputElement>) => {
    const dateInput = event.currentTarget

    onChange(event.target.value)

    if (closeTimerRef.current) {
      window.clearTimeout(closeTimerRef.current)
    }

    closeTimerRef.current = window.setTimeout(() => {
      dateInput.blur()
      setInputVersion((currentVersion) => currentVersion + 1)
      closeTimerRef.current = null
    }, 500)
  }

  return (
    <div className="relative flex h-12 w-full min-w-0 items-center justify-center rounded-4xl border border-blue-100 bg-white px-4 text-center text-sm text-gray-600 shadow-md shadow-blue-100/70 transition-all duration-200 hover:border-blue-200 hover:shadow-lg hover:shadow-blue-100 focus-within:border-blue-500 focus-within:ring-4 focus-within:ring-blue-100">
      <span className="pointer-events-none font-medium">{formatDate(value)}</span>
      <input
        aria-label={ariaLabel}
        className="absolute inset-0 h-full w-full cursor-pointer opacity-0"
        key={inputVersion}
        onChange={handleDateChange}
        type="date"
        value={value}
      />
    </div>
  )
}

export default ModernDateInput
