json.entry do
  json.partial! 'api/v1/entries/show', entry: @entry

  if @data_model
    json.data_model @data_model
  end
end
