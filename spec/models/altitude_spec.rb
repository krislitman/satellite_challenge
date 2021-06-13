require 'rails_helper'

RSpec.describe Altitude, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :status } 
  end
end