import { apiFetch } from '../api/apiClient'

type AuthUser = {
  id: string
  userName: string
  email: string
  identityVerified: boolean
}

type ErrorResponse = {
  message?: string
}

async function postAuth<TRequest>(path: string, body: TRequest) {
  const response = await apiFetch(`/api/auth/${path}`, {
    body: JSON.stringify(body),
    headers: {
      'Content-Type': 'application/json',
    },
    method: 'POST',
  })

  if (!response.ok) {
    let errorMessage = 'Something went wrong. Please try again.'

    try {
      const error = (await response.json()) as ErrorResponse
      errorMessage = error.message || errorMessage
    } catch {
      // Keep the generic message when the server returns a non-JSON error.
    }

    throw new Error(errorMessage)
  }

  return (await response.json()) as AuthUser
}

export function login(email: string, password: string) {
  return postAuth('login', { email, password })
}

export function signUp(userName: string, email: string, password: string, verificationCode: string) {
  return postAuth('sign-up', { userName, email, password, verificationCode })
}

export function resetPassword(email: string, newPassword: string, verificationCode: string) {
  return postAuth('forgot-password', { email, newPassword, verificationCode })
}
