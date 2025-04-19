# Ultroid - UserBot
# Copyright (C) 2021-2025 TeamUltroid
# This file is a part of < https://github.com/TeamUltroid/Ultroid/ >
# PLease read the GNU Affero General Public License in <https://www.github.com/TeamUltroid/Ultroid/blob/main/LICENSE/>.

FROM python:3.10-slim-buster

# Set environment variables
ENV PIP_NO_CACHE_DIR=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    TZ=Asia/Kolkata

# Set working directory
WORKDIR /app

# Install required system packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    ffmpeg \
    mediainfo \
    neofetch \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements
COPY requirements.txt .
COPY resources/startup/optional-requirements.txt .

# Install dependencies
RUN pip install -U pip && pip install --no-cache-dir -r requirements.txt && pip install --no-cache-dir -r optional-requirements.txt

# Copy project files
COPY . .

# Set port for Koyeb
EXPOSE 8080

# Run the application
CMD ["bash", "startup"]
