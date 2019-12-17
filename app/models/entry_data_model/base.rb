module EntryDataModel
  class Base

    def initialize(options = {})
      @entry_data_model = {
        dimensions: self.class::DEFAULT_DIMENSIONS.clone
      }
    end

    def entry_data_model
      @entry_data_model
    end
  end
end
