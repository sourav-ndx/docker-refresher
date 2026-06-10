# ==========================================
# Phase 1: Heavy Build Context (Builder)
# ==========================================
FROM node:20-alpine AS builder

WORKDIR /app

# Leverage Docker cache layer optimization by copying configs first
COPY package*.json ./

# Install clean, production-only dependencies
RUN npm ci --only=production

# Copy remaining source directory files
COPY src/ ./src/


# ==========================================
# Phase 2: Lean Production Engine (Runner)
# ==========================================
FROM node:20-alpine AS runner

ENV NODE_ENV=production
WORKDIR /app

# Hardening Rule: Setup a non-privileged user boundary (User ID 1001)
RUN addgroup -g 1001 -S nodejs && \
    adduser -u 1001 -S nodeapp -G nodejs

# Copy ONLY compiled/cleaned runtime assets out of the builder stage
COPY --from=builder --chown=nodeapp:nodejs /app ./

# Switch execution user away from root context
USER nodeapp

# Document the runtime port mapping
EXPOSE 8080

CMD ["node", "src/app.js"]