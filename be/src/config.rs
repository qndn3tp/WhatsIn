use std::sync::OnceLock;

#[allow(dead_code)]
pub struct Config {
	pub(crate) lang: String,
	pub(crate) database_url: String,
	pub(crate) country: String,
	pub(crate) api_key: String,
	pub(crate) page_size: String,
}

impl Config {
	fn new() -> Config {
		dotenv::dotenv().ok();
		let lang = std::env::var("LANGUAGE").unwrap_or("ko".to_string());
		let database_url = std::env::var("DATABASE_URL").expect("There must be DATABASE URL!!");
		let country = std::env::var("COUNTRY").unwrap_or("kr".to_string());
		let api_key = std::env::var("API_KEY").expect("There must be an API_KEY in .env!");
		let page_size = std::env::var("PAGE_SIZE").unwrap_or("20".to_string());
		Config {
			lang,
			database_url,
			country,
			api_key,
			page_size,
		}
	}
}

pub fn config() -> &'static Config {
	static CONFIG: OnceLock<Config> = OnceLock::new();
	let config = CONFIG.get_or_init(|| Config::new());
	config
}
