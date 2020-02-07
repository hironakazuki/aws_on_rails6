require 'rails_helper'

RSpec.describe "PostsInterfaceTest", type: :system, js: true do
  describe 'postのUIをテストする' do
    describe '新規作成機能' do
      before {
          visit new_post_path
          fill_in 'Title', with: post_title
          fill_in_rich_text_area "post_content", with: post_content
          click_button 'Create Post'
        }
      context '有効なpostを送信した場合' do
        let(:post_title) { '新規作成のテスト' }
        let(:post_content) { '新規作成の記事' }
        it "投稿できること" do
          expect(page).to have_content '新規作成のテスト'
          expect(page).to have_content '新規作成の記事'
        end
      end
      context '無効なpostを送信した場合' do
        let(:post_title) { '' }
        let(:post_content) { '' }
        it "エラーとなること" do
          expect(page).to have_content "Title can't be blank"
          expect(page).to have_content "Content can't be blank"
        end
      end
    end
  end
end