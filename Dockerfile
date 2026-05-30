FROM node:20-slim AS builder
WORKDIR /app
COPY package.json ./
RUN npm install
COPY index.ts ./
RUN npx tsc index.ts --target es2022 --module commonjs

FROM node:20-slim
WORKDIR /app
COPY --from=builder /app/package.json ./
COPY --from=builder /app/index.js ./
RUN npm install --omit=dev

EXPOSE 3000
CMD ["node", "index.js"]
