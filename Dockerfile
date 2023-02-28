FROM node:16-alpine AS staging
WORKDIR /usr/src/app
COPY . .
RUN npm install
RUN npm run build

FROM node:16-alpine AS production
WORKDIR /usr/src/app
COPY --from=staging /usr/src/app/build ./build
RUN yarn global add serve
EXPOSE 3000
CMD ["serve", "-s", "build", "-l", "3000"]
