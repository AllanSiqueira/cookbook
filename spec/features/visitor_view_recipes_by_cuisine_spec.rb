require 'rails_helper'

feature 'Visitor view recipes by cuisine' do
  scenario 'from home page' do
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe_type = RecipeType.create(name: 'Sobremesa')

    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: cuisine, difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços
                                         pequenos')
    visit root_path
    click_on cuisine.name
    expect(page).to have_css('h1', text: cuisine.name)
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
  end

  scenario 'and view only cuisine recipes' do
    brazilian_cuisine = Cuisine.create(name: 'Brasileira')
    dessert_recipe_type = RecipeType.create(name: 'Sobremesa')
    Recipe.create(title: 'Bolo de cenoura',
                  recipe_type: dessert_recipe_type,
                  cuisine: brazilian_cuisine, difficulty: 'Médio',
                  cook_time: 60,
                  ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços')
    italian_cuisine = Cuisine.create(name: 'Italiana')
    main_recipe_type = RecipeType.create(name: 'Prato Principal')
    italian_recipe = Recipe.create(title: 'Macarrão Carbonara',
                                   recipe_type: main_recipe_type,
                                   cuisine: italian_cuisine,
                                   difficulty: 'Difícil',
                                   cook_time: 30,
                                   ingredients: 'Massa, ovos, bacon',
                                   cook_method: 'Frite o bacon;')
    visit root_path
    click_on italian_cuisine.name
    expect(page).to have_css('h1', text: italian_recipe.title)
    expect(page).to have_css('li', text: italian_recipe.recipe_type.name)
    expect(page).to have_css('li', text: italian_recipe.cuisine.name)
    expect(page).to have_css('li', text: italian_recipe.difficulty)
    expect(page).to have_css('li', text: "#{italian_recipe.cook_time} minutos")
  end

  scenario 'and cuisine has no recipe' do
    brazilian_cuisine = Cuisine.create(name: 'Brasileira')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: brazilian_cuisine, difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura')
    italian_cuisine = Cuisine.create(name: 'Italiana')
    visit root_path
    click_on italian_cuisine.name
    expect(page).not_to have_content(recipe.title)
    expect(page).to have_content('Nenhuma receita encontrada
                                  para este tipo de cozinha')
  end
end
