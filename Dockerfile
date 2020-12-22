# Everything bellow the From command will be know as builder
FROM node:13.12.0-alpine as builder
WORKDIR /app
COPY package.json .
# this suposedily solves the deployment issue with AWS
RUN npm config set unsafe-perm true
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# Expose port 80 to let other devs know how we managing netwrork trafic 
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
# The default nginx comman will start the container
