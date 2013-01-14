# spec/models/agenda.rb
require 'spec_helper'

describe Agenda do

	#About Factory
	#create() builds the model and saves it
	#Factory.create() = Factory()
	#build() instantiates a new model, but doesn’t save it
	#it "has a valid factory" do
		#Factory.create(:agenda).should be_valid
  	#end

 	#validates presence of field (here title can not be nil)
  	it "is invalid without a title" do
  		@agenda = Agenda.create!(:title => "Himanshu")
  		@agenda.should_not be_nil
  	end

  	#validates length of field (here title length should be > 1)
  	it "is invalid for title length less than 1" do
  		#Factory.build(:agenda, :title => nil).should_not be_valid
  		Agenda.create!(:title => "Himanshu", :owner => nil).should be_valid
  	end

  	#validates type of field (here title should be String)
  	it 'is invalid for title other than String' do
		agenda = Agenda.create(:title => "Himanshu")
		agenda.title.should be_a(String)
	end

	#validates associations
	it "should have many ideas" do
    	agenda = Agenda.reflect_on_association(:ideas)
    	agenda.macro.should == :has_many
    end

end