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

# Add the virtual environment's bin directory to the system's PATH.
# This ensures that when we run `streamlit`, we're using the version installed in our virtual environment.
ENV PATH="/app/.venv/bin:$PATH"

# Copy the rest of your application's code into the working directory
COPY . .

# Set the PORT environment variable. Azure will provide this at runtime.
# We include a default of 8501 for easy local testing with `docker run`.
ENV PORT=${PORT:-8501}

# Expose the port. This is good practice for documentation and local runs, though Azure ignores it.
EXPOSE 8501

# Define the command to run when the container starts.
# We use `sh -c` to ensure the $PORT environment variable is correctly substituted into the command at runtime.
# This is the most reliable way to ensure Streamlit listens on the port Azure expects.
CMD sh -c "streamlit run main.py --server.port=$PORT --server.address=0.0.0.0"

