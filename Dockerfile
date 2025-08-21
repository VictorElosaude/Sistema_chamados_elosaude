# Build do frontend
FROM node:20 AS frontend-builder
WORKDIR /app/frontend
COPY frontend/package.json frontend/package-lock.json ./
RUN npm install
COPY frontend/ ./
RUN npm run build

# Build do backend
FROM node:20
WORKDIR /app/backend
COPY backend/package.json backend/package-lock.json ./
RUN npm install
COPY backend/ ./

# Copia o build do frontend para dentro do backend
COPY --from=frontend-builder /app/frontend/build ./frontend/build

# Expõe a porta que o backend vai usar
EXPOSE 4000

# Comando para rodar o backend
CMD ["node", "server.js"]
