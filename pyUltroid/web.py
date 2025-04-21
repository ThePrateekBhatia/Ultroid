# Minimal Flask web server for Heroku
from flask import Flask
import os
import threading
import sys
import importlib

app = Flask(__name__)

@app.route("/")
def index():
    return "Ultroid UserBot is running!"

@app.route("/healthcheck")
def healthcheck():
    return "ok", 200

def start_userbot():
    # Import and run pyUltroid.__main__.main()
    main_mod = importlib.import_module("pyUltroid.__main__")
    main_mod.main()

if __name__ == "__main__":
    # Start userbot in a background thread
    t = threading.Thread(target=start_userbot, daemon=True)
    t.start()
    port = int(os.environ.get("PORT", 8080))
    app.run(host="0.0.0.0", port=port)
