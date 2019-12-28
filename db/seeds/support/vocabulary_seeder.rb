class VocabularySeeder
  attr_accessor :kind, :contents

  def initialize(kind, contents)
    self.kind = kind
    self.contents = contents
    @line_number = 0
  end

  def seed
    @contents.split("\n").each(&method(:process_line))
  end

  private

  def process_line(line)
    @line_number += 1
    line.strip!
    return if line.blank? || line.first == '#'

    if line.first == '-'
      ensure_categories line
    elsif line.include? '=>'
      set_from_and_to line
    else
      ensure_word line
    end
  end

  def ensure_categories(line)
  end

  def set_from_and_to(line)
    @lang_from, @lang_to = line.split('=>').map(&:strip)
  end

  def ensure_word(line)
    parts = line.split '='
    parts = parts.first.split(/[\s\t]+/) if parts.count == 1

    if parts.count != 2
      puts "Error - #{kind}:#{@line_number} [#{line}]"
    else
      params = {
        kind: kind
      }

      params[@lang_from] = cleanup parts.first
      params[@lang_to] = cleanup parts.last

      Vocabulary.where(params).first_or_create
    end
  end

  def cleanup(word)
    word = word.split(/[\s\t]+/).map(&:strip).map(&:downcase).reject(&:blank?).join(' ')

    if kind == 'number'
      parts = word.split ' '
      return parts.first if parts.length == 1

      return parts[0] + ' / ' + parts[1..-1].join(' ')
    end

    word
  end
end
