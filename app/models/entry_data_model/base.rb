module EntryDataModel
  class Base
    GLOBAL_DIMENSIONS = false

    def initialize(_options = {})
      @entry_data_model = {
        dimensions: self.class::DEFAULT_DIMENSIONS.clone
      }

      @entry_data_model[:global_dimensions] = self.class::GLOBAL_DIMENSIONS.clone if self.class::GLOBAL_DIMENSIONS
    end

    attr_reader :entry_data_model
  end
end
