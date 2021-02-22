RSpec.feature 'Static Content Page', :js do
  let!(:store) { create(:store, default: true) }

  context 'render page' do
    scenario 'is a query string' do
      create(:page, slug: '/page', title: 'Query Test', stores: [store])
      visit '/page?test'
      expect(page).to have_text 'Query Test'.upcase
    end

    scenario 'can have slug not starting by /' do
      create(:page, slug: 'page2', title: 'No Slash Prefix Test', stores: [store])
      visit '/page2'
      expect(page).to have_text 'No Slash Prefix Test'.upcase
    end

    scenario 'can have slug with multiple /' do
      create(:page, slug: '/hello/shoppers/page3', title: 'Multiple Slash Test', stores: [store])
      visit '/hello/shoppers/page3'
      expect(page).to have_text 'Multiple Slash Test'.upcase
    end

    scenario 'can be a custom root page' do
      create(:page, slug: '/', title: 'Root Page Test', stores: [store])
      visit '/'
      expect(page).to have_text 'Root Page Test'.upcase
    end

    scenario 'is limited within its own constraints' do
      skip 'this won\'t work with new spree version since change with render_404'
      create(:page, slug: '/t/categories/page3', title: 'Constraint Test', stores: [store])
      visit '/t/categories/page3'
      expect(page).not_to have_text 'Constraint Test'.upcase
    end

    scenario 'fetch correct page' do
      create(:page, slug: '/', stores: [store])
      create(:page, slug: 'hello', title: 'Hello', stores: [store])
      create(:page, slug: 'somwhere', stores: [store])
      create(:page, :with_foreign_link, slug: 'whatever', stores: [store])
      visit '/hello'
      expect(page).to have_text 'Hello'.upcase
    end

    scenario 'do not effect the rendering of the rest of the site' do
      product = create(:product)
      visit spree.product_path(product)
      expect(page).to have_text product.name
    end

    scenario 'can visit paths to change the language' do
      skip if Spree.version.to_f < 4.2
      locale = I18n.available_locales.sample
      visit "/#{locale}"

      expect(page).to have_text 'WOMEN'.upcase
    end
  end
end
