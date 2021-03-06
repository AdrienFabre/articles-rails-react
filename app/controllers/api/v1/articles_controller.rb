# frozen_string_literal: true

require 'rest-client'

module Api
  module V1
    class ArticlesController < ApplicationController
      ARTICLES_URL = 'https://s3-eu-west-1.amazonaws.com/olio-staging-images/developer/test-articles-v3.json'

      def index
        articles = pull_articles_data
        adjusted_articles = adjust_articles(articles)
        render json: adjusted_articles
      end

      def update
        updated_article = Article.find_or_create_by(guid: params[:id])
                                 .add_like
        render json: updated_article
      end

      private

      def pull_articles_data
        articles = RestClient.get ARTICLES_URL
        JSON.parse articles
      end

      def adjust_articles(articles)
        articles.map { |article| adjust_article(article) }
                .sort_by! { |article| article[:updated_at] }
                .reverse
      end

      def adjust_article(article)
        new_article = Article.find_or_initialize_by(guid: article['id'])
        new_article.complete_article(article)
      end
    end
  end
end
