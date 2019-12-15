class Api::V1::ProfileController < Api::V1::ApiController
  before_action :set_user, only: %i[show update]

  def show; end

  def update
    if @user.update(user_params)
      render 'api/v1/users/show', status: :ok
    else
      render 'api/v1/users/show', status: :unprocessable_entuty
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:current_context_id)
  end
end
