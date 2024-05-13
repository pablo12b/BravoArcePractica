# Utilizar la imagen oficial de Node.js como imagen base
FROM node:latest

# Establecer el directorio de trabajo en el contenedor para el backend
WORKDIR /usr/src/app/chat-backend

# Copiar el 'package.json' y 'package-lock.json' del backend
COPY chat-backend/package*.json ./


# Instalar las dependencias del backend
RUN npm install

# Copiar el resto del código fuente del backend
COPY chat-backend/ .

# Cambiar al directorio del frontend
WORKDIR /usr/src/app/BravoArce

# Instalar Angular CLI globalmente
RUN npm install -g @angular/cli

# Copiar el 'package.json' y 'package-lock.json' del frontend
COPY BravoArce/package*.json ./

# Instalar las dependencias del frontend
RUN npm install

# Copiar los archivos restantes del proyecto frontend
COPY BravoArce/ .

# Construir la aplicación Angular para producción
RUN ng build --configuration production

# Cambiar de nuevo al directorio del backend para la ejecución
WORKDIR /usr/src/app/chat-backend

# Exponer el puerto 3000 para el servidor Node.js y el puerto 80 para el servidor web
EXPOSE 3000 80

# Comando para ejecutar el servidor Node.js y servir la aplicación Angular
CMD ["sh", "-c", "node index.js & npx http-server /usr/src/app/BravoArce/dist/bravo-arce -p 80"]