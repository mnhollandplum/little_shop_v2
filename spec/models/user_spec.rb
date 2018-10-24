require 'rails_helper'

describe User, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name}
    it { should validate_presence_of :address}
    it { should validate_presence_of :city}
    it { should validate_presence_of :state}
    it { should validate_presence_of :email}
    it { should validate_uniqueness_of :email}
    it { should validate_presence_of :password}
    it { should validate_confirmation_of :password}
    it { should validate_presence_of :role}
    it { should validate_presence_of :enabled}
  end

  describe "Relationships" do 
    it { should have_many(:items)}
  end 
end