class Api::V1::SessionsController < Api::V1::ApiController
  before_action :set_session, only: [:show, :update]

  def index
    @sessions = current_user.current_training.sessions
  end

  def today
    weekday = Date.today.wday
    @session = current_user.current_training.sessions.where(weekday: weekday).first
    render 'show'
  end

  def show
  end

  def update
    if @session.update(session_params)
      render 'show', status: :ok
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def create
    @session = current_user.sessions.new session_params
    if @session.save
      render 'show', status: :created
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  private

  def set_session
    @session = current_user.current_training.sessions.find(params[:id])
  end

  def session_params
    params.require(:session).permit(:id, :name, :training_id)
  end
end
