# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Articles Controller' do
  let(:response_json) { JSON.parse(response.body) }

  describe 'GET /api/v1/articles' do
    it 'returns the correct articles keys with new data' do
      get('/api/v1/articles')
      response_json.each do |article|
        expect(article.keys)
          .to contain_exactly('id',
                              'likes', 'title', 'description',
                              'image', 'location', 'user',
                              'user_avatar', 'updated_at')
      end
    end

    it 'returns the correct articles keys with saved data' do
      Article.new(id: '1138391', likes: 0).save
      get('/api/v1/articles')
      response_json.each do |article|
        expect(article.keys)
          .to contain_exactly('id',
                              'likes', 'title', 'description',
                              'image', 'location', 'user',
                              'user_avatar', 'updated_at')
      end
    end
  end

  describe 'PATCH /api/v1/articles/:id' do
    it 'returns the updated article' do
      Article.new(id: '123456', likes: 0).save
      patch('/api/v1/articles/123456')
      expect(response_json['likes']).to eql(1)
    end

    it 'raises error if not existing id' do
      Article.new(id: '123456', likes: 0).save
      expect { patch('/api/v1/articles/111111') }.to raise_error(
        "Couldn't find Article with 'guid'=111111"
      )
    end
  end
end
