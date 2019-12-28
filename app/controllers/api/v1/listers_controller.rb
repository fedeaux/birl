class Api::V1::ListersController < Api::V1::ApiController
  before_action :set_lister, only: %i[show update destroy]

  def index
    @listers = Lister.all.order :name
  end

  def show; end

  def update
    if @lister.update(lister_params)
      render 'show', status: :ok
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def create
    @lister = Lister.new lister_params
    if @lister.save
      render 'show', status: :created
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def destroy
    @lister.destroy
  end

  private

  def set_lister
    @lister = Lister.find(params[:id])
  end

  def lister_params
    params.require(:lister).permit!
  end
end
