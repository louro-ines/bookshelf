require 'rails_helper'

RSpec.describe Author, type: :model do
  before do
    create(:author)
  end

  describe 'associations' do
    it { should have_many(:books).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:age) }
  end
end
