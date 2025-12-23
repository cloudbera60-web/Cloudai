# Use Node.js LTS version
FROM node:18-alpine

# Create app directory
WORKDIR /usr/src/app

# Install dependencies first (caching optimization)
COPY package*.json ./
RUN npm install

# Copy source code
COPY . .

# Create temp directory for auth states
RUN mkdir -p temp

# Expose port (Render will set the PORT env variable)
EXPOSE $PORT

# Start the application (Render prefers direct node start)
CMD ["node", "index.js"]
