FROM node:18-bullseye-slim

WORKDIR /app

# Install required system packages
RUN apt-get update && \
    apt-get install -y \
    python3 \
    make \
    g++ \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy package files
COPY package.json ./

# Update npm to latest version
RUN npm install -g npm@latest

# Clean npm cache
RUN npm cache clean --force

# Install dependencies with specific flags
RUN npm install --legacy-peer-deps --verbose

# Copy application code
COPY . .

# Create temp directory
RUN mkdir -p temp

EXPOSE 8000

CMD ["node", "index.js"]
