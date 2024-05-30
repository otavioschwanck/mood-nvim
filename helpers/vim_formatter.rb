# frozen_string_literal: true

class VimFormatter
  RSpec::Core::Formatters.register self, :example_failed, :close

  def initialize(output)
    @output = output
  end

  def example_failed(notification)
    @output << format(notification) + "\n"
  end

  def close(notification)
    @output << "finished\n"
  end

  private

  def format(notification)
    example_location = notification.example.location
    expect_location = extract_expect_location(notification.exception.backtrace, example_location)

    message = notification.exception.message.gsub("\n", "\\n")

    backtraces = find_backtrace(notification.exception.backtrace, example_location, expect_location)

    if backtraces.any?
      message = "#{message}\\n\\nBacktrace:\\n#{backtraces[0..7].join("\\n")}"
    end

    message = message.gsub(/\e\[\d+m/, '')

    rtn = "%s: %s" % [expect_location || example_location, message]
    rtn.gsub("\n", ' ')
  end

  def find_backtrace(backtrace, example_location, expect_location)
    if example_location[0..1] == "./"
      example_location = example_location[2..]
    end

    example_location_line = example_location.split(':').last
    example_location_file = example_location.split(':').first

    expect_location_line = nil

    if expect_location
      expect_location = expect_location[2..] if expect_location[0..1] == "./"

      expect_location_line = expect_location.split(':').last
    end

    project_dir = Dir.pwd

    backtrace_filtered = backtrace.select do |line|
      line.include?(project_dir)
    end

    project_backtraces = backtrace_filtered.select do |line|
      line_number = line.split(':')[1]
      path = line.split(':')[0]

      if (line_number.to_i == example_location_line.to_i || line_number.to_i == expect_location_line.to_i) && path.include?(example_location_file)
        false
      else
        true
      end
    end

    project_backtraces
  rescue StandardError => e
    []
  end

  def extract_expect_location(backtrace, example_location)
    if example_location[0..1] == "./"
      example_location = example_location[2..]
    end

    example_location_line = example_location.split(':').last
    example_location_file = example_location.split(':').first

    backtrace_lines = backtrace.select { |line| line.include?(example_location_file) }

    return nil if backtrace_lines.empty?

    sorted_backtrace_lines = backtrace_lines.sort do |a, b|
      a.split(':')[1].to_i <=> b.split(':')[1].to_i
    end

    backtrace_line = sorted_backtrace_lines.select { |line| line.split(':')[1].to_i > example_location_line.to_i }.first

    return nil unless backtrace_line

    example_file = example_location.split(':').first

    match = backtrace_line.match(/(.+_spec\.rb):(\d+)/)
    return nil unless match

    backtrace_file = match[1]
    backtrace_line_number = match[2]

    if File.basename(example_file) == File.basename(backtrace_file)
      relative_path = Pathname.new(backtrace_file).relative_path_from(Pathname.new(Dir.pwd)).to_s
      "#{relative_path}:#{backtrace_line_number}"
    end
  rescue StandardError => e
    # do nothing
  end
end
