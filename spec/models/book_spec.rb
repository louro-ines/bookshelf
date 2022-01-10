require 'rails_helper'

RSpec.describe Book, type: :model do
  before do
    create(:book)
  end

  describe 'associations' do
    it { should belong_to(:author) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_least(3) }
  end
end
