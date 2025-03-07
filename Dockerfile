# Base image bookworm-slim
FROM node:23-alpine3.21

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Remove these files to avoid following error:
# Error: Cannot find module @rollup/rollup-linux-x64-musl. 
# npm has a bug related to optional dependencies (https://github.com/npm/cli/issues/4828). 
# Please try `npm i` again after removing both package-lock.json and node_modules directory.
RUN rm -rf node_modules package-lock.json

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