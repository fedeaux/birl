class Api::V1::EntriesController < Api::V1::ApiController
  before_action :set_entry, only: [:show, :update, :destroy]

  def index
    return unless params[:progression_id]
    @entries = Entry.where(progression_id: params[:progression_id]).order('created_at DESC')
  end

  def show
  end

  def update
    if @entry.update(entry_params)
      render 'show', status: :ok
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def create
    @entry = Entry.new entry_params
    if @entry.save
      render 'show', status: :created
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def destroy
    @entry.destroy
  end

  private

  def set_entry
    @entry = Entry.find(params[:id])
  end

  def entry_params
    params.require(:entry).permit(:id, :name, :progression_id, :values, :variables, :observations)
  end
end
