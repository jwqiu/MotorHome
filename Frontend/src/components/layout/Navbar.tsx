import { useEffect, useState } from 'react'

function Navbar() {
  const [isScrolled, setIsScrolled] = useState(false)

  useEffect(() => {
    const handleScroll = () => {
      setIsScrolled(window.scrollY > 0)
    }

    handleScroll()
    window.addEventListener('scroll', handleScroll)

    return () => {
      window.removeEventListener('scroll', handleScroll)
    }
  }, [])

  return (
    <header
      className={`fixed top-0 left-0 z-20 flex h-28 w-full items-center justify-between px-20 transition-colors duration-300 ${
        isScrolled ? 'bg-white/20 shadow-lg shadow-gray-900/10 backdrop-blur-md' : 'bg-transparent'
      }`}
    >
      <a
        className={`font-outfit text-[26px] font-bold whitespace-nowrap no-underline transition-colors duration-300 ${
          isScrolled ? 'text-gray-700' : 'text-white'
        }`}
        href="/"
        aria-label="MT Exchange home"
      >
        MT Exchange
      </a>

      <nav
        className="flex items-center gap-[54px]"
        aria-label="Primary navigation"
      >
        <a
          className={`text-[17px] font-semibold whitespace-nowrap transition-all duration-200 hover:scale-110 ${
            isScrolled ? 'text-gray-700' : 'text-white'
          }`}
          href="/"
        >
          Home
        </a>
        <a
          className={`text-[17px] font-semibold whitespace-nowrap no-underline transition-all duration-200 hover:scale-110 ${
            isScrolled ? 'text-gray-700' : 'text-gray-200'
          }`}
          href="/listings"
        >
          Listings
        </a>
        <a
          className={`text-[17px] font-semibold whitespace-nowrap no-underline transition-all duration-200 hover:scale-110 ${
            isScrolled ? 'text-gray-700' : 'text-gray-200'
          }`}
          href="/sign-in"
        >
          Sign in
        </a>
        <a
          className="inline-flex min-h-[42px] min-w-[150px] items-center justify-center rounded-4xl bg-blue-500 px-8 text-sm font-extrabold text-white no-underline transition-transform duration-200 hover:scale-110 hover:bg-blue-600"
          href="/sign-up"
        >
          Sign Up
        </a>
      </nav>
    </header>
  )
}

export default Navbar
