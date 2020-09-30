#build phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

#run phase - use new base image (Nginx) and copy result of build phase into it
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html

#nginx starts up automatically - don't need a command to start it