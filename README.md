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

## Build

From the project root, run:

```bash
npm run build
```

This builds the frontend and the backend.
