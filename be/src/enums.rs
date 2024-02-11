use serde::{Deserialize, Serialize};
use utoipa::ToSchema;
#[derive(Debug, Clone, Serialize, Deserialize, ToSchema)]
#[serde(rename_all = "snake_case")]
pub enum NewsCategory {
	Business,
	Science,
	Entertainment,
	General,
	Health,
	Sports,
	Technology,
}

impl From<NewsCategory> for &str {
	fn from(value: NewsCategory) -> Self {
		match value {
			NewsCategory::Business => "business",
			NewsCategory::Science => "science",
			NewsCategory::Entertainment => "entertainment",
			NewsCategory::General => "general",
			NewsCategory::Health => "health",
			NewsCategory::Sports => "sports",
			NewsCategory::Technology => "technology",
		}
	}
}

impl NewsCategory {
	pub(crate) fn to_string(&self) -> String {
		<NewsCategory as Into<&str>>::into(self.to_owned()).to_string()
	}

	pub(crate) fn next(&self) -> Option<Self> {
		match self {
			NewsCategory::Business => Some(NewsCategory::Science),
			NewsCategory::Science => Some(NewsCategory::Entertainment),
			NewsCategory::Entertainment => Some(NewsCategory::General),
			NewsCategory::General => Some(NewsCategory::Health),
			NewsCategory::Health => Some(NewsCategory::Sports),
			NewsCategory::Sports => Some(NewsCategory::Technology),
			NewsCategory::Technology => None,
		}
	}
}
