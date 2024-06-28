use actix_web::{App, HttpResponse, HttpServer, Responder, web};
use actix_web::http::header::ContentType;

#[actix_web::main]
async fn main() -> std::io::Result<()> {

    HttpServer::new(|| {
        App::new()
            .route("/health-check", web::get().to(health_check))
    }).bind(("0.0.0.0", 8080))?.run().await
}

async fn health_check() -> impl Responder {
    HttpResponse::Ok().content_type(ContentType::html()).body("OK, Hello world!!!".to_string())
}
