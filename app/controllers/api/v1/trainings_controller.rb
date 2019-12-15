class Api::V1::TrainingsController < Api::V1::ApiController
  before_action :set_training, only: %i[show update destroy]

  def index
    @trainings = current_context.trainings
  end

  def show
  end

  def update
    if @training.update(training_params)
      render 'show', status: :ok
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def create
    @training = current_context.trainings.new training_params
    if @training.save
      render 'show', status: :created
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def destroy
    @training.destroy
  end

  private

  def set_training
    @training = current_context.trainings.find(params[:id])
  end

  def training_params
    params.require(:training).permit(:id, :name, :context_id)
  end
end
