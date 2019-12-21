class Challenge < ApplicationRecord
  belongs_to :context
  has_many :progressions, dependent: :destroy

  def entry_data_model=(param)
    param = {} unless param.is_a? Hash
    param = param.to_h.deep_symbolize_keys
    dimensions = param[:dimensions]

    dimensions = if dimensions.is_a? Hash
                   dimensions.values
                 elsif dimensions.is_a? Array
                   dimensions
                 else
                   []
                 end

    param[:dimensions] = dimensions.map { |dimension| { name: '', options: {} }.merge(dimension) }
    super param
  end
end
