import ForgotPasswordPage from './pages/ForgotPasswordPage'
import HomePage from './pages/HomePage'
import IdentityVerificationPage from './pages/IdentityVerificationPage'
import ListingDetailPage from './pages/ListingDetailPage'
import ListingsPage from './pages/ListingsPage'
import ManageListingFormPage from './pages/ManageListingFormPage'
import ReceivedEnquiryDetailPage from './pages/ReceivedEnquiryDetailPage'
import SignInPage from './pages/SignInPage'
import SignUpPage from './pages/SignUpPage'
import SentEnquiryDetailPage from './pages/SentEnquiryDetailPage'
import UserCenterPage from './pages/UserCenterPage'

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

  if (path === '/identity-verification' || path === '/user-center/verification') {
    return <IdentityVerificationPage />
  }

  if (path.startsWith('/user-center/enquiries/received/')) {
    return <ReceivedEnquiryDetailPage />
  }

  if (path.startsWith('/user-center/enquiries/sent/')) {
    return <SentEnquiryDetailPage />
  }

  if (path === '/user-center/listings/new' || path.match(/^\/user-center\/listings\/[^/]+\/edit$/)) {
    return <ManageListingFormPage />
  }

  if (path === '/user-center') {
    return <UserCenterPage />
  }

  return <HomePage />
}

export default App
