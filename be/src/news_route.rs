use axum::{Router, routing::get, Json, extract::Query};
use crate::{repository::news::NewsRepo, error::BatchError, schemas::QueryParams};
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
#[axum_macros::debug_handler]
pub async fn get_news(
    Query(query): Query<QueryParams>
) -> Result<Json<Value>, BatchError> {
    let json = json!(NewsRepo::get(&query.category).await?);
    Ok(Json(json))
}

pub fn news_routers() -> Router<> {
    Router::new()
    .route("/news", get(get_news))
}
