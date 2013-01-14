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

  def valid_session
    {}
  end

  before(:each) do
      @agenda = Agenda.create!(:title => "Agenda", :owner => nil)
      @idea = Idea.create!{:description => "Idea", :likes => nil}
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

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested idea" do
        idea = Idea.create! valid_attributes
        # Assuming there are no other ideas in the database, this
        # specifies that the Idea created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.

        idea.update_attribute(:title, "MyString")
        # Idea.any_instance.should_receive(:update_attributes).with({ "description" => "MyString" })
        put :update, {:id => idea.to_param, :idea => { "description" => "MyString" }, :agenda_id => @agenda.id}
      end

      it "assigns the requested idea as @idea" do
        idea = Idea.create! valid_attributes
        put :update, {:id => idea.to_param, :idea => valid_attributes, :agenda_id => @agenda.id}#, valid_session
        assigns(:idea).should eq(idea)  
      end

      it "redirects to the idea" do
        idea = Idea.create! valid_attributes
        put :update, {:id => idea.to_param, :idea => valid_attributes, :agenda_id => @agenda.id}#, valid_session
        response.should redirect_to agenda_path(@agenda)
      end
    end

    describe "with invalid params" do
      it "assigns the idea as @idea" do
        idea = Idea.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Idea.any_instance.stub(:save).and_return(false)
        put :update, {:id => idea.to_param, :idea => { "description" => "invalid value" }, :agenda_id => @agenda.id}#, valid_session
        assigns(:idea).should eq(idea)
      end

      it "re-renders the 'edit' template" do
        idea = Idea.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Idea.any_instance.stub(:save).and_return(false)
        put :update, {:id => idea.to_param, :idea => { "description" => "invalid value" }, :agenda_id => @agenda.id}#, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested idea"
      p idea
      expect {
        delete :destroy, {:id => idea.to_param, :agenda_id => @agenda.id}#, valid_session
      }.to change(Idea, :count).by(-1)
    end

    it "redirects to the ideas list" do
      idea = Idea.create! valid_attributes
      p idea
      delete :destroy, {:id => idea.to_param, :agenda_id => @agenda.id}#, valid_session
      response.should redirect_to agenda_path(@agenda)
    end
  end

end