# Estágio de Build
FROM node:20-alpine AS build

# Define o diretório de trabalho no container
WORKDIR /app

# Copia os arquivos de dependência do backend para cachear a camada
COPY ./backend/package.json ./backend/package-lock.json ./backend/

# Define o diretório de trabalho para a pasta do backend
WORKDIR /app/backend

# Instala as dependências do projeto
RUN npm install

# Copia o resto dos arquivos do backend
COPY ./backend .

# Comando de execução
# Expõe a porta que a sua aplicação irá usar.
EXPOSE 4000

# Inicia a sua aplicação Node.js
CMD ["node", "server.js"]
