require 'rails_helper'

feature 'Creating a comment', type: :feature do
  feature 'User must login and fill in comment' do
    before(:each) do
      User.create(name: 'foo', email: 'foo@mail.com', password: 'password', password_confirmation: 'password')
      visit '/users/sign_in'
      within('#new_user') do
        fill_in 'Email', with: 'foo@mail.com'
        fill_in 'Password', with: 'password'
      end
      click_button 'Log in'
      fill_in 'post_content', with: 'This is a new comment.'
      click_button 'commit'
      within('#new_comment') do
        fill_in 'comment_content', with: 'This is a comment.'
        click_button 'commit'
      end
    end

    scenario 'when you create a new comment' do
      expect(page).to have_content('Comment was successfully created.')
    end
  end


    scenario 'fail when post content field is empty' do
      User.create(name: 'foo', email: 'foo@mail.com', password: 'password', password_confirmation: 'password')
      visit '/users/sign_in'
      within('#new_user') do
        fill_in 'Email', with: 'foo@mail.com'
        fill_in 'Password', with: 'password'
      end
      click_button 'Log in'
      fill_in 'post_content', with: ''
      click_button 'commit'
      expect(page).to have_content("Post could not be saved. Content can't be blank")
    end

    scenario 'fail when comment field is empty' do
      User.create(name: 'foo', email: 'foo@mail.com', password: 'password', password_confirmation: 'password')
      visit '/users/sign_in'
      within('#new_user') do
        fill_in 'Email', with: 'foo@mail.com'
        fill_in 'Password', with: 'password'
      end
      click_button 'Log in'
      fill_in 'post_content', with: 'This is a new comment.'
      click_button 'commit'
      within('#new_comment') do
        fill_in 'comment_content', with: ''
        click_button 'commit'
      end
      expect(page).to have_content("Content can't be blank")
    end

end
