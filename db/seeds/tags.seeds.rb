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

  [
    {
      name: 'chores',
      color: '#f00',
      background_color: '#F2C82E',
      children: [
        {
          name: 'acyclic',
          color: '#fff',
          background_color: '#F2C82E',
          children: []
        },
        {
          name: 'cook',
          color: '#fff',
          background_color: '#F2C82E',
          children: []
        },
        {
          name: 'market',
          color: '#fff',
          background_color: '#F2C82E',
          children: []
        },
        {
          name: 'organize',
          color: '#fff',
          background_color: '#F2C82E',
          children: []
        },
        {
          name: 'other',
          color: '#fff',
          background_color: '#F2C82E',
          children: []
        },
        {
          name: 'prepare_for_tomorrow',
          color: '#FFC902',
          background_color: '#FFF8E0',
          children: []
        }
      ]
    },
    {
      name: 'life',
      color: '#FFFFFF',
      background_color: '#64E412',
      children: [
        {
          name: 'beloveds',
          color: '#FFFFFF',
          background_color: '#E012E4',
          children: []
        },
        {
          name: 'eat',
          color: '#FFFFFF',
          background_color: '#EFAE2D',
          children: []
        },
        {
          name: 'f',
          color: '#FFFFFF',
          background_color: '#529E20',
          children: [
            {
              name: 'f5',
              color: '#FFFFFF',
              background_color: '#529E20',
              children: []
            },
            {
              name: 'fbb',
              color: '#FFFFFF',
              background_color: '#529E20',
              children: []
            }
          ]
        },
        {
          name: 'lolzinho',
          color: '#FFFFFF',
          background_color: '#659646',
          children: []
        },
        {
          name: 'mornings',
          color: '#FFFFFF',
          background_color: '#64E412',
          children: []
        },
        {
          name: 'sleep',
          color: '#FFFFFF',
          background_color: '#12C7E4',
          children: []
        }
      ]
    },
    {
      name: 'meditation',
      color: '',
      background_color: '#3DAAF6',
      children: []
    },
    {
      name: 'progressions',
      color: '#fff',
      background_color: '#000',
      children: [
        {
          name: 'draw',
          color: '#FFFFFF',
          background_color: '#B400FF',
          children: []
        },
        {
          name: 'guitar',
          color: '#FFF5F5',
          background_color: '#FF0000',
          children: []
        },
        {
          name: 'home_training',
          color: '#E1FBE6',
          background_color: '#05911B',
          children: []
        }
      ]
    },
    {
      name: 'projects',
      color: '#FFFFFF',
      background_color: '#B2B2B2',
      children: [
        {
          name: 'awesome_xml_dsl',
          color: '#FFFFFF',
          background_color: '#B2B2B2',
          children: []
        },
        {
          name: 'birl',
          color: '#FFFFFF',
          background_color: '#B2B2B2',
          children: []
        },
        {
          name: 'brain-damage',
          color: '#FFFFFF',
          background_color: '#B2B2B2',
          children: []
        },
        {
          name: 'fedeaux-mode',
          color: '#FFFFFF',
          background_color: '#B2B2B2',
          children: []
        },
        {
          name: 'house',
          color: '#FFFFFF',
          background_color: '#B2B2B2',
          children: []
        }
      ]
    },
    {
      name: 'study',
      color: '#ECF9FF',
      background_color: '#3AB8F7',
      children: [
        {
          name: 'lightless',
          color: '#DFD6EF',
          background_color: '#290864',
          children: []
        },
        {
          name: 'spanish',
          color: '#FFFFFF',
          background_color: '#D98E55',
          children: [
            {
              name: 'class',
              color: '#FFFFFF',
              background_color: '#D98E55',
              children: []
            },
            {
              name: 'headsdown',
              color: '#FFFFFF',
              background_color: '#D98E55',
              children: []
            }
          ]
        }
      ]
    },
    {
      name: 'videos',
      color: '#fff',
      background_color: '#f2a343',
      children: [
        {
          name: 'fedeaux',
          color: '#fff',
          background_color: '#f2a343',
          children: [
            {
              name: 'identity',
              color: '#fff',
              background_color: '#f2a343',
              children: []
            }
          ]
        },
        {
          name: 'politics',
          color: '#fff',
          background_color: '#f2a343',
          children: [
            {
              name: 'bandido-bom',
              color: '#fff',
              background_color: '#f2a343',
              children: []
            }
          ]
        },
        {
          name: 'science',
          color: '#fff',
          background_color: '#f2a343',
          children: [
            {
              name: 'evolution',
              color: '#fff',
              background_color: '#f2a343',
              children: []
            }
          ]
        }
      ]
    },
    {
      name: 'work',
      color: '#000000',
      background_color: '#ECECEC',
      children: [
        {
          name: 'runa',
          color: '#FFFFFF',
          background_color: '#7A6FF0',
          children: [
            {
              name: 'frontend_architecture',
              color: '#FFFFFF',
              background_color: '#6F88F0',
              children: []
            },
            {
              name: 'issues',
              color: '#FFFFFF',
              background_color: '#7A6FF0',
              children: []
            },
            {
              name: 'meeting',
              color: '#FFFFFF',
              background_color: '#7A6FF0',
              children: []
            },
            {
              name: 'other',
              color: '#FFFFFF',
              background_color: '#8276FF',
              children: []
            },
            {
              name: 'qa_automation',
              color: '#FFFFFF',
              background_color: '#A26FF0',
              children: []
            },
            {
              name: 'squad_ron',
              color: '#FFFFFF',
              background_color: '#7066E0',
              children: []
            }
          ]
        }
      ]
    }
  ].each do |tag_attr|
    create_tag user, tag_attr
  end
end
