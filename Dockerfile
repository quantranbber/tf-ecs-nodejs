FROM node:18-alpine3.17

WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the container
COPY yarn.lock ./

# Install application dependencies
RUN yarn install

# Bundle app source
COPY . .

# Expose the port on which your Node.js app will run
EXPOSE 3000

# Define the command to run your Node.js app
CMD [ "yarn", "start" ]