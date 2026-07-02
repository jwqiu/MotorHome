import HeroSearchSection from '../components/home/HeroSearchSection'
import Navbar from '../components/layout/Navbar'

function HomePage() {
  return (
    <main className="min-h-screen bg-white font-sans text-gray-600 antialiased">
      <div className="relative">
        <Navbar />
        <HeroSearchSection />
      </div>
    </main>
  )
}

export default HomePage
