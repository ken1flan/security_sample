RSpec.configure do |config|
  config.before(:each, type: :system) do |example|
    Capybara.session_name = :default
    args = ['window-size=1024,768']
    args += %w[headless disable-gpu no-sandbox] if ENV['TEST_WITH_GUI_BROWSER'].blank?
    configure_chrome_capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(chromeOptions: { args: args, w3c: false })
    driven_by :selenium, using: :chrome, options: { desired_capabilities: configure_chrome_capabilities }, screen_size: [1024, 768]
  end
end

def in_browser(name)
  old_session = Capybara.session_name

  Capybara.session_name = name
  yield

  Capybara.session_name = old_session
end
