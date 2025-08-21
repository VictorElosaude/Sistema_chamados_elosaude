# Estágio de build do frontend
FROM node:20 AS frontend-builder
WORKDIR /app
COPY ./frontend/package.json ./frontend/
RUN npm install
COPY ./frontend/ .
RUN npm run build

# Estágio de build do backend
FROM node:20
WORKDIR /app
COPY ./backend/package.json ./backend/
RUN npm install --prefix ./backend

# Copia os arquivos do backend e do frontend
COPY ./backend/ .
COPY --from=frontend-builder /app/build ./frontend/build

# Define o diretório de trabalho para o backend
WORKDIR /app/backend

# Comando para iniciar a aplicação
CMD ["npm", "start"]
