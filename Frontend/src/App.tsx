import ForgotPasswordPage from './pages/ForgotPasswordPage'
import HomePage from './pages/HomePage'
import ListingDetailPage from './pages/ListingDetailPage'
import ListingsPage from './pages/ListingsPage'
import SignInPage from './pages/SignInPage'
import SignUpPage from './pages/SignUpPage'

function App() {
  const path = window.location.pathname

  if (path.startsWith('/listings/')) {
    return <ListingDetailPage />
  }

  if (path === '/listings') {
    return <ListingsPage />
  }

  if (path === '/sign-in') {
    return <SignInPage />
  }

  if (path === '/sign-up') {
    return <SignUpPage />
  }

  if (path === '/forgot-password') {
    return <ForgotPasswordPage />
  }

  return <HomePage />
}

export default App
