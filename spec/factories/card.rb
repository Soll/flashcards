FactoryGirl.define do
  factory :card do
    original_text "das"
    translated_text "the"
    association :user, factory: :assoc_user
    association :category, factory: :assoc_cat
    review_date { Time.now }
  end

  factory :assoc_user, class: "User" do |f|
    f.email "user1@mail.ru"
    f.crypted_password "$2a$10$Y7wUSADeOiZd94mIiOB4LOgNEljImLOY/YwQeUy275i6uIVkL9K8i"
    f.salt "B1D8NG63C3SiZjPk1TLv"
  end

   factory :assoc_cat, class: "Category" do |f|
    f.name "das das das"
    f.active false
  end
end
