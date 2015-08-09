FactoryGirl.define do
  factory :card do
    original_text "das"
    translated_text "the"
    association :user, factory: :assoc_user
    review_date "2015-07-11 16:13:46.510735"
  end

  factory :assoc_user, class: "User" do |f|
    f.email "test1@mail.ru"
    f.crypted_password "$2a$10$Y7wUSADeOiZd94mIiOB4LOgNEljImLOY/YwQeUy275i6uIVkL9K8i"
  end
end
