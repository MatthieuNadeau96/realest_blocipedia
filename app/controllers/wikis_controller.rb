class WikisController < ApplicationController
  before_action :require_sign_in, except: [:index, :show]
  before_action :authorize_user, except: [:index, :show, :new, :create]
  
  def authorize_user
    unless current_user.admin?
      flash[:alert] = "You must be an admin to do that."
      redirect_to wikis_path
    end
  end
  
  def index
    @wikis = Wiki.all
    # authorize @wikis
    
  end

  def show
    @wiki = Wiki.find(params[:id])
    # authorize @wikis
  end

  def new
    # @user = my_user
    @wiki = Wiki.new
    # authorize @wikis
  end
  
  def create 
    @wiki = Wiki.new(user: current_user)
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    
    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash[:alert] = "There was an error saving this wiki. Try again."
      render :new
    end
    
    # @wiki = current_user.wikis.create(wiki_params)
    # authorize @wiki
    # adding owner to collaborator list
    # collaborator = @wiki.collaborators.build(user_id:current_user.id)
  end

  def edit
    @wiki = Wiki.find(params[:id])
    # @wiki = Wiki.find(params[:id])
    # authorize @wikis
  end
  
  def update 
    @wiki = Wiki.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    # @wiki = Wiki.find(params[:id])
    # authorize @wikis
    
    if @wiki.save
      flash[:notice] = "Wiki was updated successfully."
      redirect_to @wiki
    else
      flash[:notice] = "There was a problem saving this wiki. Please try again."
      render :edit
    end
  end
  
  def destroy
    @wiki = Wiki.find(params[:id])
    # title = @wiki.title
    # authorize @wikis
    
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting this wiki."
      render :show
    end
  end
end
