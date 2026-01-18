  FROM node:latest
  LABEL description="for build book-dyna."
  WORKDIR /docs
  RUN npm install -g docsify-cli@latest
  COPY ./docs .
  EXPOSE 3000/tcp
  ENTRYPOINT docsify serve .
