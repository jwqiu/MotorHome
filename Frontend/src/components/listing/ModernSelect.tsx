import { useEffect, useRef, useState } from 'react'

type ModernSelectOption = string | {
  label: string
  value: string
}

type ModernSelectProps = {
  options: ModernSelectOption[]
  ariaLabel: string
  className?: string
  disabled?: boolean
  onChange?: (value: string) => void
  placeholder?: string
  value: string
}

function ModernSelect({
  options,
  ariaLabel,
  className = '',
  disabled = false,
  onChange,
  placeholder,
  value,
}: ModernSelectProps) {
  const [isOpen, setIsOpen] = useState(false)
  const containerRef = useRef<HTMLDivElement>(null)
  const selectedOption = options.find((option) => getOptionValue(option) === value)
  const selectedLabel = selectedOption ? getOptionLabel(selectedOption) : placeholder || ''

  useEffect(() => {
    if (!isOpen) {
      return undefined
    }

    const handlePointerDown = (event: PointerEvent) => {
      if (!containerRef.current?.contains(event.target as Node)) {
        setIsOpen(false)
      }
    }

    const handleKeyDown = (event: KeyboardEvent) => {
      if (event.key === 'Escape') {
        setIsOpen(false)
      }
    }

    document.addEventListener('pointerdown', handlePointerDown)
    document.addEventListener('keydown', handleKeyDown)

    return () => {
      document.removeEventListener('pointerdown', handlePointerDown)
      document.removeEventListener('keydown', handleKeyDown)
    }
  }, [isOpen])

  const handleOptionClick = (option: ModernSelectOption) => {
    onChange?.(getOptionValue(option))
    setIsOpen(false)
  }

  return (
    <div className={`relative min-w-0 ${className}`} ref={containerRef}>
      <button
        aria-label={ariaLabel}
        aria-expanded={isOpen}
        aria-haspopup="listbox"
        disabled={disabled}
        className={`flex h-12 w-full cursor-pointer items-center justify-between gap-3 rounded-4xl border border-blue-100 bg-white px-5 text-left text-sm shadow-md shadow-blue-100/70 outline-0 transition-all duration-200 hover:border-blue-200 hover:shadow-lg hover:shadow-blue-100 focus:border-blue-500 focus:ring-4 focus:ring-blue-100 disabled:cursor-not-allowed disabled:bg-gray-50 disabled:text-gray-300 disabled:shadow-none ${
          value ? 'text-gray-600' : 'text-gray-400'
        }`}
        onClick={() => setIsOpen((current) => !current)}
        type="button"
      >
        <span className="min-w-0 truncate">{selectedLabel}</span>
        <span
          className={`h-2.5 w-2.5 shrink-0 rotate-45 border-r-2 border-b-2 transition-transform ${
            disabled ? 'border-gray-300' : 'border-blue-400'
          } ${isOpen ? 'translate-y-1 rotate-[225deg]' : '-translate-y-0.5'}`}
          aria-hidden="true"
        />
      </button>

      {isOpen ? (
        <div
          className="absolute top-[calc(100%+8px)] right-0 left-0 z-30 overflow-hidden rounded-3xl border border-blue-100 bg-white py-2 shadow-xl shadow-blue-100/80"
          role="listbox"
        >
          {options.map((option) => {
            const optionValue = getOptionValue(option)
            const optionLabel = getOptionLabel(option)
            const isSelected = optionValue === value

            return (
              <button
                aria-selected={isSelected}
                className={`flex min-h-11 w-full cursor-pointer items-center px-5 text-left text-sm font-extrabold transition-colors ${
                  isSelected
                    ? 'bg-blue-50 text-blue-600'
                    : 'bg-white text-gray-600 hover:bg-blue-50 hover:text-blue-500'
                }`}
                key={optionValue}
                onClick={() => handleOptionClick(option)}
                role="option"
                type="button"
              >
                <span className="min-w-0 truncate">{optionLabel}</span>
              </button>
            )
          })}
        </div>
      ) : null}
    </div>
  )
}

function getOptionLabel(option: ModernSelectOption) {
  return typeof option === 'string' ? option : option.label
}

function getOptionValue(option: ModernSelectOption) {
  return typeof option === 'string' ? option : option.value
}

export default ModernSelect
