class StringCompare < ActiveModel::Validator
  def validate(record)
    return if record.original_text.blank? || record.translated_text.blank?

    if record.original_text.mb_chars.downcase == record.translated_text.mb_chars.downcase
      record.errors[:translated_text] << "Must not be equal to original text!"
    end
  end
end