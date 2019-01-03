class ExercisesController < ApiController
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
    params.require(:exercise).permit(:name, :user_id)
  end
end
