# Use slim Python base image
FROM python:3.11-slim

# Install uv
RUN pip install --no-cache-dir uv

# Set working directory
WORKDIR /app

# Copy dependency files first (for layer caching)
COPY pyproject.toml uv.lock ./

# Install dependencies into system environment (no venv)
RUN uv pip install --system --frozen .

# Copy rest of the app
COPY . .

# Configure Streamlit
RUN mkdir -p /root/.streamlit && \
    echo "\
[server]\n\
headless = true\n\
enableCORS = false\n\
port = \$PORT\n\
address = \"0.0.0.0\"\n\
\n\
[global]\n\
tmpDir = \"/home\"\n\
" > /root/.streamlit/config.toml

# Default for local testing
ENV PORT=8501

# Expose for local run (Azure ignores)
EXPOSE 8501

# Run Streamlit
CMD ["streamlit", "run", "main.py"]
