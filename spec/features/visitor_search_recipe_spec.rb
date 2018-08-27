require 'rails_helper'

feature 'Visitor search a recipe' do
  scenario 'succefully' do
    recipe_type = RecipeType.create name: 'Sobremesa'
    cuisine = Cuisine.create name: 'Brasileira'
    recipe = Recipe.create title: 'Bolo de Laranja', cuisine: cuisine,
                           recipe_type: recipe_type, difficulty: 'Fácil',
                           cook_time: 50,
                           ingredients: 'Farinha, laranja, ovo, leite',
                           cook_method: 'Bate tudo e coloca no forno'
    visit root_path
    fill_in 'Buscar Receitas:', with: recipe.title
    click_on 'Buscar'
    expect(page).to have_css('h2',
                             text: "Resultados da busca por: #{recipe.title}")
    expect(page).to have_css('h3', text: recipe.title)
    expect(page).to have_css('li', text: 'Sobremesa')
    expect(page).to have_css('li', text: 'Brasileira')
    expect(page).to have_css('li', text: 'Fácil')
    expect(page).to have_css('li', text: '50 minutos')
  end
  scenario 'and leave the search field empty' do
    recipe_type = RecipeType.create name: 'Sobremesa'
    cuisine = Cuisine.create name: 'Brasileira'
    recipe = Recipe.create title: 'Bolo de Laranja', cuisine: cuisine,
                           recipe_type: recipe_type, difficulty: 'Fácil',
                           cook_time: 50,
                           ingredients: 'Farinha, laranja, ovo, leite',
                           cook_method: 'Bate tudo e coloca no forno'
    another_recipe = Recipe.create title: 'Bolo de Cenoura', cuisine: cuisine,
                                   recipe_type: recipe_type,
                                   difficulty: 'Fácil', cook_time: 45,
                                   ingredients: 'Farinha, cenoura, ovo, leite',
                                   cook_method: 'Bate tudo e coloca no forno'
    visit root_path
    fill_in 'Buscar Receitas:', with: ''
    click_on 'Buscar'
    expect(page).to have_css('h3', text: recipe.title)
    expect(page).to have_css('h3', text: another_recipe.title)
  end
  scenario 'and search from any page of the site' do
    recipe_type = RecipeType.create name: 'Sobremesa'
    cuisine = Cuisine.create name: 'Brasileira'
    recipe = Recipe.create title: 'Bolo de Laranja', cuisine: cuisine,
                           recipe_type: recipe_type, difficulty: 'Fácil',
                           cook_time: 50,
                           ingredients: 'Farinha, laranja, ovo, leite',
                           cook_method: 'Bate tudo e coloca no forno'
    visit root_path
    click_on recipe.title
    fill_in 'Buscar Receitas:', with: recipe.title
    click_on 'Buscar'
    expect(page).to have_css('h2',
                             text: "Resultados da busca por: #{recipe.title}")
    expect(page).to have_css('h3', text: recipe.title)
    expect(page).to have_css('li', text: 'Sobremesa')
    expect(page).to have_css('li', text: 'Brasileira')
    expect(page).to have_css('li', text: 'Fácil')
    expect(page).to have_css('li', text: '50 minutos')
  end
end
