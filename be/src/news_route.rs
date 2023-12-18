use crate::{error::BatchError, repository::news::NewsRepo, schemas::QueryParams};
use axum::{extract::Query, routing::get, Json, Router};
use serde_json::{json, Value};

#[utoipa::path(
    get,
    path = "/api/vi/external/news",
    params(
        ("category" = Category, Query, description = "cartegory enum")
    ),
    responses(
        (status = 200, description = "News", body = News),
        (status = 404, description = "Not Found"),
        (status = 500, description = "Internal Server Error")
    )
)]
pub async fn get_news(Query(query): Query<QueryParams>) -> Result<Json<Value>, BatchError> {
	let json = json!(NewsRepo::get(&query.category).await?);
	Ok(Json(json))
}

pub fn news_routers() -> Router {
	Router::new().route("/news", get(get_news))
}
