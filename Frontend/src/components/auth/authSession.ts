const AUTH_SESSION_KEY = 'mt-exchange-authenticated'
const AUTH_USER_ID_KEY = 'mt-exchange-user-id'
const AUTH_USER_NAME_KEY = 'mt-exchange-user-name'
const AUTH_USER_EMAIL_KEY = 'mt-exchange-user-email'
const AUTH_IDENTITY_VERIFIED_KEY = 'mt-exchange-identity-verified'

export function isAuthenticated() {
  return window.localStorage.getItem(AUTH_SESSION_KEY) === 'true'
}

export function getSessionUserId() {
  return window.localStorage.getItem(AUTH_USER_ID_KEY) || ''
}

export function getSessionUserName() {
  return window.localStorage.getItem(AUTH_USER_NAME_KEY) || 'Member'
}

export function getSessionUserEmail() {
  return window.localStorage.getItem(AUTH_USER_EMAIL_KEY) || 'member@example.com'
}

export function isIdentityVerified() {
  return window.localStorage.getItem(AUTH_IDENTITY_VERIFIED_KEY) === 'true'
}

export function setIdentityVerified() {
  window.localStorage.setItem(AUTH_IDENTITY_VERIFIED_KEY, 'true')
}

export function signInSession(
  userId = '',
  userName = 'Member',
  email = 'member@example.com',
  identityVerified = false,
) {
  window.localStorage.setItem(AUTH_SESSION_KEY, 'true')
  window.localStorage.setItem(AUTH_USER_ID_KEY, userId)
  window.localStorage.setItem(AUTH_USER_NAME_KEY, userName)
  window.localStorage.setItem(AUTH_USER_EMAIL_KEY, email)

  if (identityVerified) {
    window.localStorage.setItem(AUTH_IDENTITY_VERIFIED_KEY, 'true')
  } else {
    window.localStorage.removeItem(AUTH_IDENTITY_VERIFIED_KEY)
  }
}

export function signOutSession() {
  window.localStorage.removeItem(AUTH_SESSION_KEY)
  window.localStorage.removeItem(AUTH_USER_ID_KEY)
  window.localStorage.removeItem(AUTH_USER_NAME_KEY)
  window.localStorage.removeItem(AUTH_USER_EMAIL_KEY)
  window.localStorage.removeItem(AUTH_IDENTITY_VERIFIED_KEY)
}
