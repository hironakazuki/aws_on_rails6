FactoryBot.define do
  factory :post do
    sequence(:title) {|n| "テストタイトル_#{n}"}
    sequence(:content) {|n| "テストコンテンツ_#{n}"}
  end
end