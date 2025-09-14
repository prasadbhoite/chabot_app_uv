# Use slim Python base image
FROM python:3.11-slim

# Install uv (fast dependency manager)
RUN pip install --no-cache-dir uv

# Set working directory
WORKDIR /app

# Copy pyproject and lock file first (better caching)
COPY pyproject.toml uv.lock ./

# Install dependencies with uv
RUN uv sync --frozen

# Copy rest of the app
COPY . .

# Configure Streamlit: bind to $PORT and use /home instead of /temp
RUN mkdir -p /root/.streamlit
RUN echo "\
[server]\n\
headless = true\n\
enableCORS = false\n\
port = $PORT\n\
address = \"0.0.0.0\"\n\
\n\
[global]\n\
tmpDir = \"/home\"\n\
" > /root/.streamlit/config.toml

# Default port for local testing (Azure overrides with $PORT)
ENV PORT=8501

# Expose for local debugging
EXPOSE 8501

# Start Streamlit app
CMD ["streamlit", "run", "main.py"]