use serde::{Serialize, Deserialize};
use utoipa::ToSchema;
// TODO snake_case
#[derive(Debug, Clone, Serialize, Deserialize, ToSchema)]
#[serde(rename_all = "snake_case")]
pub enum Category {
	Business,
	Science,
	Entertainment,
	General,
}

impl From<Category> for &str {
	fn from(value: Category) -> Self {
		match value {
			Category::Business => "business",
			Category::Science => "science",
			Category::Entertainment => "entertainment",
			Category::General => "general",
		}
	}
}

impl Category {
	pub(crate) fn to_string(&self) -> String {
		match self {
			Category::Business => "buisiness",
			Category::Science => "science",
			Category::Entertainment => "entertainment",
			Category::General => "general",
		}
		.to_string()
	}

	pub(crate) fn next(&self) -> Option<Self>{
		match self{
		Category::Business => Some(Category::Science),
		Category::Science => Some(Category::Entertainment),
		Category::Entertainment => Some(Category::General),
		Category::General => None,
	}
	}
}
