import http.server
import socketserver
import os
from pathlib import Path

# Configuration
PORT = int(os.getenv('PORT', 8080))
# Update path to look for build/web in the current directory
BUILD_DIR = Path('build/web')

class Handler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=str(BUILD_DIR), **kwargs)

    def end_headers(self):
        # Add CORS headers
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET')
        self.send_header('Cache-Control', 'no-store, no-cache, must-revalidate')
        return super().end_headers()

def run_server():
    if not BUILD_DIR.exists():
        print(f"Error: Build directory '{BUILD_DIR}' not found!")
        print("Please run 'flutter build web' first.")
        return

    with socketserver.TCPServer(("", PORT), Handler) as httpd:
        print(f"Serving Flutter web app at http://localhost:{PORT}")
        print("Press Ctrl+C to stop the server")
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("\nShutting down server...")
            httpd.server_close()

if __name__ == "__main__":
    run_server() 