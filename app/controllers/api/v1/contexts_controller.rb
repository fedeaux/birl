class Api::V1::ContextsController < Api::V1::ApiController
  before_action :set_context, only: %i[show update]

  def index
    @contexts = current_user.contexts
  end

  def show; end

  def update
    if @context.update(context_params)
      render 'show', status: :ok
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def create
    @context = current_user.contexts.new context_params
    if @context.save
      render 'show', status: :created
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  private

  def set_context
    @context = current_user.contexts.find(params[:id])
  end

  def context_params
    params.require(:context).permit(:id, :name, :slug, :color, :user_id, :meta)
  end
end
