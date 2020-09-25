# frozen_string_literal: true

class Article < ApplicationRecord
  validates :id, presence: true

  def complete_article(article)
    {
      id: id, likes: likes || 0, title: article['title'],
      description: article['description'],
      image: article['images'][0]['files']['medium'],
      location: article['location']['town'],
      user: article['user']['first_name'],
      user_avatar: article['user']['current_avatar']['small'],
      updated_at: article['updated_at']
    }
  end

  def add_like
    updated_likes = likes ? self.likes += 1 : 1
    update({ likes: updated_likes })
    self
  end
end
