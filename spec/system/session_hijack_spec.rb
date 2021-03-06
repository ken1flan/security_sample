require 'rails_helper'

RSpec.feature 'Session Hijack', type: :system do
  given!(:victim_user) { create(:user) }
  given(:victim_user_password) { 'Password001' }

  scenario 'セッションハイジャックする' do
    victim_session_id = nil

    in_browser(:victim) do
      visit root_path
      victim_session_id = cookie_value_from('_session_id')
    end

    in_browser(:cracker) do
      visit root_path
      add_cookie('_session_id', victim_session_id)
    end

    in_browser(:victim) do
      first("a[href='#{new_session_path}").click

      fill_in 'session_login_id', with: victim_user.login_id
      fill_in 'session_password', with: victim_user_password
      click_button 'Log in'

      expect(page).to have_text victim_user.name
    end

    in_browser(:cracker) do
      visit root_path
      expect(page).to have_text victim_user.name
    end
  end
end
