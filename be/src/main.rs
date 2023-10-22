mod news_route;
mod schemas;

use std::{net::SocketAddr, env, str::FromStr};

use axum::Router;

use crate::news_route::news_routers;

#[tokio::main]
async fn main() {
	println!("Environment Variable Is Being Set...");
	dotenv::dotenv().ok();
	// TODO compose connection_pool with PgPool
	// sqlx::migrate!("./migrations")
	// 	.run(connection_pool())
	// 	.await
	// 	.expect("Running Migration Script Failed!");

	let app: Router =  Router::new()
	.nest_service("/api/vi/external", news_routers());
	
	println!("Start WhatsIn Server...");
	axum::Server::bind(&SocketAddr::from_str(&env::var("SERVER_IP_PORT").unwrap_or("0.0.0.0:8000".into())).unwrap())
		.serve(app.into_make_service())
		.await
		.unwrap();
}
