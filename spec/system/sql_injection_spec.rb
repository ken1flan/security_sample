require 'rails_helper'

RSpec.feature 'SQL Injection', type: :system do
  given(:keyword) { 'cat' }
  given!(:published_blog_with_keyword_in_title) { create(:blog, title: "title #{keyword}1", status: :published) }
  given!(:draft_blog_with_keyword_in_title) { create(:blog, title: "title #{keyword}2", status: :draft) }
  given!(:published_blog_with_keyword_in_body) { create(:blog, body: "body with #{keyword}1", status: :published) }
  given!(:draft_blog_with_keyword_in_body) { create(:blog, body: "body with #{keyword}2", status: :draft) }
  given!(:published_blog_without_keyword) { create(:blog, status: :published) }
  given!(:draft_blog_without_keyword) { create(:blog, status: :draft) }
  given(:sql_injection_keyword) { '") OR 1 = 1 --' }

  scenario 'SQLインジェクション脆弱性を利用して未公開ブログを表示する' do
    visit blogs_path
    expect(page).to have_text(published_blog_with_keyword_in_title.title)
    expect(page).not_to have_text(draft_blog_with_keyword_in_title.title)
    expect(page).to have_text(published_blog_with_keyword_in_body.title)
    expect(page).not_to have_text(draft_blog_with_keyword_in_body.title)
    expect(page).to have_text(published_blog_without_keyword.title)
    expect(page).not_to have_text(draft_blog_without_keyword.title)

    fill_in 'search_text', with: keyword
    click_button 'Search'

    expect(page).to have_text(published_blog_with_keyword_in_title.title)
    expect(page).not_to have_text(draft_blog_with_keyword_in_title.title)
    expect(page).to have_text(published_blog_with_keyword_in_body.title)
    expect(page).not_to have_text(draft_blog_with_keyword_in_body.title)
    expect(page).not_to have_text(published_blog_without_keyword.title)
    expect(page).not_to have_text(draft_blog_without_keyword.title)

    fill_in 'search_text', with: sql_injection_keyword
    click_button 'Search'

    expect(page).to have_text(published_blog_with_keyword_in_title.title)
    expect(page).to have_text(draft_blog_with_keyword_in_title.title)
    expect(page).to have_text(published_blog_with_keyword_in_body.title)
    expect(page).to have_text(draft_blog_with_keyword_in_body.title)
    expect(page).to have_text(published_blog_without_keyword.title)
    expect(page).to have_text(draft_blog_without_keyword.title)
  end
end
