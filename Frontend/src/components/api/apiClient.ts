const apiBaseUrl = (import.meta.env.VITE_API_BASE_URL ?? '').trim().replace(/\/$/, '')

export function apiUrl(path: string) {
  return `${apiBaseUrl}${path}`
}

export function apiFetch(path: string, init?: RequestInit) {
  return window.fetch(apiUrl(path), init)
}
