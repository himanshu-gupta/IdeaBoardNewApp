class IdeasController < ApplicationController
  
  # http_basic_authenticate_with :name => "admin@admin.com", :password => "admin123", :only => [:destroy, :update]
  before_filter :authenticate_user!, :only => [:destroy]
  before_filter :define_agenda

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
    @like = Like.find_by_sql(["select * from likes where user_id = ? and agenda_id = ?  and idea_id = ?", current_user.id, @agenda.id, @idea.id])
    if @like.size == 0
      @like_new = Like.new(params[:like])
      @like_new.user_id = current_user.id
      @like_new.agenda_id = @agenda.id
      @like_new.idea_id = @idea.id
      @like_new.save
      if @idea.likes == nil
        @idea.likes = 1
      else
        @idea.likes += 1
      end 
      @idea.update_attribute(:likes, @idea.likes)
      redirect_to agenda_path(@agenda)
    else
      flash[:error] = 'You have already liked the idea.'
      redirect_to agenda_path(@agenda)
    end
  end

  # DELETE /ideas/1
  # DELETE /ideas/1.json
  def destroy    
    @idea = @agenda.ideas.find(params[:id])
    @idea.destroy
	  respond_to do |format|
      format.html { redirect_to agenda_path(@agenda), notice: 'Idea deleted successfully.'  }
      format.json { head :no_content }
    end
  end
  
  def define_agenda
    @agenda =Agenda.find(params[:agenda_id])
  end

end
