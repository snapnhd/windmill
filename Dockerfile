# Use the official Caddy image as base
FROM caddy:2-alpine

# Copy the local Caddyfile to the container
COPY Caddyfile /etc/caddy/Caddyfile

# Create necessary directories with proper permissions
RUN mkdir -p /data/caddy/locks \
    && mkdir -p /config/caddy \
    && addgroup -S caddy \
    && adduser -S -G caddy caddy \
    && chown -R caddy:caddy /etc/caddy \
    && chown -R caddy:caddy /data \
    && chown -R caddy:caddy /config \
    && chmod +x /usr/bin/caddy \
    && chown caddy:caddy /usr/bin/caddy

# Expose the port specified in your Caddyfile (10000)
EXPOSE 10000

# Switch to non-root user
USER caddy

# Start Caddy with the configured Caddyfile
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile"]
