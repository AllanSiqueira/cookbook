require 'rails_helper'

feature 'Visitor visit homepage' do
  scenario 'successfully' do
    #criar dados

    #simular a ação do usuário
    visit root_path

    #simular as expectativas do usuário
    expect(page).to have_css('h1', text: 'CookBook')
    expect(page).to have_css('p', text: 'Bem-vindo ao maior livro de receitas online')
  end
end
