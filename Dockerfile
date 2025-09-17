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

# Define the command to run when the container starts.
# We use the ABSOLUTE PATH to streamlit to guarantee it is found.
# Use env -u to remove the problematic STREAMLIT_SERVER_PORT variable
CMD sh -c "env -u STREAMLIT_SERVER_PORT /app/.venv/bin/streamlit run main.py --server.port=\${PORT:-8080} --server.address=0.0.0.0"

