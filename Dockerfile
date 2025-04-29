FROM python:3.12-slim

# Create a non-root user
RUN adduser --disabled-password --gecos '' botuser

# Install dependencies
RUN apt-get update && apt-get install -y ffmpeg libsndfile1 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .

# Install Python packages
RUN pip install --no-cache-dir -r requirements.txt

# Switch to non-root user
USER botuser

CMD ["python", "bot.py"]
