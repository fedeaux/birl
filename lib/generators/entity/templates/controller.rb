class Api::V1::<%= controller_name %> < Api::V1::ApiController
  before_action :set_<%= underscore_name %>, only: [:show, :update]

  def index
    @<%= plural_underscore_name %> = <%= entity_name %>.all
  end

  def show
  end

  def update
    if @<%= underscore_name %>.update(<%= plural_underscore_name %>_params)
      render 'show', status: :ok
    else
      render status: :unprocessable_entuty
    end
  end

  def create
    @<%= underscore_name %> = <%= entity_name %>.new <%= plural_underscore_name %>_params
    if @<%= underscore_name %>.save
      render 'show', status: :created
    else
      render status: :unprocessable_entuty
    end
  end

  private

  def set_<%= underscore_name %>
    @<%= underscore_name %> = <%= entity_name %>.find(params[:id])
  end

  def <%= underscore_name %>_params
    params.require(:<%= underscore_name %>).permit(:id, <%= attributes_as_symbol_list %>)
  end
end
