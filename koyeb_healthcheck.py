#!/usr/bin/env python3
# Simple HTTP server for Koyeb health checks

import http.server
import socketserver
import threading
import logging

PORT = 8080

class HealthHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        self.wfile.write(b'Ultroid is running')
    
    def log_message(self, format, *args):
        # Suppress logging to avoid cluttering the console
        return

def start_server():
    try:
        with socketserver.TCPServer(("", PORT), HealthHandler) as httpd:
            print(f"Health check server started at port {PORT}")
            httpd.serve_forever()
    except Exception as e:
        logging.error(f"Health check server error: {str(e)}")

if __name__ == "__main__":
    # Start in a thread if imported by another script
    server_thread = threading.Thread(target=start_server)
    server_thread.daemon = True
    server_thread.start()
    print(f"Health check server started in background thread on port {PORT}") 