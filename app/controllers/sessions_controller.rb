class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
      # Log the user in and redirect to the user's show page.
    else
      flash.now[:danger] = 'メールアドレス、もしくはパスワードが間違っています。' # .now => contents of flash.now disappears as soon as there is additional request
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
