class EntryGenerator
  def initialize(progression)
    @progression = progression
  end

  def new_entry
    entry = default_entry

    if @progression.name == 'Chutes Kyokushin - HIIT (leve)'
      new_value = entry.value.clone
      new_set = (new_value['sets'] && new_value['sets'][0]) ? new_value['sets'][0].clone : {}
      new_set['execution'] = {
        type: 'list',
        values: ['Mae Geri', 'Right Mawashi Geri', 'Left Mawashi Geri', 'Ushiro Geri']
      }
      new_set.delete 'mult'
      new_value['sets'] = [new_set]
      entry.value = new_value
    end

    entry
  end

  def default_entry
    @progression.entries.any? ? @progression.entries.order('created_at DESC').last.prototype : @progression.entries.new
  end
end
