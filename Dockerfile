# Use Debian-based Node.js image for better compatibility
FROM node:18-bullseye

# Create app directory
WORKDIR /app

# Install Python and build tools (required for some native modules)
RUN apt-get update && \
    apt-get install -y \
    python3 \
    make \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Copy package files first for better caching
COPY package*.json ./

# Clean npm cache and install with verbose output
RUN npm cache clean --force && \
    npm install --verbose

# Copy application source
COPY . .

# Create temp directory
RUN mkdir -p temp

# Expose port
EXPOSE 8000

# Start the application
CMD ["node", "index.js"]
