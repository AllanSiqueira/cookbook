require 'rails_helper'

feature 'User register cuisine' do
  scenario 'successfully' do
    user = FactoryBot.create(:user)

    login_as(user, :scope => :user)
    visit new_cuisine_path
    fill_in 'Nome', with: 'Brasileira'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Brasileira')
    expect(page).to have_content('Nenhuma receita encontrada para este tipo de cozinha')
  end

  scenario 'and must fill in name' do
    user = FactoryBot.create(:user)
    
    login_as(user, :scope => :user)
    visit new_cuisine_path
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar o nome da cozinha')
  end

  scenario 'and must be authenticated' do
    visit new_cuisine_path
    
    expect(current_path).to eq new_user_session_path
  end
end
