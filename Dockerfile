# ==========================================
# Stage 1: Build Environment (The Kitchen)
# ==========================================
FROM node:20-alpine AS builder

WORKDIR /app

# Copy dependency list and install everything
COPY package.json ./
RUN npm install

# Copy your application source code
COPY src/ ./src/

# ==========================================
# Stage 2: Runtime Environment (The Plate)
# ==========================================
FROM node:20-alpine AS runner

WORKDIR /app

# Copy ONLY the clean app folder out of Stage 1
COPY --from=builder /app ./

EXPOSE 8080

CMD ["node", "src/app.js"]


