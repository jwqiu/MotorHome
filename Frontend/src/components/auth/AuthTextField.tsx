type AuthTextFieldProps = {
  autoComplete?: string
  label: string
  name: string
  disabled?: boolean
  onChange: (value: string) => void
  placeholder: string
  type?: 'email' | 'password' | 'text'
  value: string
}

function AuthTextField({
  autoComplete,
  disabled = false,
  label,
  name,
  onChange,
  placeholder,
  type = 'text',
  value,
}: AuthTextFieldProps) {
  return (
    <label className="grid gap-2 text-sm font-extrabold text-gray-700">
      {label}
      <input
        autoComplete={autoComplete}
        className="h-13 rounded-4xl placeholder:text-gray-400 placeholder:font-normal border border-blue-100 bg-white px-5 text-sm font-bold text-gray-700 outline-0 transition focus:border-blue-500 focus:ring-4 focus:ring-blue-100 disabled:bg-gray-50 disabled:text-gray-300"
        disabled={disabled}
        name={name}
        onChange={(event) => onChange(event.target.value)}
        placeholder={placeholder}
        type={type}
        value={value}
      />
    </label>
  )
}

export default AuthTextField
