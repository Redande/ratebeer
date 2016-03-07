require 'rails_helper'

describe "beerlist page" do

  before :all do
    self.use_transactional_fixtures = false
    WebMock.disable_net_connect!(allow_localhost:true)
  end

  before :each do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start

    @brewery1 = FactoryGirl.create(:brewery, name: "Koff")
    @brewery2 = FactoryGirl.create(:brewery, name: "Schlenkerla")
    @brewery3 = FactoryGirl.create(:brewery, name: "Ayinger")
    @style1 = Style.create name: "Lager"
    @style2 = Style.create name: "Rauchbier"
    @style3 = Style.create name: "Weizen"
    @beer1 = FactoryGirl.create(:beer, name: "Nikolai", brewery: @brewery1, style: @style1)
    @beer2 = FactoryGirl.create(:beer, name: "Fastenbier", brewery: @brewery2, style: @style2)
    @beer3 = FactoryGirl.create(:beer, name: "Lechte Weisse", brewery: @brewery3, style: @style3)
  end

  after :each do
    DatabaseCleaner.clean
  end

  after :all do
    self.use_transactional_fixtures = true
  end

  it "shows one known beer", js: true do
    visit beerlist_path
    find('table').find('tr:nth-child(2)')
    save_and_open_page
    expect(page).to have_content "Nikolai"
  end

  it "has beers in alphabetical order", js: true do
    visit beerlist_path
    expect(page.all('tr')[1].text).to have_content "Fastenbier"
    expect(page.all('tr')[2].text).to have_content "Lechte Weisse"
    expect(page.all('tr')[3].text).to have_content "Nikolai"
  end

  it "sorts beers by style when clicked style", js: true do
    visit beerlist_path
    page.all('a', :text => 'style').first.click
    expect(page.all('tr')[1].text).to have_content "Lager"
    expect(page.all('tr')[2].text).to have_content "Rauchbier"
    expect(page.all('tr')[3].text).to have_content "Weizen"
  end

  it "sorts beers by brewery when clicked brewery", js: true do
    visit beerlist_path
    click_link('brewery')
    expect(page.all('tr')[1].text).to have_content "Ayinger"
    expect(page.all('tr')[2].text).to have_content "Koff"
    expect(page.all('tr')[3].text).to have_content "Schlenkerla"
  end
end
