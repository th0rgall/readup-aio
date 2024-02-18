# syntax=docker/dockerfile:1
# We work from `node:14.19.3-buster`, because that image is based on `buildpack-deps:buster`
# which is eventually also used as a base for the `api` Dockerfile.
FROM node:14.19.3-buster as build
ENV NODE_ENV development
ADD https://github.com/reallyreadit/web.git /app
WORKDIR /app
RUN npm ci
ENV NODE_TLS_REJECT_UNAUTHORIZED 0
RUN npx gulp build:prod:app

FROM node:14.19-alpine
COPY --from=build /app/package.json /app/
# Copy server code
#COPY --from=build /app/bin/prod/app/server /app/server
# Copy client code (static files)
# Templates are hard-coded to expect bundles at /app/bundles/bundler-{version}.js etc.
# Normally there is a separate static server, but we set the
# "serveStaticContent" and "contentRootPath" options
# COPY --from=build /app/bin/prod/app/client /app/client/app/bundles

# Copies server & client into /app
COPY --from=build /app/bin/prod/app /app
COPY --from=build /app/node_modules /app/node_modules
WORKDIR /app
RUN mkdir logs && touch logs/app.log
EXPOSE 5001
CMD ["node", "server/app/server/main.js"]

