class BookmarksController < ApplicationController

  before_filter :authenticate_user!

  after_action :verify_authorized, :except => :index

  def show
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.new
    authorize @bookmark

  end

  def edit
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark

  end

  def create
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.build(bookmark_params)
    @bookmark.user = current_user
    authorize @bookmark


      if @bookmark.save
        flash[:notice] = "Bookmark was saved."
        redirect_to topics_path
      else
        flash[:error] = "There was an error saving the bookmark. Please try again."
        render :new
      end
  end

   def update
     @bookmark = Bookmark.find(params[:id])
     @bookmark.assign_attributes(bookmark_params)
     authorize @bookmark


     if @bookmark.save
       flash[:notice] = "Bookmark was updated."
       redirect_to topics_path
     else
       flash[:error] = "There was an error saving this bookmark. Please try again."
       render :edit
     end
   end

   def destroy
     @bookmark = Bookmark.find(params[:id])
     authorize @bookmark


     if @bookmark.destroy
       flash[:notice] = "\"#{@bookmark.url}\" was deleted successfully."
       redirect_to topics_path
     else
       flash[:error] = "There was an error deleting the bookmark."
       render :show
     end
   end

   private

   def bookmark_params
     params.require(:bookmark).permit(:url)
   end
end