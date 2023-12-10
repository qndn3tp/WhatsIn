use utoipa::OpenApi;

use crate::{schemas::out_schemas::News,
    news_route, enums::Category
};


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