class SessionsController < ApplicationController



  def new
  end

  def create
    author = Author.find_by_email(params[:email])
    if author && author.authenticate(params[:password])
      session[:user_id] = author.id
      redirect_to root_path, notice: "You have successfully logged in"
    else
      flash.now[:alert] = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "Logged out, have a nice day!"
  end

  def add_author
    @new_author = Author.new(author_params)
  end
end
