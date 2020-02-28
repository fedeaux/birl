class Api::V1::TimelogsController < Api::V1::ApiController
  before_action :set_timelog, only: %i[show update destroy]

  def index
    @timelogs = current_user.timelogs

    if params[:from] && params[:to]
      @timelogs = @timelogs.in_range(DateTime.parse(params[:from]), DateTime.parse(params[:to]))
    end
  end

  def plan_my_day
    DayBuilder::Day.new(current_user, plan_my_day_params).build

    head 200
  end

  def show
  end

  def update
    if @timelog.update(timelog_params)
      render 'show', status: :ok
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def create
    @timelog = current_user.timelogs.new timelog_params
    if @timelog.save
      render 'show', status: :created
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def destroy
    @timelog.destroy
  end

  private

  def set_timelog
    @timelog = current_user.timelogs.find(params[:id])
  end

  def timelog_params
    params.require(:timelog).permit(:id, :start, :finish, :description, :meta, main_tag: [:id])
  end

  def plan_my_day_params
    params.permit(:start)
  end
end
