FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install uv
RUN pip install --upgrade pip && pip install uv

# Copy project files
COPY pyproject.toml ./
COPY main.py ./
COPY utils/ ./utils/

# Install Python dependencies using uv
RUN uv sync

EXPOSE $PORT

CMD ["sh", "-c", "uv run streamlit run main.py --server.port=$PORT --server.address=0.0.0.0"]