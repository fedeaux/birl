class Api::V1::SessionsController < Api::V1::ApiController
  before_action :set_session, only: %i[show update]

  def index
    @sessions = current_context.current_training.sessions.order(:weekday)
  end

  def today
    @sessions = current_context.current_training.sessions
    render 'index'
    # TODO
    # @session = current_context.current_session

    # if @session
    #   render 'show'
    # else
    #   head 404
    # end
  end

  def show; end

  def update
    if @session.update(session_params)
      render 'show', status: :ok
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def create
    @session = current_context.sessions.new session_params
    if @session.save
      render 'show', status: :created
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  private

  def set_session
    @session = current_context.current_training.sessions.find(params[:id])
  end

  def session_params
    params.require(:session).permit(:id, :name, :training_id)
  end
end
