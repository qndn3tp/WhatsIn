use axum::{Router, routing::get, Json};
use crate::schemas::out_schemas::News;

#[utoipa::path( get,  path = "/api/vi/external/test")]
#[axum_macros::debug_handler]
pub async fn news_router() -> Json<News> {
    Json(News{ 
        title: "Gun hae is idiot!!".to_string(), 
        body: "Reseach which proved Gun hae is idiot has been reported".to_string(),})
}

pub fn news_routers() -> Router<> {
    Router::new()
    .route("/test", get(news_router))
}