class Api::V1::MemesController < Api::V1::ApiController
  before_action :set_meme, only: %i[show update destroy]

  def index
    @memes = current_user.memes
  end

  def show
  end

  def update
    if @meme.update(meme_params)
      render 'show', status: :ok
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def create
    @meme = current_user.memes.new meme_params
    if @meme.save
      render 'show', status: :created
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def destroy
    @meme.destroy
  end

  private

  def set_meme
    @meme = current_user.memes.find(params[:id])
  end

  def meme_params
    params.require(:meme).permit!
  end
end
