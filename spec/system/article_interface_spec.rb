require 'rails_helper'

RSpec.describe "articlesInterfaceTest", type: :system, js: true do
  describe 'articleのUIをテストする' do
    describe '新規作成機能' do
      before {
          visit new_article_path
          fill_in 'タイトル', with: article_title
          fill_in_rich_text_area "article_content", with: article_content
          click_button '登録する'
        }
      context '有効なarticleを送信した場合' do
        let(:article_title) { '新規作成のテスト' }
        let(:article_content) { '新規作成の記事' }
        it "投稿できること" do
          expect(page).to have_content '新規作成のテスト'
          expect(page).to have_content '新規作成の記事'
        end
      end
      context '無効なarticleを送信した場合' do
        let(:article_title) { '' }
        let(:article_content) { '' }
        it "エラーとなること" do
          expect(page).to have_content "タイトルを入力してください"
          expect(page).to have_content "コンテンツを入力してください"
        end
      end
    end
    describe '更新機能' do
      let(:test_article) { FactoryBot.create(:article) }
      before {
        visit edit_article_path(test_article)
        fill_in 'タイトル', with: article_title
        fill_in_rich_text_area "article_content", with: article_content
        click_button '更新する'
      }
      context '有効なarticleを送信した場合' do
        let(:article_title) { '更新のテスト' }
        let(:article_content) { '更新の記事' }
        it "投稿できること" do
          expect(page).to have_content '更新のテスト'
          expect(page).to have_content '更新の記事'
        end
      end
      context '無効なarticleを送信した場合' do
        let(:article_title) { '' }
        let(:article_content) { '' }
        it "エラーとなること" do
          expect(page).to have_content "タイトルを入力してください"
          expect(page).to have_content "コンテンツを入力してください"
        end
      end
    end
    describe '削除機能' do
      let(:test_article) { FactoryBot.create(:article) }
      context 'confirmダイアログでOKを選択したとき' do
        it '正常に削除される' do
          visit article_path(test_article)
          click_link '削除'
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_content 'を削除しました。'
        end
      end
      context 'confirmダイアログでキャンセルを選択したとき' do
        it '削除されない' do
          visit article_path(test_article)
          click_link '削除'
          page.driver.browser.switch_to.alert.dismiss
          expect(page).to have_content 'テストタイトル'
        end
      end
    end
  end
end