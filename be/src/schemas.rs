use serde::Deserialize;

use crate::enums::Category;

pub mod out_schemas {
	use chrono::{DateTime, Utc};
	use serde::{Deserialize, Serialize};
	use utoipa::ToSchema;

	#[allow(non_snake_case)]
	#[derive(Serialize, Deserialize, Debug, ToSchema)]
	pub struct News {
		pub(crate) title: String,
		pub(crate) description: Option<String>,
		#[serde(rename(deserialize = "publishedAt"))]
		pub(crate) published_at: DateTime<Utc>,
		pub(crate) author: Option<String>,
	}
}

pub mod in_schemas {
	use serde::Deserialize;
	use utoipa::ToSchema;

	use super::out_schemas::News;
	#[derive(Deserialize, Debug, ToSchema)]
	pub struct ResponseNews {
		pub(crate) status: String,
		pub(crate) articles: Vec<News>,
	}
}

#[derive(Debug, Deserialize)]
pub struct QueryParams {
	pub(crate) category: Category,
}
