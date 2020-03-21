require 'rails_helper'

RSpec.feature 'XSS', type: :system do
  given(:user) { create(:user, password: user_password) }
  given(:user_password) { 'Password001' }
  given!(:user_blog) { create(:blog, user: user) }
  given!(:other_blog) { create(:blog) }
  given(:user_measurement_tag) { build(:measurement_tag) }

  scenario '計測タグを作成し、ブログに埋め込まれていることを確認する' do
    visit new_session_path
    fill_in 'session_login_id', with: user.login_id
    fill_in 'session_password', with: user_password
    click_button 'Log in'

    click_link user.name
    click_link 'Measurement tag'
    fill_in 'measurement_tag_body', with: user_measurement_tag.body
    click_button 'Create Measurement tag'

    visit blog_path(user_blog)
    expect(page.html).to include(user_measurement_tag.body)

    visit blog_path(other_blog)
    expect(page.html).not_to include(user_measurement_tag.body)
  end
end
