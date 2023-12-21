#!/bin/bash

# Capture the current working directory
PWD=$(pwd)

# Stop and start Docker containers
docker compose down -v
docker compose up -d --wait

# Run the Rust HTTP server in the background
cd "$PWD/be" && cargo run --bin whats_in &

cd "$PWD/fe" && flutter run