require 'rails_helper'

feature 'User edit recipe' do
  scenario 'succefully' do
    user = FactoryBot.create(:user)
    recipe_type = RecipeType.create name: 'Sobremesa'
    another_recipe_type = RecipeType.create name: 'Dessert'
    cuisine = Cuisine.create name: 'Brasileira'
    another_cuisine = Cuisine.create name: 'Francesa'
    recipe = Recipe.create title: 'Bolo de Laranja', cuisine: cuisine, recipe_type: recipe_type,
                           difficulty: 'Fácil', cook_time: 50, ingredients: 'Farinha, laranja, ovo, leite, fermento',
                           cook_method: 'Bate tudo e coloca no forno', photo: File.new(Rails.root.join('spec', 'support', 'tabule.jpg'))
    login_as(user, scope: :user)
    visit root_path
    click_on recipe.title
    click_on 'Editar'
    fill_in 'Título', with: 'Bolo de Laranja Gourmet'
    attach_file('Foto', Rails.root.join('spec', 'support', 'bolo.jpg'))
    select 'Francesa', from: 'Cozinha'
    select 'Dessert', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Dificil'
    fill_in 'Ingredientes', with: 'Farinha, laranja, ovo, leite, fermento e baunilha'
    click_on 'Enviar'
    expect(page).to have_css('h1', text: 'Bolo de Laranja Gourmet')
    expect(page).to have_css("img[src*='bolo.jpg']")
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Dessert')
    expect(page).to have_css('p', text: 'Francesa')
    expect(page).to have_css('p', text: 'Dificil')
    expect(page).to have_css('p', text: '50 minutos')
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: 'Farinha, laranja, ovo, leite, fermento e baunilha')
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text:  'Bate tudo e coloca no forno')
  end
  scenario 'and must have all fields filled' do
    user = FactoryBot.create(:user)
    recipe_type = RecipeType.create name: 'Sobremesa'
    another_recipe_type = RecipeType.create name: 'Dessert'
    cuisine = Cuisine.create name: 'Brasileira'
    another_cuisine = Cuisine.create name: 'Francesa'
    recipe = Recipe.create title: 'Bolo de Laranja', cuisine: cuisine, recipe_type: recipe_type,
                           difficulty: 'Fácil', cook_time: 50, ingredients: 'Farinha, laranja, ovo, leite, fermento',
                           cook_method: 'Bate tudo e coloca no forno'

    # user actions
    login_as(user, scope: :user)
    visit root_path
    click_on recipe.title
    click_on 'Editar'

    fill_in 'Título', with: 'Bolo de Laranja Gourmet'
    select 'Francesa', from: 'Cozinha'
    select 'Dessert', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: ''
    fill_in 'Ingredientes', with: 'Farinha, laranja, ovo, leite, fermento e baunilha'
    click_on 'Enviar'

    # expectations

    expect(page).to have_content('Você deve informar todos os dados da receita')
  end
  scenario 'and must be authenticated' do
    recipe_type = RecipeType.create name: 'Sobremesa'
    cuisine = Cuisine.create name: 'Brasileira'
    recipe = Recipe.create title: 'Bolo de Laranja', cuisine: cuisine, recipe_type: recipe_type,
                           difficulty: 'Fácil', cook_time: 50, ingredients: 'Farinha, laranja, ovo, leite, fermento',
                           cook_method: 'Bate tudo e coloca no forno'

    visit root_path
    click_on recipe.title
    click_on 'Editar'

    expect(current_path).to eq new_user_session_path
  end
end
