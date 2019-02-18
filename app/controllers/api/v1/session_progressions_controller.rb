class Api::V1::SessionProgressionsController < Api::V1::ApiController
  before_action :set_session_progression, only: [:show, :update]

  def index
    @session_progressions = current_user.session_progressions
  end

  def show
  end

  def update
    if @session_progression.update(session_progression_params)
      render 'show', status: :ok
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def create
    @session_progression = current_user.session_progressions.new session_progression_params
    if @session_progression.save
      render 'show', status: :created
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  private

  def set_session_progression
    @session_progression = current_user.session_progressions.find(params[:id])
  end

  def session_progression_params
    params.require(:session_progression).permit(:id, :session_id, :progression_id, :order)
  end
end
