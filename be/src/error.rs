use std::fmt::{self, Debug};

use axum::{response::IntoResponse, Json};
use reqwest::StatusCode;
use serde_json::json;

#[derive(Debug)]
pub enum BatchError {
	HttpRequestError,
	ParsingError(Box< dyn Debug>),
	DatabaseError(Box<dyn Debug>),
	SetUpFailed(Box< dyn Debug>),
	FileError(Box< dyn Debug>),
}

impl fmt::Display for BatchError {
	fn fmt(
		&self,
		f: &mut fmt::Formatter,
	) -> fmt::Result {
		match self {
			BatchError::HttpRequestError => write!(f, "Http request error occurred!"),
			BatchError::ParsingError(err) => write!(f, "Parsing Failed {:?}", err),
			BatchError::DatabaseError(err) => write!(f, "Database Error {:?}", err),
			BatchError::SetUpFailed(err) => write!(f, "Set up failed genergate new crawler {:?}", err),
			BatchError::FileError(err) => write!(f, "File error {:?}", err),
		}
	}
}


impl IntoResponse for BatchError {
	fn into_response(self) -> axum::response::Response {
		let (status, body) = match self {
			err @ BatchError::SetUpFailed(_) |
			err @ BatchError::FileError(_) |
			err @ BatchError::HttpRequestError |
			err @ BatchError::ParsingError(_) |
			err @ BatchError::DatabaseError(_) => (StatusCode::INTERNAL_SERVER_ERROR, format!("{:?}", err)),
		};
		let body = Json(json!(body));
		(status, body).into_response()
	}
}