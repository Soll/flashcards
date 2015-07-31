FactoryGirl.define do

  factory :card do
    original_text "das"
    translated_text "the"
    review_date { Time.now }

    before(:create) do |card|
      card.review_date { 3.days.from_now }
    end
  end

end