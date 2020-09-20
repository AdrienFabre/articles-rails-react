require 'rails_helper'

RSpec.describe 'Status requests' do 

  let(:response_json) { JSON.parse(response.body) }

  describe 'GET /api/v1/articles' do
    it 'returns a status message' do
      get('/api/v1/articles')
      expect(response.status).to eql(200)
      expect(response_json['status']).to eql('OK')
    end

    it 'returns the articles' do
      get('/api/v1/articles')
      expect(response_json['message']).to eql('Articles pulled successfully')
      response_json['data'].each do |article|
        expect(article.keys).to contain_exactly('id', 'likes', 'title', 'description', 'image', 'location', 'user','user_avatar', 'last_listed')
      end
    end
  end

  describe 'PATCH /api/v1/articles/:id' do
    it 'returns a status message' do
      get('/api/v1/articles')
      expect(response.status).to eql(200)
      expect(response_json['status']).to eql('OK')
    end
end

# RSpec.describe 'Articles requests' do 
#   describe 'GET /api/v1/articles' do
#     it 'returns a status message' do
#       get('/api/v1/articles')
#       expect(response_json['message']).to eql('Articles pulled successfully')
#       response_json['data'].each do |article|
#         expect(article.keys).to contain_exactly('id', 'likes', 'title', 'description', 'image', 'location', 'user','user_avatar', 'last_listed')
#       end
      
#     end
#   end
# end

 