class Api::V1::TrainingsController < Api::V1::ApiController
  before_action :set_training, only: [:show, :update]

  def index
    @trainings = Training.all
  end

  def show
  end

  def update
    if @training.update(trainings_params)
      render 'show', status: :ok
    else
      render status: :unprocessable_entuty
    end
  end

  def create
    @training = Training.new trainings_params
    if @training.save
      render 'show', status: :created
    else
      render status: :unprocessable_entuty
    end
  end

  private

  def set_training
    @training = Training.find(params[:id])
  end

  def training_params
    params.require(:training).permit(:id, :name, :user_id)
  end
end
