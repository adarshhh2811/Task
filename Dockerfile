# ==========================
# Stage 1: Build Stage
# ==========================
FROM node:18-alpine AS builder

# Create app directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy application source
COPY . .

# ==========================
# Stage 2: Production Stage
# ==========================
FROM node:18-alpine

# Create app directory
WORKDIR /app

# Copy files from builder stage
COPY --from=builder /app .

# Create a non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Switch to non-root user
USER appuser

# Expose application port
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
