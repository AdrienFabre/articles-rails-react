# frozen_string_literal: true

class Article < ApplicationRecord
  validates :id, presence: true
  validates :likes, presence: true

  def complete_article(article)
    {
      id: article['id'], likes: likes, title: article['title'],
      description: article['description'],
      image: article['images'][0]['files']['medium'],
      location: article['location']['town'],
      user: article['user']['first_name'],
      user_avatar: article['user']['current_avatar']['small'], updated_at: article['updated_at']
    }
  end

  def add_like
    updated_likes = self.likes += 1
    update({ likes: updated_likes })
  end
end
