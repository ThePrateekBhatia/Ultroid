#!/usr/bin/env python3
# Ultroid - UserBot
# Copyright (C) 2021-2025 TeamUltroid
#
# This file is a part of < https://github.com/TeamUltroid/Ultroid/ >
# For Koyeb deployment with web server integration

import os
import sys
import time
import subprocess
import threading

# Import the web server module
from web_server import start_server

def run_bot():
    """Run the Ultroid bot in a separate process"""
    print("Starting Ultroid bot...")
    subprocess.Popen([sys.executable, "-m", "pyUltroid"])

def main():
    """Main function to run both the web server and the bot"""
    # Start the web server in a separate thread
    server_thread = start_server()
    
    # Give the server a moment to start
    time.sleep(2)
    
    # Start the bot
    run_bot()
    
    # Keep the main thread running
    try:
        while True:
            time.sleep(60)
    except KeyboardInterrupt:
        print("Shutting down...")
        sys.exit(0)

if __name__ == "__main__":
    main()
