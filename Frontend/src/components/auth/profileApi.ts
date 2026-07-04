type ErrorResponse = {
  message?: string
}

export type ProfileResponse = {
  bio?: string
  email: string
  id: string
  identityVerified: boolean
  location?: string
  memberSince?: string
  spokenLanguages?: string
  userName: string
}

export async function getProfile(userId: string) {
  const response = await window.fetch(`/api/profile/${encodeURIComponent(userId)}`)

  if (!response.ok) {
    let errorMessage = 'Unable to load profile. Please try again.'

    try {
      const error = (await response.json()) as ErrorResponse
      errorMessage = error.message || errorMessage
    } catch {
      // Keep the generic message when the server returns a non-JSON error.
    }

    throw new Error(errorMessage)
  }

  return (await response.json()) as ProfileResponse
}

export async function updateIntroduction(userId: string, introduction: string) {
  const response = await window.fetch(`/api/profile/${encodeURIComponent(userId)}/introduction`, {
    body: JSON.stringify({ introduction }),
    headers: {
      'Content-Type': 'application/json',
    },
    method: 'PATCH',
  })

  if (!response.ok) {
    let errorMessage = 'Unable to save introduction. Please try again.'

    try {
      const error = (await response.json()) as ErrorResponse
      errorMessage = error.message || errorMessage
    } catch {
      // Keep the generic message when the server returns a non-JSON error.
    }

    throw new Error(errorMessage)
  }

  return (await response.json()) as ProfileResponse
}
