## WhatsIn
We offer you the most recent and noteworthy news on a daily basis!
![WhatsIn_poster](https://github.com/qndn3tp/WhatsIn/assets/84118129/2d855714-aa86-4347-a096-b98d06a0b558)


---
## Initial Setup
Once you've configured `.env` file, follow follow these steps to set up the environment.

Install rustup
```sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Install the `sqlx-cli` tool using the following command:
```sh
   cargo install sqlx-cli
```

You can compose component with 
```sh
docker-compose up -d --wait
```

And for schema migration, you have to run the following command:
```sh
make upgrade
```

Intuitively, for downgrade of your schema run:
```sh
make downgrade
```

# Testing API for FE

## Run web server
Assuming you are currently in the "be" directory, proceed to start the server by running:
```sh
cargo run
```
