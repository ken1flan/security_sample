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
end
