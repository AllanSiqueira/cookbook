require 'rails_helper'

feature 'Visitor visit homepage' do
  scenario 'successfully' do
    #cria dados necessários

    #simular a ação do usuário
    visit root_path

    #simular as expectativas do usuário
    expect(page).to have_css('h1', text: 'CookBook')
    expect(page).to have_css('p', text: 'Bem-vindo ao maior livro de receitas online')
  end

  scenario 'and view recipe' do
    #cria dados necessários
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: 'Sobremesa',
                          cuisine: 'Brasileira', difficulty: 'Médio',
                          cook_time: 60)

    # simula a ação do usuário
    visit root_path

    #expectativas do usuário após ação
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type)
    expect(page).to have_css('li', text: recipe.cuisine)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
  end

  scenario 'and view recipes list' do
    #cria dados necessários
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: 'Sobremesa',
                          cuisine: 'Brasileira', difficulty: 'Médio',
                          cook_time: 60)
    another_recipe = Recipe.create(title: 'Feijoada', recipe_type: 'Prato Principal',
                          cuisine: 'Brasileira', difficulty: 'Difícil',
                          cook_time: 90)

    # simula a ação do usuário
    visit root_path

    #expectativas do usuário após ação
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type)
    expect(page).to have_css('li', text: recipe.cuisine)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")

    expect(page).to have_css('h1', text: another_recipe.title)
    expect(page).to have_css('li', text: another_recipe.recipe_type)
    expect(page).to have_css('li', text: another_recipe.cuisine)
    expect(page).to have_css('li', text: another_recipe.difficulty)
    expect(page).to have_css('li', text: "#{another_recipe.cook_time} minutos")

  end
end
