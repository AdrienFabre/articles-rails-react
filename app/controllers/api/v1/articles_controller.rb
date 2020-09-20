require 'rest-client'

module Api 
  module V1
    class ArticlesController < ApplicationController
     
      protect_from_forgery with: :exception
      ARTICLES_URL = 'https://s3-eu-west-1.amazonaws.com/olio-staging-images/developer/test-articles-v3.json'

      def index
        pulled_articles = get_articles
        updated_articles = update_articles(pulled_articles)
        puts updated_articles
        render_success('Articles pulled successfully', updated_articles)
      end

      def update
        article = Article.find(params[:id]).add_like
        updated_article = Article.find(params[:id])
        render_success('Article updated successfully', updated_article)
      end

      private

      def get_articles
        articles = RestClient.get ARTICLES_URL
        articles_json = JSON.parse articles
      end

      def update_articles(articles)
        articles.map { | article | update_article(article) }.sort_by! { | article |  article[:updated_at]}.reverse
      end

      def update_article(article)
        if Article.exists?(article['id'])
          new_article = Article.find(article['id'])
        else
          new_article = Article.new(guid: article['id'], likes: 0)
          render_error(article) unless new_article.save! 
        end
        updated_article =  new_article.complete_article(article)
      end

      def render_success(message, data)
        render json: {status: 'OK', message: message, data: data}
      end

      def render_error
        render json: {status: 'ERROR', message: 'Article not saved', data: article.errors.full_messages}
      end

      def article_params 
        params.require(:article).permit(:id)
      end

    end
  end
end