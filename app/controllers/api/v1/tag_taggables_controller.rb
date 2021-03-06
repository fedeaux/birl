class Api::V1::TagTaggablesController < Api::V1::ApiController
  before_action :set_tag_taggable, only: %i[show update destroy]

  def index
    @tag_taggables = current_user.tag_taggables
  end

  def batch_ensure_tags
    params['taggables'].values.each do |taggable_params|
      params['tags_ids'].each do |tag_id|
        TagTaggable.where(tag_id: tag_id,
                          taggable_id: taggable_params['id'],
                          taggable_type: taggable_params['type']).first_or_create
      end
    end
  end

  def show
  end

  def update
    if @tag_taggable.update(tag_taggable_params)
      render 'show', status: :ok
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def create
    @tag_taggable = current_user.tag_taggables.new tag_taggable_params
    if @tag_taggable.save
      render 'show', status: :created
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def destroy
    @tag_taggable.destroy
  end

  private

  def set_tag_taggable
    @tag_taggable = current_user.tag_taggables.find(params[:id])
  end

  def tag_taggable_params
    params.require(:tag_taggable).permit(:id, :taggable_id, :tag_id)
  end
end
