RSpec.configure do |config|
  config.before(:each, type: :system) do |example|
    Capybara.session_name = example.metadata[:driver] || :default
    args = []
    args += %w(headless disable-gpu no-sandbox) if ENV["TEST_WITH_GUI_BROWSER"].blank?
    case example.metadata[:driver]
    when :mobile, :iphone
      args += [
        "window-size=375,667",
        "user-agent=Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1",
      ]
      configure_chrome_capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(chromeOptions: { args: args, w3c: false })
      driven_by :selenium, using: :chrome, options: { desired_capabilities: configure_chrome_capabilities }, screen_size: [375, 667]
    else
      args += ["window-size=1024,768"]
      configure_chrome_capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(chromeOptions: { args: args, w3c: false })
      driven_by :selenium, using: :chrome, options: { desired_capabilities: configure_chrome_capabilities }, screen_size: [1024, 768]
    end
  end
end
