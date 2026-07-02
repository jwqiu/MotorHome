type ModernSelectProps = {
  options: string[]
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
  return (
    <div className={`relative min-w-0 ${className}`}>
      <select
        className="h-12 w-full appearance-none rounded-4xl border border-blue-100 bg-white px-5 pr-11 text-sm font-extrabold text-gray-600 shadow-md shadow-blue-100/70 outline-0 transition-all duration-200 hover:border-blue-200 hover:shadow-lg hover:shadow-blue-100 focus:border-blue-500 focus:ring-4 focus:ring-blue-100 disabled:cursor-not-allowed disabled:bg-gray-50 disabled:text-gray-300 disabled:shadow-none"
        aria-label={ariaLabel}
        disabled={disabled}
        onChange={(event) => onChange?.(event.target.value)}
        value={value}
      >
        {placeholder ? (
          <option value="" disabled>
            {placeholder}
          </option>
        ) : null}
        {options.map((option) => (
          <option key={option} value={option}>
            {option}
          </option>
        ))}
      </select>
      <span
        className={`pointer-events-none absolute top-1/2 right-4 h-2.5 w-2.5 -translate-y-1/2 rotate-45 border-r-2 border-b-2 ${
          disabled ? 'border-gray-300' : 'border-blue-400'
        }`}
        aria-hidden="true"
      />
    </div>
  )
}

export default ModernSelect
