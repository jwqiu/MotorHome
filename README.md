# MotorHome

MotorHome is a full-stack web project with a React frontend and an ASP.NET Core Web API backend.

## Tech Stack

- Frontend: React, TypeScript, Vite
- Backend: ASP.NET Core Web API, C#
- Runtime/tools: Node.js, npm, .NET SDK

## Project Structure

```text
MotorHome/
  Frontend/   React + TypeScript app
  Backend/    ASP.NET Core Web API
  scripts/    Local development scripts
```

## First-Time Setup

Install the frontend dependencies once:

```bash
npm --prefix Frontend install
```

Check whether the .NET SDK is installed:

```bash
dotnet --version
```

If this command prints a version number, the .NET SDK is already installed.

If the command is not found, install the .NET SDK first:

macOS with Homebrew:

```bash
brew install --cask dotnet-sdk
```

Create the local PostgreSQL database and apply the schema:

```bash
createdb motorhome
psql -d motorhome -f database/001_schema_and_seed.sql
```

The backend default connection string is in `Backend/appsettings.Development.json`:

```text
Host=localhost;Port=5432;Database=motorhome;Username=postgres;Password=postgres
```

Update it if your local PostgreSQL username or password is different.

## Start Frontend And Backend Together

From the project root, run:

```bash
npm run dev
```

This starts both services:

- Frontend: http://127.0.0.1:5173
- Backend: http://127.0.0.1:5080

On macOS, the frontend page opens automatically in the default browser after both services are ready.

When both services start successfully, the terminal shows:

```text
============================================================
READY: frontend and backend are running.

Frontend: http://127.0.0.1:5173
Backend:  http://127.0.0.1:5080
API test: http://127.0.0.1:5173/api/connection

Opening frontend in default browser...

Press Ctrl+C to stop both services.
============================================================
```

The frontend proxies API requests from `/api` to the backend. For example:

```text
http://127.0.0.1:5173/api/connection
```

is forwarded to:

```text
http://127.0.0.1:5080/api/connection
```

Press `Ctrl + C` in the terminal to stop both services.

## Backend API Structure

The backend is an ASP.NET Core Web API. All controller routes use the `/api` prefix.

- Local backend base URL: `http://127.0.0.1:5080`
- Frontend proxy base URL: `http://127.0.0.1:5173/api`
- Swagger UI in development: `http://127.0.0.1:5080/swagger`

### AuthController

Base route: `/api/auth`

Handles account authentication, registration, and password recovery.

| Method | Endpoint | Purpose |
| --- | --- | --- |
| `POST` | `/api/auth/login` | Validates an email and password, then returns the authenticated user's ID, name, email, and identity-verification status. |
| `POST` | `/api/auth/sign-up` | Creates a user account after validating the required name, email, password, and verification code. Returns the newly created user. |
| `POST` | `/api/auth/forgot-password` | Finds an account by email and replaces its password after the required verification information is supplied. |

### ConnectionController

Base route: `/api/connection`

Provides a lightweight API health check used to confirm that the frontend can reach the backend.

| Method | Endpoint | Purpose |
| --- | --- | --- |
| `GET` | `/api/connection` | Returns `1` when the backend is running and reachable. |

### ListingController

Base route: `/api/listing`

Manages public listings and the listings owned by individual users.

| Method | Endpoint | Purpose |
| --- | --- | --- |
| `GET` | `/api/listing` | Returns active listings. Supports optional filters for `country`, `city`, `category`, `listingType`, `exchangeMethod`, `exchangeTimings`, `availableFrom`, and `availableTo`. |
| `POST` | `/api/listing` | Creates a new active listing for the supplied owner and generates a unique URL slug from its title. |
| `PUT` | `/api/listing/{id}` | Updates a listing by numeric ID. The `OwnerId` in the request must match the listing owner. |
| `DELETE` | `/api/listing/{id}?ownerId={ownerId}` | Deletes a listing owned by the supplied user. Deletion is rejected while the listing is linked to pending enquiries. |
| `GET` | `/api/listing/owner/{ownerId}` | Returns all listings belonging to one owner, including listings that are not currently active. |
| `GET` | `/api/listing/{slug}` | Returns the full details of one listing and its owner information using the listing slug. |

### EnquiriesController

Base route: `/api/enquiries`

Manages exchange enquiries, including creation, user inboxes, cancellation, and owner decisions.

| Method | Endpoint | Purpose |
| --- | --- | --- |
| `GET` | `/api/enquiries/exchange-listings/{userId}` | Returns the user's active listings that can be offered in an exchange. The optional `excludeListingId` query parameter removes the current listing from the result. |
| `GET` | `/api/enquiries/user/{userId}` | Returns the user's sent and received enquiries, related listing summaries, counterparty details, and current statuses. Cancelled enquiries are omitted from the received list. |
| `GET` | `/api/enquiries/status?listingId={listingId}&senderId={senderId}` | Checks whether a sender already has a pending enquiry for a listing. |
| `POST` | `/api/enquiries` | Creates a pending enquiry for a listing after validating the sender, message, and disclaimer acceptance. An optional offered listing can be included. |
| `POST` | `/api/enquiries/{id}/cancel` | Cancels a pending enquiry. When `SenderId` is provided, it must match the enquiry sender. |
| `POST` | `/api/enquiries/{id}/agree-to-discuss` | Allows the listing owner to accept a pending enquiry for further discussion. The enquiry becomes `Agreed`, and contact details become available to both parties. |
| `POST` | `/api/enquiries/{id}/decline` | Allows the listing owner to decline a pending enquiry and optionally include an owner response. |

### ProfileController

Base route: `/api/profile`

Provides user profile information and profile-introduction updates.

| Method | Endpoint | Purpose |
| --- | --- | --- |
| `GET` | `/api/profile/{userId}` | Returns a user's name, email, introduction, location, membership date, spoken languages, and identity-verification status. |
| `PATCH` | `/api/profile/{userId}/introduction` | Updates or clears the user's profile introduction. |

### VerificationController

Base route: `/api/verification`

Handles identity verification using New Zealand driver-licence information.

| Method | Endpoint | Purpose |
| --- | --- | --- |
| `POST` | `/api/verification/identity` | Validates the required identity and licence fields, records the submitted document filenames, and marks the matching user's identity as verified. |

## Build

From the project root, run:

```bash
npm run build
```

This builds the frontend and the backend.
