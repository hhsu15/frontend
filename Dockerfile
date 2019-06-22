# The sole purpose of this is to be able to generate the build folder
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build  # create a folder, /app/build/

# create a second base image
FROM nginx
# now copy things from the "builder" phase
# the destination here is nginx specific, it's built to serve your contents with that directory
COPY --from=builder /app/build /usr/share/nginx/html

# that's it! nginx takes care of the start so we don't need to specify the command to start nginx
