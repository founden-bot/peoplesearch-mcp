# The stdio bridge in a container, for registries and clients that run MCP servers in Docker.
# Run: docker run -i --rm -e PEOPLESEARCH_API_KEY=sk_sift_... <image>
FROM node:22-alpine
WORKDIR /app
COPY package.json index.mjs ./
ENTRYPOINT ["node", "index.mjs"]
