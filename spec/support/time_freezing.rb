# HOW TO:
# freezed_time accepts 'iso8601' format (short and long)
#
# EXAMPLE:
# context "#find_rates", freezed_time: "2019-02-23T12:57:29-08:00" do
#   ...
# end

require 'timecop'

RSpec.configure do |config|
  config.around :each, :freezed_time do |example|
    time = example.metadata.fetch(:freezed_time)

    parsed_time = time_parser(time)

    Timecop.freeze(parsed_time) do
      # time zone setting needed in order to
      # all vcr cassettes, recorded with freezed time,
      # have same time offset (00:00) all over the world, so tests can pass both in USA and Australia
      @_system_tz = ENV.fetch('TZ', nil)
      ENV['TZ'] = 'UTC'

      example.run

      ENV['TZ'] = @_system_tz
    end
  end

  def time_parser(time)
    long_pattern = '%Y-%m-%dT%H:%M:%S%z'

    Time.strptime(time, long_pattern)
  rescue StandardError
    short_pattern = '%Y-%m-%d'
    time = Date.strptime(time, short_pattern).strftime(long_pattern)

    retry
  rescue StandardError # rubocop:disable Lint/DuplicateRescueException
    raise 'freezed_time must be in iso8601. Formats like: 2019-02-23 or 2019-02-23T12:57:29-08:00'
  end
end
