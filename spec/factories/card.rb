FactoryGirl.define do

  factory :card do
    original_text "das"
    translated_text "the"
    review_date "2015-08-02 07:49:45.810242"

    before(:create) do |card|
      card.review_date { 3.days.from_now }
    end
  end

end