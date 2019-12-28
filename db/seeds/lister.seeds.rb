after(:users) do
  [
    ['Cool Moves', ['Bananeira', 'Estrela', 'Levantar Bananeira', 'Macaquinho']],
    ['Musical Intervals', ['2m', '2M', '3m', '3M', '4J', '4#', '5J', '6m', '6M', '7m', '7M', '8J']],
    ['Vocal Regions', ['edge lows', 'lows', 'transition', 'highs', 'edge highs']]
  ].each do |params|
    lister = Lister.where(name: params[0]).first_or_initialize
    lister.update(values: { items: params[1] })
  end
end
