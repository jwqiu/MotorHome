function Navbar() {
  return (
    <header className="absolute top-0 left-0 z-20 flex h-28 w-full items-center justify-between bg-transparent px-20">
      <a
        className="font-outfit text-[26px] font-bold whitespace-nowrap text-white no-underline"
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
          className="text-[17px] font-semibold whitespace-nowrap text-white transition-transform duration-200 hover:scale-110"
          href="/"
        >
          Home
        </a>
        <a
          className="text-[17px] font-semibold whitespace-nowrap text-gray-200 no-underline transition-transform duration-200 hover:scale-110"
          href="/listings"
        >
          Listings
        </a>
        <a
          className="text-[17px] font-semibold whitespace-nowrap text-gray-200 no-underline transition-transform duration-200 hover:scale-110"
          href="/sign-in"
        >
          Sign in
        </a>
        <a
          className="inline-flex min-h-[42px] min-w-[106px] items-center justify-center rounded-4xl bg-blue-500 text-[17px] font-semibold whitespace-nowrap text-white no-underline transition-transform duration-200 hover:scale-110"
          href="/sign-up"
        >
          Sign up
        </a>
      </nav>
    </header>
  )
}

export default Navbar
