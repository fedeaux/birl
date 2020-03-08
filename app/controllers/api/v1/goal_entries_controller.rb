class Api::V1::GoalEntriesController < Api::V1::ApiController
  before_action :set_goal_entry, only: %i[show update destroy]

  def index
    @goal_entries = current_context.goal_entries
  end

  def show
  end

  def update
    if @goal_entry.update(goal_entry_params)
      render 'show', status: :ok
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def create
    @goal_entry = current_context.goal_entries.new goal_entry_params
    if @goal_entry.save
      render 'show', status: :created
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def destroy
    @goal_entry.destroy
  end

  private

  def set_goal_entry
    @goal_entry = current_context.goal_entries.find(params[:id])
  end

  def goal_entry_params
    params.require(:goal_entry).permit(:id, :name, :goal_id, :start, :finish, :meta)
  end
end
