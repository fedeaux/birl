after(:users) do
  User.find_each do |user|
    [
      {
        name: 'Bodybuilding',
        color: '#016936'
      },
      {
        name: 'Music',
        color: '#DB2828'
      },
    ].each do |context_attrs|
      slug = context_attrs[:name].parameterize
      context = user.contexts.find_or_initialize_by(slug: slug)
      context.assign_attributes context_attrs
      context.save
    end
  end
end
