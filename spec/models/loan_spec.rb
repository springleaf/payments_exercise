require 'rails_helper'

RSpec.describe Loan, type: :model do
  describe 'validation' do
    it { expect(subject).to validate_presence_of(:funded_amount) }
  end

  describe 'associations' do
    it { should have_many(:payments).class_name('Payment')}
  end
end
