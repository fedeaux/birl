class Api::V1::VocabulariesController < Api::V1::ApiController
  before_action :set_vocabulary, only: %i[show update destroy]

  def index
    if params[:random] || params[:limit]
      @vocabularies = Vocabulary.with_params params.permit!.to_h
    else
      @vocabularies = Vocabulary.all.order(:kind, :pt_br)
    end
  end

  def show; end

  def update
    if @vocabulary.update(vocabulary_params)
      render 'show', status: :ok
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def create
    @vocabulary = Vocabulary.new vocabulary_params
    if @vocabulary.save
      render 'show', status: :created
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def destroy
    @vocabulary.destroy
  end

  private

  def set_vocabulary
    @vocabulary = Vocabulary.find(params[:id])
  end

  def vocabulary_params
    params.require(:vocabulary).permit!
  end
end
