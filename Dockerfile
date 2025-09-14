# Use a slim Python base image for a smaller final image size
FROM python:3.11-slim

# Install uv, the fast Python package manager
RUN pip install --no-cache-dir uv

# Set the working directory inside the container
WORKDIR /app

# Copy the dependency configuration files first.
# This leverages Docker's layer caching, so dependencies are only re-installed if these files change.
COPY pyproject.toml uv.lock ./

# Install the project dependencies using uv.
# This creates a virtual environment at /app/.venv
RUN uv sync --frozen

# Copy the rest of your application's code into the working directory
COPY . .

# Let Azure set the PORT, but keep 8501 as a fallback for local runs
ENV PORT=${PORT:-8501}

# Expose the port for documentation and local testing
EXPOSE 8501

# Define the command to run when the container starts.
# We use the ABSOLUTE PATH to the streamlit executable to guarantee it is found.
# We use `sh -c` to ensure the $PORT environment variable is correctly substituted at runtime.
CMD sh -c "/app/.venv/bin/streamlit run main.py --server.port=$PORT --server.address=0.0.0.0"

