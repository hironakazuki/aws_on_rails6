require 'rails_helper'

RSpec.describe "PostsInterfaceTest", type: :system, js: true do
  describe 'postのUIをテストする' do
    context '有効なpostを送信した場合' do
      before {
        visit new_post_path
        fill_in_rich_text_area "post_content", with: "test-content"
        click_button 'Create Post'
      }
      it "投稿できること" do
        expect(page).to have_content 'test-content'
      end
    end
  end
end