use crate::{enums::Category, error::BatchError, schemas::out_schemas::News};

use super::connection_pool;

pub struct NewsRepo;

impl NewsRepo {
	pub async fn add(
		category: &Category,
		news: News,
	) -> Result<(), BatchError> {
		sqlx::query!(
			"
            Insert INTO news
            (
                title,
                category,
                description,
                published_at,
                author
            )
            VALUES
            (
                ?,
                ?,
                ?,
                ?,
                ?
            )
        ",
			news.title,
			category.to_string(),
			news.description,
			news.published_at,
			news.author,
		)
		.execute(connection_pool())
		.await
		.map_err(|err| BatchError::DatabaseError(Box::new(err)))?;
		Ok(())
	}

	#[allow(non_snake_case)]
	pub async fn get(category: &Category) -> Result<Vec<News>, BatchError> {
		let rec = sqlx::query_as!(
			News,
			r#"
            SELECT
                title,
                description,
                published_at,
                author
            FROM news
            WHERE category = ?
        "#,
			category.to_string()
		)
		.fetch_all(connection_pool())
		.await
		.map_err(|err| BatchError::DatabaseError(Box::new(err)))?;
		Ok(rec.into_iter().collect::<Vec<News>>())
	}

	pub(crate) async fn remove(category: &Category) -> Result<(), BatchError> {
		sqlx::query!(
			r#"
            DELETE FROM news
            WHERE category = ?
        "#,
        category.to_string()
		)
		.execute(connection_pool())
		.await
		.map_err(|err| BatchError::DatabaseError(Box::new(err)))?;

		Ok(())
	}
    
    #[cfg(test)]
	pub(crate) async fn remove_all() -> Result<(), BatchError> {
		sqlx::query!(
			r#"
            TRUNCATE TABLE news
        "#
		)
		.execute(connection_pool())
		.await
		.map_err(|err| BatchError::DatabaseError(Box::new(err)))?;

		Ok(())
	}
}

#[cfg(test)]
mod test {
	use chrono::{Days, Utc};

	use crate::{schemas::out_schemas::News, enums::Category};

use super::NewsRepo;

	#[tokio::test]
	async fn test() {
        NewsRepo::remove_all().await.unwrap();

        '_given:{
            let author1 = Some("author1".to_string());
            let author2 = None;
            let vec_news = vec![
                News {
                    title: "title2".to_string(),
                    description: Some("description2".to_string()),
                    published_at: Utc::now(),
                    author: author1.clone(),
                },
                News {
                    title: "title1".to_string(),
                    description: Some("description1".to_string()),
                    published_at: Utc::now() - Days::new(1),
                    author: author2.clone(),
                },
            ];
            '_when:{
                for category in [&Category::Business, &Category::Entertainment, &Category::General, &Category::Science]{
                    let res = NewsRepo::get(category).await.unwrap();
                    assert_eq!(res.len(), 0);
                }
                for news in vec_news{
                    NewsRepo::add(&Category::Business, news).await.unwrap();
                }
                let res = NewsRepo::get(&Category::Business).await.unwrap();
                '_then:{
                    assert_eq!(res.len(), 2);
                    assert_eq!(res.iter().filter(|news| news.author == author1).collect::<Vec<&News>>().len(),
                        1
                    );
                    assert_eq!(res.iter().filter(|news| news.author == author2).collect::<Vec<&News>>().len(),
                        1
                    );
                }
            }    
        }
	}

	#[tokio::test]
	async fn remove() {
        NewsRepo::remove_all().await.unwrap();

        '_given:{
            let author1 = Some("author1".to_string());
            let news = 
                News {
                    title: "title2".to_string(),
                    description: Some("description2".to_string()),
                    published_at: Utc::now(),
                    author: author1.clone(),
                };
            '_when:{
                NewsRepo::add(&Category::Business, news).await.unwrap();

                let res = NewsRepo::get(&Category::Business).await.unwrap();
                assert_eq!(res.len(), 1);

                NewsRepo::remove_all().await.unwrap();

                '_then:{
                    for category in [&Category::Business, &Category::Entertainment, &Category::General, &Category::Science]{
                        let res = NewsRepo::get(category).await.unwrap();
                        assert_eq!(res.len(), 0);
                    }
                }
            }    
        }
    }
}
