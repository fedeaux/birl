class Api::V1::DaysController < Api::V1::ApiController
  before_action :set_day, only: %i[show update destroy]

  def index
    @days = current_user.days
  end

  def show
  end

  def update
    if @day.update(day_params)
      render 'show', status: :ok
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def create
    @day = current_user.days.new day_params
    if @day.save
      render 'show', status: :created
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def destroy
    @day.destroy
  end

  private

  def set_day
    @day = current_user.days.find(params[:id])
  end

  def day_params
    params.require(:day).permit(:id, :name, :stamp, :user_id, :planned, :meta)
  end
end
