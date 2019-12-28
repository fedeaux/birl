# require 'listen'

class Bambamzer
  def initialize
    @files = {}
    listener = Listen.to('.') do |modified, _added, _removed|
      read unless modified.select { |name| name.split('/').last.strip == 'bambamzer.txt' }.empty?
    end

    listener.start # not blocking
    read
    sleep
  end

  def read
    File.read('bambamzer.txt').split("\n").map(&:strip).reject(&:empty?).each do |line|
      parts = line.split(/\s+/).map(&:strip)

      last = @files[parts.first]
      start = parts[1].to_f
      finish = parts[2].to_f

      unless last && last[:start] == start && last[:finish] == finish
        @files[parts.first] = { start: start, finish: finish }
        process(parts.first)
      end
    end
  end

  def process(name)
    `rm #{name}.mp3`
    start = @files[name][:start]
    duration = @files[name][:finish] - start
    cmd = "ffmpeg -ss #{start} -t #{duration} -i bambam.mp3 -acodec copy #{name}.mp3"
    puts cmd
    `#{cmd}`
    # `ffplay #{name}.mp3`
  end
end

# Bambamzer.new
