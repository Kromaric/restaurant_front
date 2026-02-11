# ==========================================
# Stage 1: Builder - Compilation de React
# ==========================================
FROM node:20-alpine AS builder
WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# ==========================================
# Stage 2: Production - Serveur Web Nginx
# ==========================================
FROM nginx:stable-alpine AS production

# On copie les fichiers compilés de React vers le dossier public de Nginx
COPY --from=builder /app/build /usr/share/nginx/html

# Exposer le port 80 (standard pour Nginx)
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]