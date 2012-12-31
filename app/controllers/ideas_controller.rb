class IdeasController < ApplicationController
  
#  http_basic_authenticate_with :name => "admin@admin.com", :password => "admin123", :only => [:destroy, :update]
  before_filter :authenticate_user!, :only => [:destroy]
  before_filter :define_agenda
  
  # GET /ideas
  # GET /ideas.json
  def index
    @ideas = @agenda.ideas

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ideas }
    end
  end

  # GET /ideas/1
  # GET /ideas/1.json
  def show
    @idea = @agenda.ideas.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @idea }
    end
  end

  # GET /ideas/new
  # GET /ideas/new.json
  def new
    @idea = @agenda.ideas.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @idea }
    end
  end

  # GET /ideas/1/edit
  def edit
    
    @idea = @agenda.ideas.find(params[:id])
#    @idea = Idea.find(params[:id])
  end

  # POST /ideas
  # POST /ideas.json
  def create
    
    @idea = @agenda.ideas.create(params[:idea])
	
    respond_to do |format|
      if @idea.save
        format.html { redirect_to agenda_path(@agenda), notice: 'Idea was successfully created.' }
        format.json { render json: agenda_path(@agenda), status: :created, location: agenda_path(@agenda) }
      else
        format.html { redirect_to agenda_path(@agenda), notice: 'Description field can not be blank.' }
#        format.html { render action: "new" }
#        format.json { render json: agenda_path(@agenda).errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ideas/1
  # PUT /ideas/1.json
  def update    
    
    @idea = @agenda.ideas.find(params[:id])
    
    if @idea.likes == nil
      @idea.likes = 1
    else
      @idea.likes += 1
    end
	
    respond_to do |format|
      if @idea.update_attribute(:likes, @idea.likes)
        format.html { redirect_to agenda_path(@agenda)}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: agenda_path(@agenda).errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ideas/1
  # DELETE /ideas/1.json
  def destroy
    
    @idea = @agenda.ideas.find(params[:id])
    @idea.destroy
	respond_to do |format|
      format.html { redirect_to agenda_path(@agenda), notice: 'Idea was successfully destroyed.'  }
      format.json { head :no_content }
    end
  end
  
  def define_agenda
    @agenda =Agenda.find(params[:agenda_id])
  end
end
