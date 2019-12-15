class Api::V1::TrainingsController < Api::V1::ApiController
  before_action :set_training, only: %i[show update]

  def index
    @trainings = current_user.trainings
  end

  def show; end

  def update
    if @training.update(training_params)
      render 'show', status: :ok
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def create
    @training = current_user.trainings.new training_params
    if @training.save
      render 'show', status: :created
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  private

  def set_training
    @training = current_user.trainings.find(params[:id])
  end

  def training_params
    params.require(:training).permit(:id, :name, :user_id)
  end
end
