require "rails_helper" 

describe User do
   it "has a valid factory" do
    expect(FactoryGirl.create(:user)).to be_valid
  end

  it "is invalid without an email" do 
  	expect(FactoryGirl.build(:user, email: nil)).to be_invalid
  end

end