class TextCompare < ActiveModel::Validator
  def validate(record)
    if record.original_text.mb_chars.downcase == record.translated_text.mb_chars.downcase
      record.errors[:translated_text] << "Must be not equal to original text!"
    end
  end
end