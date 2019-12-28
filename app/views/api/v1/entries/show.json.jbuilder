json.entry do
  json.partial! 'api/v1/entries/show', entry: @entry

  json.data_model @data_model if @data_model
end
