import { useState } from 'react'
import './App.css'

function App() {
  const [message, setMessage] = useState('')
  const [isLoading, setIsLoading] = useState(false)

  async function handleCheckBackend() {
    setIsLoading(true)
    setMessage('')

    try {
      const response = await fetch('/api/connection')

      if (!response.ok) {
        throw new Error(`Request failed with status ${response.status}`)
      }

      const result = await response.json()
      setMessage(
        result === 1
          ? 'Backend response received. Frontend and backend are connected successfully.'
          : 'The backend returned an unexpected response.',
      )
    } catch {
      setMessage('Failed to reach the backend. Please make sure the backend service is running.')
    } finally {
      setIsLoading(false)
    }
  }

  return (
    <main className="page">
      <div className="connection-check">
        <button type="button" onClick={handleCheckBackend} disabled={isLoading}>
          {isLoading ? 'Checking...' : 'Check backend connection'}
        </button>
        {message && <p>{message}</p>}
      </div>
    </main>
  )
}

export default App
