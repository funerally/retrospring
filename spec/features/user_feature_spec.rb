require 'rails_helper'

feature "User", :type => :feature do
  before do
    @user1 = create(:user)
    @user2 = create(:user)
  end

  scenario "gets asked a question", js: true do
    visit "/@#{@user1.screen_name}"

    page.driver.render Rails.root.join("tmp/#{Time.now.to_i}.png"), full: true

    fill_in "qb-question", with: Faker::Lorem.sentence
    click_button "Ask"
    wait_for_ajax
    reload_page

    page.driver.render Rails.root.join('tmp'), full: full

    expect(page).to have_text("Question asked successfully.")
  end
end
