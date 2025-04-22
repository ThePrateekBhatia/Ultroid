# Ultroid - UserBot (Koyeb Edition)
# Copyright (C) 2021-2025 TeamUltroid
# Extended for Koyeb deployment by ThePrateekBhatia
# This file is a part of < https://github.com/ThePrateekBhatia/Ultroid/ >
# PLease read the GNU Affero General Public License in <https://www.github.com/TeamUltroid/Ultroid/blob/main/LICENSE/>.

# Using the Koyeb optimized Dockerfile by default
# For detailed configuration see Dockerfile.koyeb

FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV TZ=Asia/Kolkata

# Create working directory
WORKDIR /app

# Install necessary packages
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    git \
    curl \
    sudo \
    wget \
    python3-dev \
    ffmpeg \
    neofetch \
    mediainfo \
    p7zip-full \
    jq \
    libglib2.0-dev \
    pv \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install
COPY requirements.txt .
RUN pip install -U pip && pip install -U -r requirements.txt

# Copy the project
COPY . .

# Make startup script executable
RUN chmod +x startup.koyeb

# Expose port for health checks (Koyeb requires this)
EXPOSE 8080

# Create a simple health check server
RUN echo 'import http.server\nimport socketserver\nimport os\nimport threading\nimport time\n\ndef run_server():\n    PORT = int(os.environ.get("PORT", 8080))\n    Handler = http.server.SimpleHTTPRequestHandler\n    with socketserver.TCPServer(("", PORT), Handler) as httpd:\n        print(f"Serving health check at port {PORT}")\n        httpd.serve_forever()\n\n# Start the server in a thread\nserver_thread = threading.Thread(target=run_server)\nserver_thread.daemon = True\nserver_thread.start()\n\n# Continue with the main application\nos.system("bash startup.koyeb")' > health_server.py

# Start both the health check server and the bot
CMD ["python", "health_server.py"]
