class Api::V1::SessionsController < Api::V1::ApiController
  before_action :set_session, only: %i[destroy show update]

  def index
    @sessions = current_context.current_training.sessions.order(:weekday)
  end

  def todays
    todays_things_by_context = []

    current_user.contexts.order(:name).each do |context|
      todays_things_by_context.push(context.todays_things)
    end

    render json: { things_by_context: todays_things_by_context }
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
    @session = current_context.current_training.sessions.new session_params

    if @session.save
      render 'show', status: :created
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def destroy
    @session.destroy
  end

  private

  def set_session
    @session = current_context.current_training.sessions.find(params[:id])
  end

  def session_params
    params.require(:session).permit(:id, :name, :training_id)
  end
end
