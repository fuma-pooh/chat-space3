FactoryBot.define do
  factory :message do
    content {Faker::Lorem.sentence}
    image {File.open("#{Rails.root}/public/images/test_image.jpg")}
    # Rails.rootの意味は/Users/~~/アプリケーションまでのパスを取得しています
    user
    group
  end
end
