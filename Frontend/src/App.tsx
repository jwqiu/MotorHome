import HomePage from './pages/HomePage'
import ListingDetailPage from './pages/ListingDetailPage'
import ListingsPage from './pages/ListingsPage'

function App() {
  const path = window.location.pathname

  if (path.startsWith('/listings/')) {
    return <ListingDetailPage />
  }

  if (path === '/listings') {
    return <ListingsPage />
  }

  return <HomePage />
}

export default App
