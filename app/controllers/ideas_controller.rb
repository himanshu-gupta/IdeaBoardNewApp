class IdeasController < ApplicationController
  
  # http_basic_authenticate_with :name => "admin@admin.com", :password => "admin123", :only => [:destroy, :update]
  before_filter :authenticate_user!, :only => [:destroy]
  before_filter :define_agenda

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

  # POST /ideas
  # POST /ideas.json
  def create    
    @idea = @agenda.ideas.create(params[:idea])
    @agenda.update_attributes({"ideas_count" => @agenda.ideas.count + 1})	
    respond_to do |format|
      if @idea.save
        format.html { redirect_to agenda_path(@agenda), notice: 'Bingo!!! Your idea has been accepted.' }
        format.json { render json: agenda_path(@agenda), status: :created, location: agenda_path(@agenda) }
      else
        format.html {  
          flash[:error] = 'Idea description can not be left blank.'
          redirect_to agenda_path(@agenda)
        }
        format.json { render json: agenda_path(@agenda).errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ideas/1
  # PUT /ideas/1.json
  def update        
    @idea = @agenda.ideas.find(params[:id])
    if params[:liked].nil?
      @like_new = Like.new
      @like_new.user_id = current_user.id
      @like_new.agenda_id = @agenda.id
      @like_new.idea_id = @idea.id
      @like_new.save
      likes = @idea.likes + 1
    else
      @liked = Like.find(params[:liked])
      @liked.destroy
      likes = @idea.likes - 1
    end
    @idea.update_attribute(:likes, likes)
    redirect_to agenda_path(@agenda)
  end

  # DELETE /ideas/1
  # DELETE /ideas/1.json
  def destroy    
    @idea = @agenda.ideas.find(params[:id])
    @idea.destroy
	  respond_to do |format|
      format.js
    end
  end
  
  def define_agenda
    @agenda =Agenda.find(params[:agenda_id])
  end

end
