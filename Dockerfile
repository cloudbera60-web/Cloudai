FROM node:20-alpine

WORKDIR /app

# Install Python and build tools
RUN apk add --no-cache python3 make g++ git

# Install PM2 globally
RUN npm install -g pm2

# Copy package.json first
COPY package.json ./

# Install app dependencies
RUN npm install

# Copy the rest of the application
COPY . .

# Create temp directory
RUN mkdir -p temp

EXPOSE 8000

# Run with PM2 in cluster mode
CMD ["pm2-runtime", "start", "index.js", "--name", "vajira-md"]
