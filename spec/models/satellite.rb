require 'rails_helper'

RSpec.describe Satellite, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :last_updated } 
    it { should validate_presence_of :altitude } 
  end
end