class Vocabulary < ApplicationRecord
  def self.with_params(params)
    vocabularies = all

    vocabularies = vocabularies.order("RANDOM()") if params[:random]
    vocabularies = vocabularies.limit(params[:limit]) if params[:limit]

    vocabularies
  end
end
