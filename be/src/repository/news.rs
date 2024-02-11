use crate::{enums::NewsCategory, error::BatchError, schemas::out_schemas::News, config::config};

use super::connection_pool;

pub struct NewsRepo;

impl NewsRepo {
	pub async fn add(
		category: &NewsCategory,
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
                author,
                url_to_article,
                url_to_image
            )
            VALUES
            (
                ?,
                ?,
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
			news.url_to_article,
			news.url_to_image,
		)
		.execute(connection_pool())
		.await
		.map_err(|err| BatchError::DatabaseError(Box::new(err)))?;
		Ok(())
	}

	#[allow(non_snake_case)]
	pub async fn get(category: &NewsCategory) -> Result<Vec<News>, BatchError> {
		let rec = sqlx::query_as!(
			News,
			r#"
            SELECT
                title,
                description,
                published_at,
                author,
                url_to_article,
                url_to_image
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
	
	pub(crate) async fn remove_except_latest_news(category: &NewsCategory) -> Result<(), BatchError> {
		let conig = config();
		sqlx::query!(
			r#"
			DELETE FROM news 
			WHERE published_at NOT IN (
				SELECT published_at 
				FROM (
					SELECT published_at 
					FROM news 
					WHERE category = ?
					ORDER BY published_at DESC 
					LIMIT ?
				) AS subquery
			);
        	"#,
			category.to_string(),
			conig.news_per_page,
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

	use crate::{enums::NewsCategory, schemas::out_schemas::News};

	use super::NewsRepo;

	#[tokio::test]
	async fn test() {
		NewsRepo::remove_all().await.unwrap();

		'_given: {
			let author1 = Some("author1".to_string());
			let author2 = None;
			let vec_news = vec![
				News {
					title: "title2".to_string(),
					description: Some("description2".to_string()),
					published_at: Utc::now(),
					author: author1.clone(),
					url_to_article: Some("some url".to_string()),
					url_to_image: Some("some url".to_string()),
				},
				News {
					title: "title1".to_string(),
					description: Some("description1".to_string()),
					published_at: Utc::now() - Days::new(1),
					author: author2.clone(),
					url_to_article: Some("some url".to_string()),
					url_to_image: Some("some url".to_string()),
				},
			];
			'_when: {
				for category in [&NewsCategory::Business, &NewsCategory::Entertainment, &NewsCategory::General, &NewsCategory::Science] {
					let res = NewsRepo::get(category).await.unwrap();
					assert_eq!(res.len(), 0);
				}
				for news in vec_news {
					NewsRepo::add(&NewsCategory::Business, news).await.unwrap();
				}
				let res = NewsRepo::get(&NewsCategory::Business).await.unwrap();
				'_then: {
					assert_eq!(res.len(), 2);
					assert_eq!(res.iter().filter(|news| news.author == author1).collect::<Vec<&News>>().len(), 1);
					assert_eq!(res.iter().filter(|news| news.author == author2).collect::<Vec<&News>>().len(), 1);
				}
			}
		}
	}

	#[tokio::test]
	async fn remove() {
		NewsRepo::remove_all().await.unwrap();

		'_given: {
			let author1 = Some("author1".to_string());
			let news = News {
				title: "title2".to_string(),
				description: Some("description2".to_string()),
				published_at: Utc::now(),
				author: author1.clone(),
				url_to_article: Some("some url".to_string()),
				url_to_image: Some("some url".to_string()),
			};
			'_when: {
				NewsRepo::add(&NewsCategory::Business, news).await.unwrap();

				let res = NewsRepo::get(&NewsCategory::Business).await.unwrap();
				assert_eq!(res.len(), 1);

				NewsRepo::remove_all().await.unwrap();

				'_then: {
					for category in [&NewsCategory::Business, &NewsCategory::Entertainment, &NewsCategory::General, &NewsCategory::Science] {
						let res = NewsRepo::get(category).await.unwrap();
						assert_eq!(res.len(), 0);
					}
				}
			}
		}
	}
}
