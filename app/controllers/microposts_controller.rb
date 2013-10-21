class MicropostsController < ApplicationController

  before_filter :authenticate

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      redirect_to user_path(current_user), :flash => { :success => "Micropost saved"}
    else
      render 'pages/home'
    end
  end

  def destroy

  end

end