require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'タイトルがなければ無効な状態であること' do
    post = Post.new(
      title: '',
      content: 'コンテンツ'
    )
    post.valid?
    expect(post.errors[:title]).to include("を入力してください")
  end

  it 'タイトルが32文字を超えていたら無効な状態であること' do
    post = Post.new(
      title: 'もし高校野球の女子マネージャーがドラッカーのマネジメントを読んだら',
      content: 'コンテンツ'
    )
    post.valid?
    expect(post.errors[:title]).to include("は32文字以内で入力してください")
  end

  it 'コンテンツがなければ無効な状態であること' do
    post = Post.new(
      title: 'test',
      content: ''
    )
    post.valid?
    expect(post.errors[:content]).to include("を入力してください")
  end
end
