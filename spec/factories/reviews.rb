FactoryGirl.define do
  factory :review do
    association :user, factory: :user
    association :product, factory: :product

    sequence(:body) { |b| Faker::Hipster.sentence(3) }
    rating { [1,2,3,4,5].sample }
  end
end
