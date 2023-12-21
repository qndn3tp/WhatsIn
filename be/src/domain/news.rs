use reqwest::Client;

use crate::{
	config::config,
	enums::Category,
	error::BatchError,
	schemas::{in_schemas::ResponseNews, out_schemas::News},
};

#[derive(Debug)]
pub struct NewsRequest<'a> {
	pub(crate) api_key: &'a str,
	pub(crate) category: Category,
	pub(crate) page_size: &'a str,
}

impl<'a> NewsRequest<'a> {
	pub fn new(category: Category) -> Self {
		let config = config();
		NewsRequest {
			api_key: &config.api_key,
			category,
			page_size: &config.page_size,
		}
	}

	pub async fn crawl(&self) -> Result<Vec<News>, BatchError> {
		// Create a reqwest client
		let config = config();
		let client = Client::new();
		// Create a reqwest request builder with custom headers
		// * test for api key
		let response = client
			.get("https://newsapi.org/v2/top-headlines")
			.query(&[
				("apiKey", self.api_key),
				("country", &config.country),
				("category", self.category.clone().into()),
				("page_size", self.page_size),
				("size", "1"),
			])
			.header(
				"User-Agent",
				"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36",
			)
			.send()
			.await
			.map_err(|_| BatchError::HttpRequestError)?;

		let response = serde_json::from_value::<ResponseNews>(response.json().await.unwrap()).map_err(|err| BatchError::ParsingError(Box::new(err)))?;

		match response.status.as_str() {
			"ok" => Ok(response.articles),
			_ => Err(BatchError::HttpRequestError),
		}
	}
}

#[cfg(test)]
pub mod test {
	use crate::{domain::news::NewsRequest, enums::Category};

	#[tokio::test]
	async fn test_business_crawl() {
		let news_request = NewsRequest::new(Category::Business);
		news_request.crawl().await.unwrap();
	}

	#[tokio::test]
	async fn test_science_crawl() {
		let news_request = NewsRequest::new(Category::Science);
		news_request.crawl().await.unwrap();
	}

	#[tokio::test]
	async fn test_entertainment_crawl() {
		let news_request = NewsRequest::new(Category::Entertainment);
		news_request.crawl().await.unwrap();
	}

	#[tokio::test]
	async fn test_general_crawl() {
		let news_request = NewsRequest::new(Category::General);
		news_request.crawl().await.unwrap();
	}
}
