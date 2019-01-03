class TrainingSessionsController < ApiController
  def index
    @training_sessions = TrainingSession.all
  end

  def show
  end

  def update
    if @training_session.update(training_sessions_params)
      render 'show', status: :ok
    else
      render status: :unprocessable_entuty
    end
  end

  def create
    @training_session = TrainingSession.new training_sessions_params
    if @training_session.save
      render 'show', status: :created
    else
      render status: :unprocessable_entuty
    end
  end

  private

  def set_training_session
    @training_session = TrainingSession.find(params[:id])
  end

  def training_session_params
    params.require(:training_session).permit(:name, :user_id)
  end
end
