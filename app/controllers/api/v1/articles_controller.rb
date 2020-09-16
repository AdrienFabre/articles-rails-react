require 'rest-client'

module Api 
  module V1
    class ArticlesController < ApplicationController
     
      protect_from_forgery with: :null_session
      ARTICLES_URL = 'https://s3-eu-west-1.amazonaws.com/olio-staging-images/developer/test-articles-v3.json'

      def index
        articles_json = get_articles
        updated_articles_json = update_articles(articles_json)
        render json: updated_articles_json
      end

      def update
        article = Article.find(params[:id])
        updated_likes = article.likes += 1
        article.update({likes: updated_likes})
        updated_article = Article.find(params[:id])
        render json: updated_article
      end

      private

      def article_params 
        params.require(:article).permit(:id)
      end

      def get_articles
        articles = RestClient.get ARTICLES_URL
        articles_json = JSON.parse articles
      end

      def update_articles(articles_json)
        updated_articles_json = articles_json.map do 
          | article | 
          updated_article = update_article(article)
        end
        updated_articles_json
      end

      def update_article(article)
        likes = 0 
        if Article.exists?(article['id'])
          likes = Article.find(article['id']).likes
        else  
          newArticle = Article.new(guid: article['id'], likes: 0)
          unless newArticle.save
            return_error
          end 
        end
        updated_article = extract_necessary_keys(article, likes)
      end

      def extract_necessary_keys(article, likes)
        {
          id: article['id'], 
          title: article['title'],
          description: article['description'],
          likes: likes,
          image: article['images'][0]['files']['medium'],
          user: article['user']['first_name'],
          last_listed: article['last_listed']
        }
      end

      def return_error
        render json: {status: 'ERROR', message: 'Article not saved', data: data.article.error}
      end

    end
  end
end