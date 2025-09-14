# Use slim Python base image
FROM python:3.11-slim

# Install uv (fast dependency manager)
RUN pip install --no-cache-dir uv

# Set working directory
WORKDIR /app

# Copy pyproject and lock file first for better caching
COPY pyproject.toml uv.lock ./

# Install dependencies with uv
RUN uv sync --frozen

# Copy the rest of the app
COPY . .

# Azure will set this PORT environment variable at runtime.
# Default to 8501 for local testing.
ENV PORT=8501

# Start Streamlit, telling it explicitly to use the PORT from the environment
CMD sh -c "streamlit run main.py --server.port=$PORT --server.address=0.0.0.0"

