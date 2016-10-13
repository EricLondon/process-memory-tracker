class ProcessMemoryService
  PSLine = Struct.new(:pid, :ppid, :rss, :command)

  def initialize
    @process_properties = ProcessProperty.all
    raise 'No processes to monitor.' if @process_properties.blank?
  end

  def run
    loop do
      @process_properties.each do |process_property|
        output = execute_grep(process_property)
        data = extract_data_from_output(output)
        process_property.process_memory_items.create! memory: combine_data(data)
      end
      sleep 1.minute
    end
  end

  private

  def combine_data(data)
    data.map(&:rss).sum
  end

  def execute_grep(process_property)
    command = "ps ax -o pid,ppid,rss,command | egrep -i \"#{process_property.grep_name}\""
    `#{command}`.strip.split("\n")
  end

  def extract_data_from_output(output)
    return [] if output.blank?
    output.map { |line| split_line(line) }
  end

  def split_line(line)
    data = line.match /^(\d+)\s+(\d+)\s+(\d+)\s+(.*)$/
    PSLine.new(data[1].to_i, data[2].to_i, data[3].to_i * 1024, data[4])
  end
end
