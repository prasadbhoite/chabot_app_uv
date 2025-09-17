# Use a slim Python base image for a smaller final image size
FROM python:3.11-slim

# Install uv, the fast Python package manager
RUN pip install --no-cache-dir uv

# Set the working directory inside the container
WORKDIR /app

# Copy the dependency configuration files first.
# This leverages Docker's layer caching for faster rebuilds.
COPY pyproject.toml uv.lock ./

# Install the project dependencies using uv.
# This creates a virtual environment at /app/.venv
RUN uv sync --frozen

# Copy the rest of your application's code into the working directory
COPY . .

# EXPOSE 8080 is a common convention for web apps, though Azure ignores it.
# We don't need to set our own PORT variable, as Azure provides it.
EXPOSE 8080

# Create startup script to handle environment variables
RUN echo '#!/bin/bash' > /app/start.sh && \
    echo 'export PORT=${PORT:-8080}' >> /app/start.sh && \
    echo 'unset STREAMLIT_SERVER_PORT' >> /app/start.sh && \
    echo 'exec /app/.venv/bin/streamlit run main.py --server.port=$PORT --server.address=0.0.0.0' >> /app/start.sh && \
    chmod +x /app/start.sh

# Use the startup script
CMD ["/app/start.sh"]

