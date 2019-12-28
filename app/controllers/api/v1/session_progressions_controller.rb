class Api::V1::SessionProgressionsController < Api::V1::ApiController
  before_action :set_session_progression, only: %i[show update destroy]

  def index
    return unless params[:session_id]

    @session_progressions = SessionProgression.where(session_id: params[:session_id]).order(:order)
  end

  def show; end

  def update
    if @session_progression.update(session_progression_params)
      render 'show', status: :ok
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def create
    @session_progression = SessionProgression.new session_progression_params

    if @session_progression.save
      render 'show', status: :created
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def destroy
    @session_progression.destroy
  end

  private

  def set_session_progression
    @session_progression = SessionProgression.find params[:id]
  end

  def session_progression_params
    params.require(:session_progression).permit(:id, :session_id, :progression_id, :order)
  end
end
