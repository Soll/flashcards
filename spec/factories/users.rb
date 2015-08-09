FactoryGirl.define do
  factory :user do
    email "user@mail.ru"
    crypted_password "$2a$10$Y7wUSADeOiZd94mIiOB4LOgNEljImLOY/YwQeUy275i6uIVkL9K8i"
    salt "B1D8NG63C3SiZjPk1TLv"
  end
end
