if Rails.env.test?
  CarrierWave.configure do |config|
    config.root = 'test/fixtures/attachments'
  end
end
