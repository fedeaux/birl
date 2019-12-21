class Lister < ApplicationRecord
  def values=(param)
    param = {} unless param.is_a? Hash
    param.deep_symbolize_keys
    items = param[:items]

    items = if items.is_a? Hash
             items.values
           elsif items.is_a? Array
             items
           else
             []
           end

    param[:items] = items.map(&:strip).reject(&:blank?)
    super param
  end
end
