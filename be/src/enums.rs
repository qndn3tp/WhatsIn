use serde::{Deserialize, Serialize};
use utoipa::ToSchema;
#[derive(Debug, Clone, Serialize, Deserialize, ToSchema)]
#[serde(rename_all = "snake_case")]
pub enum Category {
	Business,
	Science,
	Entertainment,
	General,
	Health,
	Sports,
	Technology,
}

impl From<Category> for &str {
	fn from(value: Category) -> Self {
		match value {
			Category::Business => "business",
			Category::Science => "science",
			Category::Entertainment => "entertainment",
			Category::General => "general",
			Category::Health => "health",
			Category::Sports => "sports",
			Category::Technology => "technology",
		}
	}
}

impl Category {
	pub(crate) fn to_string(&self) -> String {
		<Category as Into<&str>>::into(self.to_owned()).to_string()
	}

	pub(crate) fn next(&self) -> Option<Self> {
		match self {
			Category::Business => Some(Category::Science),
			Category::Science => Some(Category::Entertainment),
			Category::Entertainment => Some(Category::General),
			Category::General => Some(Category::Health),
			Category::Health => Some(Category::Sports),
			Category::Sports => Some(Category::Technology),
			Category::Technology => None,
		}
	}
}
