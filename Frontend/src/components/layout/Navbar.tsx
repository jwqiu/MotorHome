import { useEffect, useState } from 'react'
import { getSessionUserName, isAuthenticated, signOutSession } from '../auth/authSession'

type NavbarProps = {
  activePage?: 'home' | 'listings'
  variant?: 'overlay' | 'solid'
}

function Navbar({ activePage, variant = 'overlay' }: NavbarProps) {
  const [isScrolled, setIsScrolled] = useState(false)
  const [isSignedIn, setIsSignedIn] = useState(() => isAuthenticated())
  const [userName, setUserName] = useState(() => getSessionUserName())
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
    setUserName('Member')
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
          <div className="inline-flex min-h-[42px] max-w-[280px] items-center gap-3 rounded-4xl bg-gray-100 px-4 text-sm text-gray-600 md:px-5">
            <a
              aria-label="Go to profile"
              className="flex min-w-0 items-center gap-2 text-gray-600 no-underline transition hover:text-blue-500"
              href="/user-center"
            >
              <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" className="size-6">
                <path strokeLinecap="round" strokeLinejoin="round" d="M17.982 18.725A7.488 7.488 0 0 0 12 15.75a7.488 7.488 0 0 0-5.982 2.975m11.963 0a9 9 0 1 0-11.963 0m11.963 0A8.966 8.966 0 0 1 12 21a8.966 8.966 0 0 1-5.982-2.275M15 9.75a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
              </svg>

              <span className="max-w-[110px] truncate ">{userName}</span>
            </a>
            <span className="text-gray-300" aria-hidden="true">|</span>
            <button
              className="shrink-0 cursor-pointer border-0 bg-transparent p-0 text-sm  text-gray-600 transition hover:text-blue-500"
              onClick={handleSignOut}
              type="button"
            >
              Log out
            </button>
          </div>
        ) : (
          <>
            <a
              className={`hidden text-sm  whitespace-nowrap no-underline transition-all duration-200 hover:scale-110 sm:inline md:text-[17px] ${
                isSolid ? 'text-gray-700' : 'text-gray-200'
              }`}
              href="/sign-in"
            >
              Login
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
