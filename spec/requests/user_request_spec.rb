require 'rails_helper'

RSpec.describe "Users", type: :request do

  RSpec.shared_context 'with multiple companies' do
    let!(:company_1) { create(:company) }
    let!(:company_2) { create(:company) }

    before do
      5.times do
        create(:user, company: company_1)
      end
      5.times do
        create(:user, company: company_2)
      end
      create(:user, username: 'user1_1')
      create(:user, username: 'user1_2')
      create(:user, username: 'user2_1')
      create(:user, username: 'user2_2')
    end
  end

  describe "#index" do
    let(:result) { JSON.parse(response.body) }

    context 'when fetching users by company' do
      include_context 'with multiple companies'

      it 'returns only the users for the specified company' do
        get company_users_path(company_1)
        
        expect(result.size).to eq(company_1.users.size)
        expect(result.map { |element| element['id'] } ).to eq(company_1.users.ids)
      end
    end

    context 'when filtering by username with partial match' do
      include_context 'with multiple companies'

      it 'returns users with matching username' do
        get users_path(username: 'user1')
        
        expect(result.size).to eq(2)
      end
    end
  end
end
