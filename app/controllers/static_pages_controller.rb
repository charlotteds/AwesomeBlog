class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = Micropost.new
      @microposts = current_user.feed.paginate(page: params[:page], per_page: 10)
      render 'users/home_feed'
    end
  end

  def about
  end
end
