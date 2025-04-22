import os
import logging
from flask import Flask, jsonify
import threading

# Initialize Flask app
app = Flask(__name__)

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

@app.route('/')
def home():
    """Minimal status page for Koyeb health check"""
    html = """
    <!DOCTYPE html>
    <html>
    <head>
        <title>Ultroid Bot Status</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            body { font-family: Arial, sans-serif; margin: 40px; text-align: center; }
            .status { display: inline-block; width: 10px; height: 10px; background: green; border-radius: 50%; margin-right: 5px; }
            .container { max-width: 600px; margin: 0 auto; }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Ultroid Telegram UserBot</h1>
            <p><span class="status"></span> Bot service is running</p>
            <p>Visit <a href="https://t.me/TeamUltroid">@TeamUltroid</a> for updates</p>
        </div>
    </body>
    </html>
    """
    return html

@app.route('/health')
def health():
    """Health check endpoint for Koyeb"""
    return jsonify({"status": "ok"})

def run_server():
    """Run the Flask web server"""
    port = int(os.environ.get("PORT", 8080))
    app.run(host="0.0.0.0", port=port)

def start_server():
    """Start the server in a separate thread"""
    server_thread = threading.Thread(target=run_server, daemon=True)
    server_thread.start()
    logger.info(f"Web server started on port 8080")
    return server_thread

if __name__ == "__main__":
    # If running directly, start the server
    run_server()
