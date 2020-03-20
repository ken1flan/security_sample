VCR.configure do |config|
  config.cassette_library_dir = 'fixtures/vcr_cassetes'
  config.hook_into :webmock
  config.ignore_localhost = true
end
