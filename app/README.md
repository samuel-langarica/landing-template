# Flutter Web App with Python Server

This project includes a Python server to serve the Flutter web build output, making it easy to deploy without requiring the Flutter SDK in production.

## Project Structure
```
app/
├── lib/
│   └── main.dart
├── build/
│   └── web/          # Flutter web build output
├── server.py         # Python server
├── requirements.txt  # Python dependencies
└── Procfile         # Process configuration
```

## Development

1. Build the Flutter web app (from the app directory):
```bash
cd app
flutter build web
```

2. Run the Python server (from the app directory):
```bash
cd app
python server.py
```

The app will be available at http://localhost:8080

## Deployment

1. Build the Flutter web app (from the app directory):
```bash
cd app
flutter build web
```

2. Deploy the entire `app` directory to your hosting platform. The platform will need:
   - The `build/web` directory (from Flutter build)
   - `server.py`
   - `requirements.txt`
   - `Procfile`

3. The platform will automatically use the Procfile to start the server:
```bash
web: python server.py
```

The server will automatically use the PORT environment variable if set, otherwise defaults to 8080.

## Features

- Serves static files from the Flutter web build
- Includes CORS headers for cross-origin requests
- Configurable port via environment variable
- No external Python dependencies required
- Ready for deployment with Procfile support
