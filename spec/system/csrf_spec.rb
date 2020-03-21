require 'rails_helper'

RSpec.feature 'CSRF', type: :system do
  given(:victim_user) { create(:user, password: victim_user_password) }
  given(:victim_user_password) { 'Password001' }
  given(:csrf_url) do
    html = File.read("#{Rails.root}/outside/csrf/index.html")
    server = Capybara.current_session.server
    html.gsub!(/localhost:3000/, "#{server.host}:#{server.port}")
    out_filename = "#{Rails.root}/tmp/csrf.html"
    File.write(out_filename, html)
    "file://#{out_filename}"
  end

  scenario 'CSRFを悪用されて見に覚えのない投稿をされる' do
    in_browser(:victim) do
      visit new_session_path
      fill_in 'session_login_id', with: victim_user.login_id
      fill_in 'session_password', with: victim_user_password
      click_button 'Log in'

      visit blogs_path
      within('table') do
        expect(page).not_to have_text 'hello'
        expect(page).not_to have_text victim_user.name
      end

      visit csrf_url

      visit blogs_path
      within('table') do
        expect(page).to have_text 'hello'
        expect(page).to have_text victim_user.name
      end
    end
  end
end
