class Api::V1::GroupsController < Api::V1::ApiController
  before_action :set_group, only: [:show, :update]

  def index
    @groups = current_user.groups
  end

  def show
  end

  def update
    if @group.update(group_params)
      render 'show', status: :ok
    else
      render status: :unprocessable_entuty
    end
  end

  def create
    @group = Group.new group_params
    if @group.save
      render 'show', status: :created
    else
      render status: :unprocessable_entuty
    end
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:id, :name)
  end
end
