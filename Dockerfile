# ----------------------------------------
# Etapa 1: Build do frontend
# ----------------------------------------
FROM node:20 AS frontend-builder

WORKDIR /app/frontend

# Copia apenas package.json e package-lock.json para instalar dependências
COPY ./frontend/package.json ./frontend/package-lock.json ./

# Instala dependências e garante permissões para react-scripts
RUN npm install --legacy-peer-deps && chmod -R 755 ./node_modules/.bin

# Copia o restante do frontend
COPY ./frontend/ .

# Build do React
RUN npm run build

# ----------------------------------------
# Etapa 2: Build do backend
# ----------------------------------------
FROM node:20

WORKDIR /app/backend

# Copia apenas package.json e package-lock.json do backend
COPY ./backend/package.json ./backend/package-lock.json ./

# Instala dependências do backend
RUN npm install --legacy-peer-deps

# Copia os arquivos do backend
COPY ./backend/ .

# Copia o build do frontend para dentro do backend
COPY --from=frontend-builder /app/frontend/build ./frontend/build

# Define variável de ambiente para a porta
ENV PORT=4000

# Expõe a porta que o backend irá usar
EXPOSE 4000

# Comando para iniciar o backend (que serve o frontend também)
CMD ["node", "server.js"]
