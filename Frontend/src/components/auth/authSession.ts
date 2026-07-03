const AUTH_SESSION_KEY = 'mt-exchange-authenticated'

export function isAuthenticated() {
  return window.localStorage.getItem(AUTH_SESSION_KEY) === 'true'
}

export function signInSession() {
  window.localStorage.setItem(AUTH_SESSION_KEY, 'true')
}

export function signOutSession() {
  window.localStorage.removeItem(AUTH_SESSION_KEY)
}
