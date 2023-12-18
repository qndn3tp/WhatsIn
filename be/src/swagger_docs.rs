use utoipa::OpenApi;

use crate::{enums::Category, news_route, schemas::out_schemas::News};

#[derive(OpenApi)]
#[openapi(
    paths(
        news_route::get_news,
    ),
    components(
        schemas(
            News,
            Category
        )
    ),
    tags(
        (name= "News api", description = "Api for news")
    )
)]
pub struct NewsDoc;
