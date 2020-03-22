require 'rails_helper'

RSpec.feature 'Open Redirector', type: :system do
  given(:administrator) { create(:administrator, password: administrator_password) }
  given(:administrator_password) { 'Password001' }

  scenario 'クライアントへの誘導数をカウントする' do
    in_browser(:administrator) do
      visit admin.new_session_path
      fill_in 'session_login_id' , with: administrator.login_id
      fill_in 'session_password' , with: administrator_password
      click_button 'Log in'

      click_link 'Redirection logs'
      expect(page).not_to have_text('https://en.wikipedia.org/wiki/Cat')
    end

    in_browser(:user) do
      visit '/campaigns/cool_something'
      click_link 'Visit cool something site'

      find('h1', text: 'Cat')
      expect(current_url).to eq 'https://en.wikipedia.org/wiki/Cat'
    end

    in_browser(:administrator) do
      click_link 'Redirection logs'
      expect(page).to have_text('https://en.wikipedia.org/wiki/Cat')
    end
  end

  given(:cool_site_campaign_url) do
    html = File.read("#{Rails.root}/outside/redirector/cool_site_campaign.html")
    server = Capybara.current_session.server
    html.gsub!(/localhost:3000/, "#{server.host}:#{server.port}")
    out_filename = "#{Rails.root}/tmp/cool_site_campaign.html"
    File.write(out_filename, html)
    "file://#{out_filename}"
  end

  scenario 'クライアントからの誘導数をカウントする' do
    in_browser(:administrator) do
      visit admin.new_session_path
      fill_in 'session_login_id' , with: administrator.login_id
      fill_in 'session_password' , with: administrator_password
      click_button 'Log in'

      click_link 'Redirection logs'
      expect(page).not_to have_text(root_url)
    end

    in_browser(:user) do
      visit cool_site_campaign_url
      click_link 'Visit Security sample'

      find('h1', text: 'Security Sample')
      expect(current_url).to eq root_url
    end

    in_browser(:administrator) do
      click_link 'Redirection logs'
      expect(page).to have_text(root_url.gsub(%r{/$}, ''))
    end
  end

  given(:spam_site_campaign_url) do
    html = File.read("#{Rails.root}/outside/redirector/spam_site_campaign.html")
    server = Capybara.current_session.server
    html.gsub!(/localhost:3000/, "#{server.host}:#{server.port}")
    out_filename = "#{Rails.root}/tmp/spam_site_campaign.html"
    File.write(out_filename, html)
    "file://#{out_filename}"
  end

  scenario 'フィッシングサイト' do
    in_browser(:user) do
      visit spam_site_campaign_url
      click_link 'Sign up'

      find('h1', text: 'Spam (food)')
      expect(current_url).to eq 'https://en.wikipedia.org/wiki/Spam_(food)'
    end
  end
end
