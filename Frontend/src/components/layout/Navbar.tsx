import { useEffect, useState } from 'react'
import { getSessionUserName, isAuthenticated, signOutSession } from '../auth/authSession'

type NavbarProps = {
  activePage?: 'home' | 'listings'
  variant?: 'overlay' | 'solid'
}

function Navbar({ activePage, variant = 'overlay' }: NavbarProps) {
  const [isScrolled, setIsScrolled] = useState(false)
  const [isMenuOpen, setIsMenuOpen] = useState(false)
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

  useEffect(() => {
    if (!isMenuOpen) {
      return
    }

    const handleKeyDown = (event: KeyboardEvent) => {
      if (event.key === 'Escape') {
        setIsMenuOpen(false)
      }
    }

    window.addEventListener('keydown', handleKeyDown)

    return () => {
      window.removeEventListener('keydown', handleKeyDown)
    }
  }, [isMenuOpen])

  const handleSignOut = () => {
    signOutSession()
    setIsMenuOpen(false)
    setIsSignedIn(false)
    setUserName('Member')
    window.location.href = '/'
  }

  return (
    <header
      className={`fixed top-0 left-0 z-20 flex h-20 w-full items-center justify-between px-6 transition-colors duration-300 sm:h-24  md:h-28 md:px-20 ${
        isSolid ? 'bg-white/40 shadow-lg shadow-gray-900/10 backdrop-blur-md' : 'bg-transparent'
      }`}
    >
      <a
        className={`font-outfit text-base font-bold whitespace-nowrap no-underline transition-colors duration-300 text-lg sm:text-xl md:text-[26px] ${
          isSolid ? 'text-gray-700' : 'text-white'
        }`}
        href="/"
        aria-label="MT Exchange home"
      >
        MT Exchange
      </a>

      <nav
        className="hidden items-center gap-4 sm:flex sm:gap-5 md:gap-[54px]"
        aria-label="Primary navigation"
      >
        <a
          className={`hidden text-sm whitespace-nowrap transition-all duration-200 hover:scale-110 sm:inline md:text-[17px] ${
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
          <div className="inline-flex min-h-[40px] max-w-[280px] items-center gap-2 rounded-4xl bg-gray-100 px-3 text-sm text-gray-600 sm:min-h-[42px] sm:gap-3 sm:px-4 md:px-5">
            <a
              aria-label="Go to profile"
              className="flex min-w-0 items-center gap-2 text-gray-600 no-underline transition hover:text-blue-500"
              href="/user-center"
            >
              <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" className="size-6">
                <path strokeLinecap="round" strokeLinejoin="round" d="M17.982 18.725A7.488 7.488 0 0 0 12 15.75a7.488 7.488 0 0 0-5.982 2.975m11.963 0a9 9 0 1 0-11.963 0m11.963 0A8.966 8.966 0 0 1 12 21a8.966 8.966 0 0 1-5.982-2.275M15 9.75a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
              </svg>

              <span className="hidden max-w-[110px] truncate sm:inline">{userName}</span>
            </a>
            <span className="hidden text-gray-300 sm:inline" aria-hidden="true">|</span>
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
              className="inline-flex min-h-[40px] min-w-[84px] items-center justify-center rounded-4xl bg-blue-500 px-4 text-sm font-extrabold text-white no-underline transition-transform duration-200 hover:scale-110 hover:bg-blue-600 sm:min-w-[96px] sm:px-5 md:min-h-[42px] md:min-w-[150px] md:px-8"
              href="/sign-up"
            >
              Sign Up
            </a>
          </>
        )}
      </nav>

      <button
        aria-controls="mobile-navigation"
        aria-expanded={isMenuOpen}
        aria-label={isMenuOpen ? 'Close navigation menu' : 'Open navigation menu'}
        className={`relative flex h-11 w-11 cursor-pointer items-center justify-center rounded-xl border-0 bg-white/15 transition-colors sm:hidden ${
          isSolid ? 'text-gray-700 hover:bg-gray-100' : 'text-white hover:bg-white/25'
        }`}
        onClick={() => setIsMenuOpen((isOpen) => !isOpen)}
        type="button"
      >
        {isMenuOpen ? (
          <svg aria-hidden="true" className="size-7" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={1.8}>
            <path strokeLinecap="round" strokeLinejoin="round" d="M6 18 18 6M6 6l12 12" />
          </svg>
        ) : (
          <svg aria-hidden="true" className="size-7" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={1.8}>
            <path strokeLinecap="round" strokeLinejoin="round" d="M4 6h16M4 12h16M4 18h16" />
          </svg>
        )}
      </button>

      {isMenuOpen ? (
        <nav
          id="mobile-navigation"
          aria-label="Mobile navigation"
          className="absolute top-[calc(100%-1px)] flex flex-col gap-3 right-4 left-4 overflow-hidden rounded-3xl border border-gray-100 bg-white p-6 text-gray-700 shadow-xl shadow-gray-900/15 sm:hidden"
        >
          <a
            aria-current={activePage === 'home' ? 'page' : undefined}
            className={`flex min-h-12 items-center rounded-2xl px-4 text-sm no-underline transition-colors hover:bg-blue-500 hover:text-white hover:font-bold ${
              activePage === 'home' ? 'bg-blue-50 font-bold text-blue-700' : 'text-gray-700'
            }`}
            href="/"
          >
            Home
          </a>
          <a
            aria-current={activePage === 'listings' ? 'page' : undefined}
            className={`flex min-h-12 items-center rounded-2xl px-4 text-sm no-underline transition-colors hover:bg-blue-500 hover:text-white hover:font-bold ${
              activePage === 'listings' ? 'bg-blue-50 font-bold text-blue-700' : 'text-gray-700'
            }`}
            href="/listings"
          >
            Listings
          </a>

          {isSignedIn ? (
            <div className="flex gap-4">
              <a
                className="flex min-h-12 w-1/2 items-center justify-center gap-3 rounded-2xl  px-4 text-sm text-gray-700 no-underline transition-colors bg-gray-50 hover:bg-blue-500 hover:text-white hover:font-bold"
                href="/user-center"
              >
                <svg aria-hidden="true" className="size-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={1.5}>
                  <path strokeLinecap="round" strokeLinejoin="round" d="M17.982 18.725A7.488 7.488 0 0 0 12 15.75a7.488 7.488 0 0 0-5.982 2.975m11.963 0a9 9 0 1 0-11.963 0m11.963 0A8.966 8.966 0 0 1 12 21a8.966 8.966 0 0 1-5.982-2.275M15 9.75a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
                </svg>
                <span className="truncate">{userName}</span>
              </a>
              <button
                className="flex min-h-12 w-1/2 cursor-pointer items-center justify-center gap-3 rounded-2xl border-0  px-4 text-left text-sm text-gray-700 transition-colors bg-gray-50 hover:bg-blue-500 hover:text-white hover:font-bold"
                onClick={handleSignOut}
                type="button"
              >
                <svg aria-hidden="true" className="size-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={1.5}>
                  <path strokeLinecap="round" strokeLinejoin="round" d="M15.75 9V5.25A2.25 2.25 0 0 0 13.5 3h-6A2.25 2.25 0 0 0 5.25 5.25v13.5A2.25 2.25 0 0 0 7.5 21h6a2.25 2.25 0 0 0 2.25-2.25V15m3-3H9.75m9 0-3-3m3 3-3 3" />
                </svg>
                <span>Log out</span>
              </button>
            </div>
          ) : (
            <div className="flex gap-4">
              <a
                className="flex w-1/2 bg-gray-50 min-h-12 items-center justify-center rounded-2xl px-4 text-sm text-gray-700 no-underline transition-colors hover:bg-blue-500 hover:text-white hover:font-bold"
                href="/sign-in"
              >
                Login
              </a>
              <a
                className="mt-1 w-1/2  flex min-h-12 items-center justify-center rounded-2xl bg-gray-50 sm:bg-blue-500 px-4 text-sm sm:font-extrabold sm:text-white no-underline transition-colors hover:bg-blue-600 hover:bg-blue-500 hover:text-white hover:font-bold"
                href="/sign-up"
              >
                Sign Up
              </a>
            </div>
          )}
        </nav>
      ) : null}
    </header>
  )
}

export default Navbar
