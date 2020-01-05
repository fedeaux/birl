class Api::V1::TagsController < Api::V1::ApiController
  before_action :set_tag, only: %i[show update destroy]

  def index
    @tags = current_user.tags.roots
  end

  def show
  end

  def update
    if @tag.update(tag_params)
      render 'show', status: :ok
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def create
    @tag = current_user.tags.new tag_params
    if @tag.save
      render 'show', status: :created
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def destroy
    @tag.destroy
  end

  private

  def set_tag
    @tag = current_user.tags.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:id, :name, :color, :background_color, :parent_id, :meta)
  end
end
