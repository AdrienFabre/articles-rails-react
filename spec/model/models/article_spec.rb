# frozen_string_literal: true

require 'rails_helper'

full_article_data = JSON.parse(File.read(File.dirname(__FILE__) + '/api_mock_data.json'))

RSpec.describe Article do
  subject { described_class.new(id: 1_138_391, likes: 0) }

  describe 'validaton' do
    describe 'id' do
      it 'must be present' do
        expect(subject).to be_valid
        subject.id = nil
        expect(subject).to_not be_valid
      end
    end
    describe 'likes' do
      it 'must be present' do
        expect(subject).to be_valid
        subject.likes = nil
        expect(subject).to_not be_valid
      end
    end
  end

  describe '#complete_article' do
    it 'returns an object with necessary keys' do
      expect(subject.complete_article(full_article_data).keys).to contain_exactly(:id, :likes, :title, :description,
                                                                                  :image, :location, :user, :user_avatar,
                                                                                  :updated_at)
    end
  end

  describe '#add_like' do
    it 'returns an article with one more like' do
      subject.add_like
      expect(subject.likes).to eql(1)
    end
  end
end
