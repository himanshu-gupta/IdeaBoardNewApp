require 'spec_helper'

# Reference site for rspec
# https://www.relishapp.com/rspec/rspec-expectations/v/2-0/docs

describe IdeasController do

  def valid_attributes
   { 
      :description => "Idea",
      :likes => nil
   }
  end

  before(:each) do
    @user = User.create!({
      :email => 'admin@admin.com',
      :password => 'admin123',
      :password_confirmation => 'admin123' 
    })
    sign_in @user
    @agenda = Agenda.create!(:title => "Agenda", :owner => nil)
    @idea = {:description => "Idea", :likes => nil}
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new idea" do
        expect {
          post :create, :idea => @idea, :agenda_id => @agenda.id
        }.to change(Idea, :count).by(1)
      end

      it "assigns a newly created idea as @idea" do
        post :create, :idea => @idea, :agenda_id => @agenda.id
        assigns(:idea).should be_a(Idea)
        assigns(:idea).should be_persisted
      end

      it "redirects to the created idea" do
        post :create, :idea => @idea, :agenda_id => @agenda.id
        response.should redirect_to agenda_path(@agenda)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved idea as @idea" do
        # Trigger the behavior that occurs when invalid params are submitted
        Idea.any_instance.stub(:save).and_return(false)
        post :create, :idea => { "description" => "invalid value" }, :agenda_id => @agenda.id
        assigns(:idea).should be_a_new(Idea)
      end

      #validating render action
      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        # About stubs
        # https://relishapp.com/rspec/rspec-mocks/v/2-12/docs/method-stubs
        Idea.any_instance.stub(:save).and_return(false)
        post :create, :idea => { "description" => "invalid value" }, :agenda_id => @agenda.id
        response.should redirect_to agenda_path(@agenda)
      end
    end
  end
end