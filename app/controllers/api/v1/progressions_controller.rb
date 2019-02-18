class Api::V1::ProgressionsController < Api::V1::ApiController
  before_action :set_progression, only: [:show, :update]

  def index
    @progressions = current_user.progressions
    return unless params[:exercise_id]
    @progressions = @progressions.where(exercise_id: params[:exercise_id])
  end

  def show
  end

  def update
    if @progression.update(progression_params)
      render 'show', status: :ok
    else
      render status: :unprocessable_entuty
    end
  end

  def create
    @progression = Progression.new progression_params
    if @progression.save
      render 'show', status: :created
    else
      render status: :unprocessable_entuty
    end
  end

  private

  def set_progression
    @progression = Progression.find(params[:id])
  end

  def progression_params
    params.require(:progression).permit(:id, :name, :details, :user_id, :challenge_id, :exercise_id, :last_entry_at)
  end
end
