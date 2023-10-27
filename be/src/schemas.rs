pub mod out_schemas {
    use serde::Serialize;
    use utoipa::ToSchema;

    #[derive(Serialize, Debug, ToSchema)]
    pub struct News{
        pub (crate) title: String,
        pub (crate) body: String,
    }
}