CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: "AWS",
    aws_access_key_id: ENV["AWS_ACCESS_KEY"] #Rails.application.secrets.aws_access_key,
    aws_secret_access_key: ENV["AWS_SECRET_KEY"] #Rails.application.secrets.aws_secret_key,
    region: Rails.application.secrets.aws_region
  }
  config.fog_directory = "test74"
end
