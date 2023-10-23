pub mod out_schemas {
    use serde::Serialize;
    use utoipa::ToSchema;

    #[derive(Serialize, Debug, ToSchema)]
    pub struct TestStruct{
        pub (crate) string: String
    }
}