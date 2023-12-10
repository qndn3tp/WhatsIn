FROM messense/rust-musl-cross:x86_64-musl as builder

#Set the following value so we can build our codebase without live database connection
ENV SQLX_OFFLINE=true 

WORKDIR /app

COPY . .

RUN cargo build --bin web --release --target x86_64-unknown-linux-musl

# Create a new stage with a minimal image
FROM scratch
# COPY --from=builder /app/migrations /app/migrations
# COPY --from=builder /app/target/x86_64-unknown-linux-musl/release/web /app
ENV SQLX_OFFLINE=true 
