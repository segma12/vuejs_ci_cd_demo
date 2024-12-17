# Stage 1: Build the Vue.js app
FROM node:20-alpine AS build

WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the application source
COPY . .

# Build the Vue.js app
RUN npm run build

# Stage 2: Serve the Vue.js app
FROM nginx:stable-alpine

# Copy built files from the previous stage
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80 for the web server
EXPOSE 80

# Start the Nginx server
CMD ["nginx", "-g", "daemon off;"]