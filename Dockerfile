# ----------------------------------------
# Etapa 1: Build do frontend
# ----------------------------------------
FROM node:20 AS frontend-builder

WORKDIR /app/frontend

# Copia package.json e package-lock.json
COPY ./frontend/package*.json ./

# Instala dependências
RUN npm install --legacy-peer-deps

# Instala react-scripts globalmente para garantir execução
RUN npm install -g react-scripts

# Copia o restante do frontend
COPY ./frontend/ .

# Build do React
RUN npm run build

# ----------------------------------------
# Etapa 2: Build do backend
# ----------------------------------------
FROM node:20

WORKDIR /app/backend

# Copia package.json e package-lock.json do backend
COPY ./backend/package*.json ./

# Instala dependências do backend
RUN npm install --legacy-peer-deps

# Copia os arquivos do backend
COPY ./backend/ .

# Copia build do frontend para backend
COPY --from=frontend-builder /app/frontend/build ./frontend/build

# Variável de ambiente para a porta
ENV PORT=4000

# Expõe porta
EXPOSE 4000

# Comando para iniciar backend
CMD ["node", "server.js"]
