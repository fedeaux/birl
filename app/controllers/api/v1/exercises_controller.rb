class Api::V1::ExercisesController < Api::V1::ApiController
  before_action :set_exercise, only: [:show, :update]

  def index
    @exercises = Exercise.all
  end

  def show
  end

  def update
    if @exercise.update(exercises_params)
      render 'show', status: :ok
    else
      render status: :unprocessable_entuty
    end
  end

  def create
    @exercise = Exercise.new exercises_params
    if @exercise.save
      render 'show', status: :created
    else
      render status: :unprocessable_entuty
    end
  end

  private

  def set_exercise
    @exercise = Exercise.find(params[:id])
  end

  def exercise_params
    params.require(:exercise).permit(:id, :name, :user_id)
  end
end
