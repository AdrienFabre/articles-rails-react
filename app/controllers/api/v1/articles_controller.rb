# frozen_string_literal: true

require 'rest-client'

module Api
  module V1
    class ArticlesController < ApplicationController
      # protect_from_forgery with: :exception
      ARTICLES_URL = 'https://s3-eu-west-1.amazonaws.com/olio-staging-images/developer/test-articles-v3.json'

      def index
        articles = pull_articles
        adjusted_articles = adjust_articles(articles)
        render json: adjusted_articles
      end

      def update
        Article.find(params[:id]).add_like
        updated_article = Article.find(params[:id])
        render json: updated_article
      end

      private

      def pull_articles
        articles = RestClient.get ARTICLES_URL
        JSON.parse articles
      end

      def adjust_articles(articles)
        articles.map { |article| adjust_article(article) }.sort_by! { |article| article[:updated_at] }.reverse
      end

      def adjust_article(article)
        new_article = if Article.exists?(article['id'])
                        Article.find(article['id'])
                      else
                        Article.new(guid: article['id'], likes: 0)
                      end
        new_article.complete_article(article)
      end
    end
  end
end
