require 'rails_helper'

RSpec.describe "PostsInterfaceTest", type: :system, js: true do
  describe 'postのUIをテストする' do
    describe '新規作成機能' do
      before {
          visit new_post_path
          fill_in 'タイトル', with: post_title
          fill_in_rich_text_area "post_content", with: post_content
          click_button '登録する'
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
          expect(page).to have_content "タイトルを入力してください"
          expect(page).to have_content "コンテンツを入力してください"
        end
      end
    end
    describe '更新機能' do
      let(:test_post) { FactoryBot.create(:post) }
      before {
        visit edit_post_path(test_post)
        fill_in 'タイトル', with: post_title
        fill_in_rich_text_area "post_content", with: post_content
        click_button '更新する'
      }
      context '有効なpostを送信した場合' do
        let(:post_title) { '更新のテスト' }
        let(:post_content) { '更新の記事' }
        it "投稿できること" do
          expect(page).to have_content '更新のテスト'
          expect(page).to have_content '更新の記事'
        end
      end
      context '無効なpostを送信した場合' do
        let(:post_title) { '' }
        let(:post_content) { '' }
        it "エラーとなること" do
          expect(page).to have_content "タイトルを入力してください"
          expect(page).to have_content "コンテンツを入力してください"
        end
      end
    end
    describe '削除機能' do
      let(:test_post) { FactoryBot.create(:post) }
      context 'confirmダイアログでOKを選択したとき' do
        it '正常に削除される' do
          visit post_path(test_post)
          click_link 'Destroy'
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_content 'Post was successfully destroyed.'
        end
      end
      context 'confirmダイアログでキャンセルを選択したとき' do
        it '削除されない' do
          visit post_path(test_post)
          click_link 'Destroy'
          page.driver.browser.switch_to.alert.dismiss
          expect(page).to have_content 'テストタイトル'
        end
      end
    end
  end
end