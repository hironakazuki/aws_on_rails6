require 'rails_helper'

RSpec.describe Article, type: :model do
  it 'タイトルがなければ無効な状態であること' do
    article = Article.new(
      title: '',
      content: 'コンテンツ'
    )
    article.valid?
    expect(article.errors[:title]).to include("を入力してください")
  end

  it 'タイトルが64文字を超えていたら無効な状態であること' do
    article = Article.new(
      title: 'もし高校野球の女子マネージャーがドラッカーのマネジメントを読んだらもし高校野球の女子マネージャーがドラッカーのマネジメントを読んだら',
      content: 'コンテンツ'
    )
    article.valid?
    expect(article.errors[:title]).to include("は64文字以内で入力してください")
  end

  it '重複したタイトルなら無効な状態であること' do
    Article.create(
      title: 'もしドラ',
      content: 'コンテンツ'
    )
    article = Article.new(
      title: 'もしドラ',
      content: 'コンテンツ'
    )
    article.valid?
    expect(article.errors[:title]).to include("はすでに存在します")
  end
  
  it 'コンテンツがなければ無効な状態であること' do
    article = Article.new(
      title: 'test',
      content: ''
    )
    article.valid?
    expect(article.errors[:content]).to include("を入力してください")
  end
end
