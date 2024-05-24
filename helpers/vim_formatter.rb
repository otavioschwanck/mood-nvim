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
    rtn = "%s: %s" % [notification.example.location, notification.exception.message.gsub("\n", "\\n")]
    rtn.gsub("\n", ' ')
  end
end
