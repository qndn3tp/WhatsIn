use std::{env, sync::OnceLock};

use sqlx::{MySql, MySqlPool, Pool};

pub mod news;

pub fn connection_pool() -> &'static Pool<MySql> {
	static POOL: OnceLock<Pool<MySql>> = OnceLock::new();
	POOL.get_or_init(|| {
		std::thread::spawn(|| {
			#[tokio::main]
			async fn get_connection_pool() -> Pool<MySql> {
				let database_url = &env::var("DATABASE_URL").expect("DATABASE_URL must be set");
				MySqlPool::connect(database_url).await.unwrap()
			}
			get_connection_pool()
		})
		.join()
		.unwrap()
	})
}
