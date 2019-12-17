class Api::V1::ExercisesController < Api::V1::ApiController
  before_action :set_exercise, only: %i[show update destroy]

  def index
    @exercises = current_context.exercises
  end

  def show
  end

  def update
    if @exercise.update(exercise_params)
      render 'show', status: :ok
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def create
    @exercise = current_context.exercises.new exercise_params
    if @exercise.save
      render 'show', status: :created
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def destroy
    @exercise.destroy
  end

  private

  def set_exercise
    @exercise = current_context.exercises.find(params[:id])
  end

  def exercise_params
    params.require(:exercise).permit(:id, :name, :slug, :context_id, :group_id)
  end
end
