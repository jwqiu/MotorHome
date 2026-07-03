import { useEffect, useState } from 'react'
import { isAuthenticated, signOutSession } from '../auth/authSession'

type NavbarProps = {
  activePage?: 'home' | 'listings'
  variant?: 'overlay' | 'solid'
}

function Navbar({ activePage, variant = 'overlay' }: NavbarProps) {
  const [isScrolled, setIsScrolled] = useState(false)
  const [isSignedIn, setIsSignedIn] = useState(() => isAuthenticated())
  const isSolid = variant === 'solid' || isScrolled

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

  const handleSignOut = () => {
    signOutSession()
    setIsSignedIn(false)
    window.location.href = '/'
  }

  return (
    <header
      className={`fixed top-0 left-0 z-20 flex h-24 w-full items-center justify-between px-6 transition-colors duration-300 md:h-28 md:px-20 ${
        isSolid ? 'bg-white/40 shadow-lg shadow-gray-900/10 backdrop-blur-md' : 'bg-transparent'
      }`}
    >
      <a
        className={`font-outfit text-xl font-bold whitespace-nowrap no-underline transition-colors duration-300 md:text-[26px] ${
          isSolid ? 'text-gray-700' : 'text-white'
        }`}
        href="/"
        aria-label="MT Exchange home"
      >
        MT Exchange
      </a>

      <nav
        className="flex items-center gap-5 md:gap-[54px]"
        aria-label="Primary navigation"
      >
        <a
          className={`text-sm  whitespace-nowrap transition-all duration-200 hover:scale-110 md:text-[17px] ${
            isSolid ? 'text-gray-700' : 'text-white'
          } ${activePage === 'home' ? 'underline decoration-2 underline-offset-4 font-bold' : 'no-underline'}`}
          aria-current={activePage === 'home' ? 'page' : undefined}
          href="/"
        >
          Home
        </a>
        <a
          className={`text-sm  whitespace-nowrap transition-all duration-200 hover:scale-110 md:text-[17px] ${
            isSolid ? 'text-gray-700' : 'text-gray-200'
          } ${activePage === 'listings' ? 'underline decoration-2 underline-offset-4 font-bold' : 'no-underline'}`}
          aria-current={activePage === 'listings' ? 'page' : undefined}
          href="/listings"
        >
          Listings
        </a>
        {isSignedIn ? (
          <button
            className="inline-flex min-h-[40px] min-w-[96px] cursor-pointer items-center justify-center rounded-4xl border-0 bg-gray-100 shadow-md px-5 text-sm  text-gray-600 transition-transform duration-200 hover:scale-110  md:min-h-[42px] md:min-w-[150px] md:px-8"
            onClick={handleSignOut}
            type="button"
          >
            Log out
          </button>
        ) : (
          <>
            <a
              className={`hidden text-sm  whitespace-nowrap no-underline transition-all duration-200 hover:scale-110 sm:inline md:text-[17px] ${
                isSolid ? 'text-gray-700' : 'text-gray-200'
              }`}
              href="/sign-in"
            >
              Sign in
            </a>
            <a
              className="inline-flex min-h-[40px] min-w-[96px] items-center justify-center rounded-4xl bg-blue-500 px-5 text-sm font-extrabold text-white no-underline transition-transform duration-200 hover:scale-110 hover:bg-blue-600 md:min-h-[42px] md:min-w-[150px] md:px-8"
              href="/sign-up"
            >
              Sign Up
            </a>
          </>
        )}
      </nav>
    </header>
  )
}

export default Navbar
