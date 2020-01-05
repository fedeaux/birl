after(:users) do
  def create_tag(user, tag_attr, parent = nil)
    tag_attr = { name: tag_attr } unless tag_attr.is_a?(Hash)

    name = tag_attr[:name]
    tag = (parent ? parent.children : Tag).where(name: name, user: user).first_or_initialize
    tag.assign_attributes(tag_attr.except(:children))
    tag.save

    if tag_attr[:children]
      tag_attr[:children].each do |child_tag_attr|
        create_tag user, child_tag_attr, tag
      end
    end
  end

  user = User.find_by(email: 'phec06@gmail.com')

  [{
     name: 'Work',
     children: [
       {
         name: 'Runa',
         children: ['Issues', 'Meeting']
       }
     ]
   }, {
     name: 'Videos',
     children: [
       {
         name: 'Politics',
         children: ['Bandido Bom']
       }
     ]
   }].each do |tag_attr|
    create_tag user, tag_attr
  end
end
