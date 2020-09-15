require 'rest-client'

module Api 
  module V1
    class ArticlesController < ApplicationController
      protect_from_forgery with: :null_session
      def index
        articles = RestClient.get 'https://s3-eu-west-1.amazonaws.com/olio-staging-images/developer/test-articles-v3.json'
        json = JSON.parse articles

        new_json = json.map do 
          | article | 
          if Article.exists?(article['id'])
            likes = Article.find(article['id']).likes
            article['likes'] = likes
          else  
            newArticle = Article.new(guid: article['id'], likes: 0)
            newArticle.save
            article['likes'] = 0
          end 

          modified_article = {
            id: article['id'], 
            title: article['title'],
            description: article['description'],
            likes: article['likes'],
            image: article['images'][0]['files']['medium'],
            section: article['section'],
            user: article['user']['first_name'],
            last_listed: article['last_listed']
          }
        end
        render json: new_json
      end

      # def show
      #   article = Article.find(params[:id])
      #   render json: article
      # end

      def update
        article = Article.find(params[:id])
        article.likes += 1
        article.update({likes: article.likes})
        updated_article = Article.find(params[:id])
        render json: updated_article
      end

      private

      def article_params 
        params.require(:article).permit(:id)
      end
    end
  end
end