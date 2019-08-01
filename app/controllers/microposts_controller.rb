class MicropostsController < ApplicationController
  def create
    @micropost = current_user.microposts.build(micropost_params)

    if @micropost.save
      redirect_to root_url
    else
      # home_feed view needs this variable, to display microposts
      @microposts = current_user.feed.paginate(page: params[:page], per_page: 10)
      render 'users/home_feed'
    end
  end

  def destroy
    @micropost = Micropost.find(params[:id])
    @micropost.destroy

    redirect_to root_url
  end

  private
    def micropost_params
      params.require(:micropost).permit(:content, :picture)
    end
end
