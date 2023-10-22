use axum::{Router, routing::get, Json};
use crate::schemas::out_schemas::TestStruct;

#[utoipa::path( get,  path = "/api/vi/external/test")]
#[axum_macros::debug_handler]
pub async fn test_router() -> Json<TestStruct> {
    Json(TestStruct{ string: "This is a test string!!".into() })
}

pub fn news_routers() -> Router<> {
    Router::new()
    .route("/test", get(test_router))
}