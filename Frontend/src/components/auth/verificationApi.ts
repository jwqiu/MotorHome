type VerificationResponse = {
  id: string
  email: string
  identityVerified: boolean
}

type ErrorResponse = {
  message?: string
}

type IdentityVerificationRequest = {
  backLicenceFileName: string
  confirmationAccepted: boolean
  dateOfBirth: string
  email: string
  frontLicenceFileName: string
  legalFirstName: string
  legalLastName: string
  licenceNumber: string
  versionNumber: string
}

export async function verifyIdentity(payload: IdentityVerificationRequest) {
  const response = await window.fetch('/api/verification/identity', {
    body: JSON.stringify(payload),
    headers: {
      'Content-Type': 'application/json',
    },
    method: 'POST',
  })

  if (!response.ok) {
    let errorMessage = response.status === 502 || response.status === 504
      ? 'Verification service is unavailable. Please make sure the backend is running.'
      : 'Unable to submit verification. Please try again.'

    try {
      const error = (await response.json()) as ErrorResponse
      errorMessage = error.message || errorMessage
    } catch {
      // Keep the generic message when the server returns a non-JSON error.
    }

    throw new Error(errorMessage)
  }

  return (await response.json()) as VerificationResponse
}
