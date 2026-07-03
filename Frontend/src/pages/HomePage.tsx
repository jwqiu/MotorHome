import HomeCtaSection from '../components/home/HomeCtaSection'
import BrowseListingsSection from '../components/home/BrowseListingsSection'
import HeroSearchSection from '../components/home/HeroSearchSection'
import HowItWorksSection from '../components/home/HowItWorksSection'
import MemberStoriesSection from '../components/home/MemberStoriesSection'
import Navbar from '../components/layout/Navbar'

function HomePage() {
  return (
    <main className="min-h-screen bg-white font-sans text-gray-600 antialiased">
      <div className="relative">
        <Navbar activePage="home" />
        <HeroSearchSection />
      </div>
      <BrowseListingsSection />
      <HowItWorksSection />
      <MemberStoriesSection />
      <HomeCtaSection />
    </main>
  )
}

export default HomePage
