# Estágio de build do frontend
FROM node:20 AS frontend-builder
WORKDIR /app/frontend
COPY ./frontend/package.json .
RUN npm install
COPY ./frontend/ .
RUN npm run build

# Estágio de build do backend
FROM node:20
WORKDIR /app/backend
COPY ./backend/package.json .
RUN npm install

# Copia os arquivos do backend e do frontend
COPY ./backend/ .
COPY --from=frontend-builder /app/frontend/build ./frontend/build

# Define o diretório de trabalho para o backend
WORKDIR /app/backend

# Comando para iniciar a aplicação
CMD ["npm", "start"]
