# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Status requests' do
  let(:response_json) { JSON.parse(response.body) }

  describe 'GET /api/v1/articles' do
    it 'returns status 200' do
      get('/api/v1/articles')
      expect(response.status).to eql(200)
    end
  end

  describe 'PATCH /api/v1/articles/:id' do
    it 'returns a status 200 ' do
      Article.new(id: '123456', likes: 0).save
      patch('/api/v1/articles/123456')
      expect(response.status).to eql(200)
    end
  end
end
