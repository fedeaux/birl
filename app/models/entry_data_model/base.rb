module EntryDataModel
  class Base
    GLOBAL_DIMENSIONS = false

    def initialize(options = {})
      @entry_data_model = {
        dimensions: self.class::DEFAULT_DIMENSIONS.clone
      }

      @entry_data_model[:global_dimensions] = self.class::GLOBAL_DIMENSIONS.clone if self.class::GLOBAL_DIMENSIONS
    end

    def entry_data_model
      @entry_data_model
    end
  end
end
