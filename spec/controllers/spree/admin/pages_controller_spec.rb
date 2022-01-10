RSpec.describe Spree::Admin::PagesController, type: :controller do
  stub_authorization!

  describe '#update_positions' do
    subject do
      post :update_positions, params: {
        positions: { page_1.position => '2', page_2.position => '1' }, format: 'js'
      }
    end
  
    let(:page_1) { create(:page, position: 1) }
    let(:page_2) { create(:page, position: 2) }
  
    it 'updates the position of page 1' do
      expect { subject }.to change { page_1.reload.position }.from(1).to(2)
    end
  end
end