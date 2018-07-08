require 'rails_helper'

feature 'User edit recipe' do
  scenario 'succefully' do
    recipe_type = RecipeType.create name: 'Sobremesa'
    recipe_type = RecipeType.create name: 'Dessert'
    cuisine = Cuisine.create name: 'Brasileira'
    cuisine = Cuisine.create name: 'Francesa'
    recipe = Recipe.create title: 'Bolo de Laranja', cuisine: cuisine, recipe_type: recipe_type,
                          difficulty: 'Fácil', cook_time: 50, ingredients: 'Farinha, laranja, ovo, leite, fermento',
                          cook_method: 'Bate tudo e coloca no forno'
    
    #user actions
    visit root_path
    click_on recipe.title
    click_on 'Editar'

    fill_in 'Título', with: 'Bolo de Laranja Gourmet'
    select 'Francesa', from: 'Cozinha'
    select 'Dessert', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Dificil'
    fill_in 'Ingredientes', with: 'Farinha, laranja, ovo, leite, fermento e baunilha'
    click_on 'Enviar'

    #expectations

    expect(page).to have_css('h1', text: 'Bolo de Laranja Gourmet')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Dessert')
    expect(page).to have_css('p', text: 'Francesa')
    expect(page).to have_css('p', text: 'Dificil')
    expect(page).to have_css('p', text: "50 minutos")
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: 'Farinha, laranja, ovo, leite, fermento e baunilha')
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text:  'Bate tudo e coloca no forno')
  end
  scenario 'and must have all fields filled' do
    recipe_type = RecipeType.create name: 'Sobremesa'
    recipe_type = RecipeType.create name: 'Dessert'
    cuisine = Cuisine.create name: 'Brasileira'
    cuisine = Cuisine.create name: 'Francesa'
    recipe = Recipe.create title: 'Bolo de Laranja', cuisine: cuisine, recipe_type: recipe_type,
                          difficulty: 'Fácil', cook_time: 50, ingredients: 'Farinha, laranja, ovo, leite, fermento',
                          cook_method: 'Bate tudo e coloca no forno'
    
    #user actions
    visit root_path
    click_on recipe.title
    click_on 'Editar'

    fill_in 'Título', with: 'Bolo de Laranja Gourmet'
    select 'Francesa', from: 'Cozinha'
    select 'Dessert', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: ''
    fill_in 'Ingredientes', with: 'Farinha, laranja, ovo, leite, fermento e baunilha'
    click_on 'Enviar'

    #expectations

    expect(page).to have_content('Você deve informar todos os dados da receita')
  end
end