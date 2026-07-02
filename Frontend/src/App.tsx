import HomePage from './pages/HomePage'
import ListingsPage from './pages/ListingsPage'

function App() {
  const path = window.location.pathname

  if (path.startsWith('/listings')) {
    return <ListingsPage />
  }

  return <HomePage />
}

export default App
