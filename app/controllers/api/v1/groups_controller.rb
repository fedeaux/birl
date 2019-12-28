class Api::V1::GroupsController < Api::V1::ApiController
  before_action :set_group, only: %i[show update destroy]

  def index
    @groups = current_context.groups
  end

  def show; end

  def update
    if @group.update(group_params)
      render 'show', status: :ok
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def create
    @group = current_context.groups.new group_params
    if @group.save
      render 'show', status: :created
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def destroy
    @group.destroy
  end

  private

  def set_group
    @group = current_context.groups.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:id, :name, :context_id)
  end
end
