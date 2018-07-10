require 'rails_helper'

feature 'User sign in' do
  scenario 'from home page' do
    user = create :user

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    within 'form#new_user' do
      click_on 'Entrar'
    end

    expect(current_path).to eq root_path
    expect(page).to have_content "Olá #{user.email}"
  end
  scenario 'and does not see Entrar Link' do
    user = create :user

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    within 'form#new_user' do
      click_on 'Entrar'
    end

    expect(page).not_to have_content 'Entrar'
  end
end