# Use the official Caddy image as base
FROM caddy:2-alpine

ARG DB_MIGRATION=0
ENV DB_MIGRATION=${DB_MIGRATION}

# Copy the local Caddyfile to the container
COPY Caddyfile /etc/caddy/Caddyfile

# Copy the specified files
COPY package.json package-lock.json setupDatabase.js /app/

# Create necessary directories with proper permissions
RUN mkdir -p /data/caddy/locks \
    && mkdir -p /config/caddy \
    && addgroup -S caddy \
    && adduser -S -G caddy caddy \
    && chown -R caddy:caddy /etc/caddy \
    && chown -R caddy:caddy /data \
    && chown -R caddy:caddy /config \
    && chmod +x /usr/bin/caddy \
    && chown caddy:caddy /usr/bin/caddy \
    && chown -R caddy:caddy /app 

RUN if [ "$DB_MIGRATION" = "1" ]; then \
        echo "Running database migration..." && \
        apk add --no-cache nodejs npm && \
        cd /app && \
        npm install && \
        node setupDatabase.js; \
    else \
        echo "Skipping database migration."; \
    fi
    

# Expose the port specified in your Caddyfile (10000)
EXPOSE 10000

# Switch to non-root user
USER caddy

# Start Caddy with the configured Caddyfile
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile"]
