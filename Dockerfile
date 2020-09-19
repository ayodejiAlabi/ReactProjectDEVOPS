# Use an existing docker image as base
FROM node:alpine 
#Specify Work Directory to copy files to in the docker container
WORKDIR /usr/applications/reactfrontendjs
# Copy only selected the file in the current directory to the docker container
COPY ./package.json ./
# Download and install a dependency
RUN npm install
# Copy all the files in the current directory to the docker container
COPY ./ ./
# build the application directory for production
RUN npm run build

#2nd step to create production enviroment using nginx as web server
# Use an existing docker image as base
FROM nginx
#Expose port inside docker container
EXPOSE 80
#copy build file from builder container to the production enviroment
COPY --from=0 /usr/applications/reactfrontendjs/build /usr/share/nginx/html
