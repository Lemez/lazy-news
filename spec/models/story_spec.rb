require "rails_helper" 


describe Story do
     it "has a valid factory" do
    	expect(FactoryGirl.create(:story)).to be_valid
  	 end
	 it "is invalid without an area" do 
	  	expect(FactoryGirl.build(:story, area: nil)).to be_invalid
	 end
	 it "is invalid without a title" do 
	  	expect(FactoryGirl.build(:story, title: nil)).to be_invalid
	 end
	 it "is invalid without a picture url" do 
	  	expect(FactoryGirl.build(:story, pic_url: nil)).to be_invalid
	 end
	  it "is invalid without a story url" do 
	  	expect(FactoryGirl.build(:story, url: nil)).to be_invalid
	 end

	 it "does not allow duplicate story title" do
	 	@storyparams1 = {:area => 'area1', :source => 'source1', :title=>'title1', :pic_url=> 'picurl1', :url => 'url1'}
		@storyparams2 = {:area => 'area2', :source => 'source2', :title=>'title2', :pic_url=> 'picurl2', :url => 'url2'}


  		FactoryGirl.build(:story, @storyparams1)
  		@storyparams2[:title] = 'title1'
  		expect(FactoryGirl.build(:story, @storyparams2)).to be_invalid
	end


  # it "returns a contact's full name as a string"


end


# validates :area, presence: true
# validates :source, presence: true
# validates :title, presence: true, uniqueness: true
# validates :pic_url, presence: true #, uniqueness: true
# validates :url, presence: true, uniqueness: true