# spec/models/idea.rb
require 'spec_helper'

describe Idea do

 	# validates presence of field (here description can not be nil)
  it "is invalid without a description" do
  	@idea = Idea.create!(:description => "Himanshu", :likes => nil)
  	@idea.should_not be_nil
  end

  # validates length of field (here description length should be > 1)
  it "is invalid for description length less than 1" do
  	#Factory.build(:idea, :description => nil).should_not be_valid
  	Idea.create!(:description => "Himanshu").should be_valid
  end

  # validates type of field (here description should be String)
  it 'is invalid for description other than String' do
	  idea = Idea.create(:description => "Himanshu")
	  idea.description.should be_a(String)
  end

	# validates associations
  # using shoulda-matchers gem
  it "should belong to a group" do
      @idea = Idea.new
      @idea.should belongs_to(:agenda)
  end

end