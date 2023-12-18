use std::{
	fs::File,
	io::{BufReader, Write},
};

use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};
use serde_json::Value;

use crate::{domain::news::NewsRequest, enums::Category, error::BatchError, repository::news::NewsRepo};

#[derive(Deserialize, Serialize)]
pub struct Crawler {
	pub(crate) last_crawl_dt: DateTime<Utc>,
}

impl Crawler {
	pub fn new() -> Self {
		Crawler { last_crawl_dt: Utc::now() }
	}

	pub fn set_up() -> Result<Self, BatchError> {
		let file = File::open("./schedule.json").map_err(|err| {
			println!("Error occurred while opening the schedule.json!");
			BatchError::SetUpFailed(Box::new(err))
		})?;
		let f_reader = BufReader::new(file);
		let schedule_json: Value = serde_json::from_reader(f_reader).map_err(|err| BatchError::SetUpFailed(Box::new(err)))?;

		serde_json::from_value::<Crawler>(schedule_json).map_err(|err| BatchError::SetUpFailed(Box::new(err)))
	}

	// return Duration
	pub async fn run(&self) -> Result<(), BatchError> {
		let mut category = Category::Business;
		println!("Start crawling..");
		loop {
			let request = NewsRequest::new(category.clone());
			let news_vec = request.crawl().await?;
			// TODO Bulk insert
			// TODO with this code, There can be a gap between crawling
			for news in news_vec {
				NewsRepo::remove(&category).await?;

				NewsRepo::add(&category, news).await?;
			}
			category = if let Some(next) = category.next() {
				next
			} else {
				break;
			};
		}
		self.update_schedule()?;
		Ok(())
	}

	fn update_schedule(&self) -> Result<(), BatchError> {
		let json_data = serde_json::to_string(self).map_err(|err| BatchError::ParsingError(Box::new(err)))?;

		let mut file = File::create("./schedule.json").map_err(|err| BatchError::FileError(Box::new(err)))?;
		file.write_all(json_data.as_bytes()).map_err(|err| BatchError::FileError(Box::new(err)))?;

		Ok(())
	}
}
