class Api::V1::<%= controller_name %> < Api::V1::ApiController
  before_action :set_<%= underscore_name %>, only: %i[show update destroy]

  def index
    @<%= plural_underscore_name %> = current_context.<%= plural_underscore_name %>
  end

  def show
  end

  def update
    if @<%= underscore_name %>.update(<%= underscore_name %>_params)
      render 'show', status: :ok
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def create
    @<%= underscore_name %> = current_context.<%= plural_underscore_name %>.new <%= underscore_name %>_params
    if @<%= underscore_name %>.save
      render 'show', status: :created
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def destroy
    @<%= underscore_name %>.destroy
  end

  private

  def set_<%= underscore_name %>
    @<%= underscore_name %> = current_context.<%= plural_underscore_name %>.find(params[:id])
  end

  def <%= underscore_name %>_params
    params.require(:<%= underscore_name %>).permit(:id, <%= attributes_as_symbol_list %>)
  end
end
