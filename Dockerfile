FROM node:12.2.0-alpine as build

WORKDIR /var/www/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install
# If you are building your code for production
# RUN npm ci --only=production
#

COPY . .

FROM node:12

# Uncomment envs below or export in docker-commpose.yml
#ENV PORT=3000
#ENV SCREENSHOT_URL="https://forecast7.com/en/50d0422d00/rzeszow/"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y imagemagick libnss3-dev libgbm-dev libgtk-3-0 libasound2 && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/app

COPY --from=build /var/www/app .

# Uncomment envs below or export in docker-compose.yml
#EXPOSE $PORT

CMD [ "node", "index.js" ]
