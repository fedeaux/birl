class Api::V1::ProgressionsController < Api::V1::ApiController
  before_action :set_progression, only: [:show, :update]

  def index
    @progressions = current_user.progressions

    if params[:exercise_id]
      @progressions = @progressions.where(params.permit(:exercise_id))
    end
  end

  def show
  end

  def update
    if @progression.update(progressions_params)
      render 'show', status: :ok
    else
      render status: :unprocessable_entuty
    end
  end

  def create
    @progression = Progression.new progressions_params
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
    params.require(:progression).permit(:id, :name, :user_id, :challenge_id, :exercise_id, :last_entry_at, :details)
  end
end
