class Api::V1::GoalsController < Api::V1::ApiController
  before_action :set_goal, only: %i[show update destroy]

  def index
    @goals = current_context.goals
  end

  def show
  end

  def update
    if @goal.update(goal_params)
      render 'show', status: :ok
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def create
    @goal = current_context.goals.new goal_params
    if @goal.save
      render 'show', status: :created
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def destroy
    @goal.destroy
  end

  private

  def set_goal
    @goal = current_context.goals.find(params[:id])
  end

  def goal_params
    params.require(:goal).permit(:id, :name, :type, :user_id, :meta, :recurrence_scheme)
  end
end
