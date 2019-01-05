class Api::V1::SessionsController < Api::V1::ApiController
  before_action :set_session, only: [:show, :update]

  def index
    @sessions = Session.all
  end

  def show
  end

  def update
    if @session.update(sessions_params)
      render 'show', status: :ok
    else
      render status: :unprocessable_entuty
    end
  end

  def create
    @session = Session.new sessions_params
    if @session.save
      render 'show', status: :created
    else
      render status: :unprocessable_entuty
    end
  end

  private

  def set_session
    @session = Session.find(params[:id])
  end

  def session_params
    params.require(:session).permit(:id, :name, :training_id)
  end
end
