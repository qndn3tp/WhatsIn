FROM messense/rust-musl-cross:x86_64-musl as builder

#Set the following value so we can build our codebase without live database connection
ENV SQLX_OFFLINE=true 

WORKDIR /app

COPY . .

# Before running this, make sure sqlx-data.json exists!
RUN cargo build --bin web --release --target x86_64-unknown-linux-musl

# Create a new stage with a minimal image
FROM alpine:latest
COPY --from=builder /app/migrations /app/migrations
COPY --from=builder /app/target/x86_64-unknown-linux-musl/release/web /app
ENV SQLX_OFFLINE=true 
RUN apk add bash



ENTRYPOINT [ "/app/web" ]
EXPOSE 80
