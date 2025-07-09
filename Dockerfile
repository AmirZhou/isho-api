# Stage 1: Base setup and dependency installation
FROM node:18-alpine AS base
RUN corepack enable pnpm && corepack install -g pnpm@10.5.2
RUN apk add --no-cache libc6-compat

# Stage 2: Builder Stage, Dependency and build
FROM base AS builder
ENV NODE_ENV=production
WORKDIR /app

## copy manifests and install dependencies
COPY package.json pnpm-lock.yaml ./

RUN pnpm install

# copy src codes
COPY . .

RUN pnpm run build

EXPOSE 3000
CMD ["node", "dist/main.js"]




