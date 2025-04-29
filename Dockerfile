FROM python:3.12-slim

# Create a non-root user with UID in the required range
RUN adduser --disabled-password --gecos '' --uid 10001 botuser

# Install dependencies
RUN apt-get update && apt-get install -y ffmpeg libsndfile1 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .

# Install Python packages
RUN pip install --no-cache-dir -r requirements.txt

# Switch to non-root user (Choreo-compliant UID)
USER 10001

CMD ["python", "bot.py"]
