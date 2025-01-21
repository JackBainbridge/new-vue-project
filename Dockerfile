# Base image bookworm-slim
FROM node:23-alpine3.21

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install --include=optional --verbose

# Copy project files
COPY . .

# Build the app
RUN npm run build

# Expose port 5173 (Vite's default port)
EXPOSE 5173

# Start the app
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]