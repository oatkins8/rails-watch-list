class BookmarksController < ApplicationController

  def new
    set_list # the list we need is the one we're currently on (params)
    @bookmark = Bookmark.new # the new bookmark instance is plugged into the simple form ???? - GET A Bookmark.new
  end

  def create
    set_list # the list is the current list in the url (params)
    @bookmark = Bookmark.new(bookmark_params) # the bookmark is a new book mark - strong params allow user to create the instance - POST Bookmark.new
    @bookmark.list = @list # a bookmarks list is assigned to the current instance of list
    if @bookmark.save # if the instance of bookmark created passes the validations..
      redirect_to list_path(@list) # redirect to the list show page
    else
      render 'new', status: :unprocessable_entity # new is the method - pointing you back to the new action in  controller
    end
  end


  def destroy
    @bookmark = Bookmark.find(params[:id]) # the bookmark we're looking for is the one we're currently on - although isn't this the show page??
    @list = @bookmark.list # the list we need is the one attached to our bookmarks list
    @bookmark.destroy # destroy the bookmark
    redirect_to list_path(@list), status: :see_other # redirect to the list attached to the bookmark we've just deleted
  end

  private

  def set_list
    @list = List.find(params[:list_id]) # the :list_id is in rails routes to bookmark/new - instead of params[:id]
  end

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end
