require 'rails_helper'

RSpec.feature 'Tops', type: :system do
  scenario 'トップページを訪れる' do
    visit root_path

    expect(page).to have_text "Security sample is a blog system has many security holes. Let's sign up, and enjoy security holes!"
  end
end
