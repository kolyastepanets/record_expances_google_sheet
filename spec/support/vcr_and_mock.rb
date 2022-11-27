# require 'webmock/rspec'
require 'webmock/rspec'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = Rails.root.join('spec/vcr_cassets').to_s

  c.default_cassette_options = {
    serialize_with: :json,

    record: ENV["VCR_RECORD"] || ENV["VCR_RE_RECORD"] ? :once : :none,

    match_requests_on: [:method, :uri, :body],
  }

  c.hook_into :webmock

  # all localhost connections is either database
  # or elastic search connection which we should ignore
  c.ignore_localhost = true
  c.ignore_hosts 'elasticsearch', 'postgres', 'redis', 'shiphawk-sh_elasticsearch', 'open.mapquestapi.com', 'ubuntu'

  c.configure_rspec_metadata!

  # uncomment to see what vcr does
  # c.debug_logger = STDERR
end

if ENV["VCR_RE_RECORD"]
  module CassetteReRecord
    def insert_cassette(name, options = {})
      c = VCR::Cassette.new(name, options)
      if File.exist?(c.file)
        puts "-" * 80
        puts "Removing cassette:\n#{c.file}"
        puts "-" * 80
        puts "\n"
        File.delete(c.file)
      end
      super(name, options)
    end
  end
  VCR.extend(CassetteReRecord)
end
