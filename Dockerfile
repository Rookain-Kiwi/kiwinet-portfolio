# ── Étape 1 : Build Astro ──────────────────────────────
FROM node:lts-alpine AS builder

WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# ── Étape 2 : Servir avec Nginx Alpine ────────────────
FROM nginx:alpine

COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80