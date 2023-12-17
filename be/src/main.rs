mod config;
mod domain;
mod enums;
mod error;
mod news_route;
mod repository;
mod schemas;
mod crawler;
mod swagger_docs;

use std::{env, net::SocketAddr, str::FromStr, time::Duration};

use axum::Router;
use tokio::time;
use utoipa::OpenApi;
use utoipa_swagger_ui::SwaggerUi;

use crate::{news_route::news_routers, crawler::Crawler, swagger_docs::NewsDoc, config::config};

#[tokio::main]
async fn main() {
	dotenv::dotenv().ok();

	let config = config();
	let crawler = match Crawler::set_up() {
		Ok(crawler) => crawler,
		Err(err) => {
			println!("{:?}", err);
			Crawler::new()
		},
	};

	crawler.run().await.expect("Crawl failed!");
	tokio::spawn( async move {
		time::sleep(Duration::from_secs(config.crawling_duration)).await;
		crawler.run().await.unwrap();
	});

	let app: Router =  Router::new()
	.nest_service("/api/vi/external", news_routers());

	let swagger = Router::new().merge(SwaggerUi::new("/api/v1/external/docs")
	.url("/news/openapi.json", NewsDoc::openapi())
);

	println!("Start WhatsIn Server...");
	axum::Server::bind(&SocketAddr::from_str(&env::var("SERVER_IP_PORT").unwrap_or("0.0.0.0:8000".into())).unwrap())
		.serve(app.merge(swagger).into_make_service())
		.await
		.unwrap();
}
