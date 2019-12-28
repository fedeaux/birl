class Vocabulary < ApplicationRecord
  def self.with_params(params)
    limit = params[:limit].to_i

    groups = []
    chosen = []

    if params[:priority] == 'all'
      groups << { limit: limit }

    elsif params[:priority] == 'unprioritized'
      groups << { priority: nil, limit: limit }

    elsif params[:priority] == 'high_n_medium'
      groups << { priority: 2, limit: limit * 2 / 3 }
      groups << { priority: 1, limit: limit - (limit * 2 / 3) }

    elsif params[:priority] == 'default'
      groups << { priority: 2, limit: limit * 2 / 3 }
      groups << { priority: 1, limit: limit * 2 / 9 }
      groups << { priority: 0, limit: limit * 1 / 9 }

    elsif params[:priority].is_a? Numeric
      groups << { priority: params[:priority], limit: limit }
    else
      groups << { limit: limit }
    end

    groups.each do |group|
      vocabularies = group.key?(:priority) ? where(priority: group[:priority]) : all
      vocabularies = vocabularies.where('kind in (?)', params[:kinds]) if params[:kinds]
      vocabularies = vocabularies.order('RANDOM()') if params[:random]
      chosen.concat vocabularies.limit(group[:limit]).to_a
    end

    chosen.shuffle
  end
end
