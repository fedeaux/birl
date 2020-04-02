class Api::V1::WeeksController < Api::V1::ApiController
  before_action :set_week, only: %i[show update destroy]

  def index
    @weeks = current_context.weeks
  end

  def show
  end

  def update
    if @week.update(week_params)
      render 'show', status: :ok
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def create
    @week = current_context.weeks.new week_params
    if @week.save
      render 'show', status: :created
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def destroy
    @week.destroy
  end

  private

  def set_week
    @week = current_context.weeks.find(params[:id])
  end

  def week_params
    params.require(:week).permit(:id, :name, :stamp, :user_id, :meta)
  end
end
