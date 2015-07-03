Given(/^There are (\d+) articles of this person$/) do |amount|
  persona_con_articulos = Person.first
  FactoryGirl.create_list(:article, amount.to_i, person: persona_con_articulos)
end

Given(/^I click the articles tab of the person$/) do
  page.find("#person__articles").click
end

Given(/^I click the new articles button$/) do
  page.find("#nuevoArticulo").click
end

Then(/^I visit new articles form page$/) do
  expect(page).to have_css "#articleForm"
end

When(/^I fill article form with valid parameters$/) do
parametros = FactoryGirl.attributes_for(:article)
  if parametros[:type] == :blanket
    select('manta', from: 'InputType')
  elsif parametros[:type] == :sheet
    select('sábana', from: 'InputType')
  elsif parametros[:type] == :jacket
    select('chaqueta', from: 'InputType')
  elsif parametros[:type] == :shoes
    select('zapatos', from: 'InputType')
  elsif parametros[:type] == :others1
    select('otros 1', from: 'InputType')
  elsif parametros[:type] == :others2
    select('otros 2', from: 'InputType')
  elsif parametros[:type] == :others3
    select('otros 3', from: 'InputType')
  end

  fill_in 'InputAmount', with: 1
  fill_in 'InputObservations', with: parametros[:observations]
  fill_in 'InputRequested', with: parametros[:requested].strftime('%d/%m/%Y')
  fill_in 'InputDispensed', with: parametros[:dispensed].strftime('%d/%m/%Y')

  click_button 'InputSubmit'
end

Then(/^I should see the new article in articles list$/) do
  expect(page).to have_css "#articlesTable"

  article = Article.last
  expect(page).to have_css "tr#article_#{article.id} td:nth-child(2)", text:
    if article.type == :blanket
      "manta"
    elsif article.type == :sheet
      "sábana"
    elsif article.type == :jacket
      "chaqueta"
    elsif article.type == :shoes
      "zapatos"
    elsif article.type == :others1
      "otros 1"
    elsif article.type == :others2
      "otros 2"
    elsif article.type == :others3
      "otros 3"
    end

  expect(page).to have_css "tr#article_#{article.id} td:nth-child(4)", text: article.requested.strftime("%Y-%m-%d")
  expect(page).to have_css "tr#article_#{article.id} td:nth-child(5)", text: article.dispensed.strftime("%Y-%m-%d")
  expect(page).to have_css "tr#article_#{article.id} td:nth-child(6)", text: article.observations

end

Then(/^I should see article created message$/) do
  expect(page).to have_css ".leo-message", text:"¡Ha creado satisfactoriamente un nuevo artículo!"
end

When(/^I fill article form with invalid parameters$/) do
parametros = FactoryGirl.attributes_for(:article)
  fill_in 'InputObservations', with: parametros[:obervations]
  click_button 'InputSubmit'
end

Then(/^I should see the errors in the article form$/) do
  expect(page).to have_css ".has-error #InputType"
  expect(page).to have_css "#InputType ~ .tooltip", text: I18n.t('mongoid.errors.messages.inclusion')
  expect(page).to have_css ".has-error #InputRequested"
  expect(page).to have_css "#InputRequested ~ .tooltip", text: I18n.t('mongoid.errors.messages.blank')
end

Then(/^I should see the list of the articles$/) do
  expect(page).to have_css "#articlesTable"
end

#Vista de artículo
When(/^I click the view icon of an article in articles list view$/) do
  articulo = Person.first.articles.first
  page.find("#article-show-#{articulo.id}").click
end

Then(/^I should go to a view of this article$/) do
  expect(page).to have_css "#article-show-page"
end

#Borrar artículo
When(/^I click the remove button in article view$/) do
  @articulo = Article.first
  page.find("#remove-article-btn").click
  page.driver.browser.switch_to.alert.accept
end

Then(/^I should remove this article$/) do
  expect(page).to_not have_css "#article-show-#{@articulo.id}"
end

Then(/^I should see a success message of delete article$/) do
  expect(page).to have_css ".leo-message", text:"¡Borrado satisfactoriamente!"
end

#editar articulo
When(/^I click the edit article button$/) do
  page.find(".persona__botones__edit").click
end

Then(/^I should see the edit form article$/) do
  expect(page).to have_css "#articleForm"
end

Then(/^I should see the article information in the form$/) do
  articulo = Person.first.articles.first
  find_field('InputType').value.should eq articulo.type.to_s
  find_field('InputAmount').value.should eq articulo.amount.to_s
  find_field('InputObservations').value.should eq articulo.observations
  find_field('InputRequested').value.should eq articulo.requested.to_s
  find_field('InputDispensed').value.should eq articulo.dispensed.to_s
end

When(/^I update the article form$/) do
  select('manta', from: 'InputType')
  fill_in 'InputAmount', with: 3
  fill_in 'InputObservations', with: "Tuvo un problema"
  page.find("#InputSubmit").click
end

Then(/^I should see the article updated$/) do
 expect(page).to have_css "#article-show-page"
 expect(page).to have_css "#article_type", text: "manta"
 expect(page).to have_css "#article_amount", text: "3"
 expect(page).to have_css "#article_observations", text: "Tuvo un problema"
end
