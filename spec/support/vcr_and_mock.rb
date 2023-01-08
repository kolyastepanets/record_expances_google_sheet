require 'webmock/rspec'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = Rails.root.join('spec/vcr_cassets').to_s

  c.preserve_exact_body_bytes do |http_message|
     http_message.body.encoding.name == 'ASCII-8BIT' || !http_message.body.valid_encoding?
   end

  c.default_cassette_options = {
    serialize_with: :json,

    record: ENV["VCR_RE_RECORD"] ? :once : :none,

    match_requests_on: [:method, :uri, :body],
  }

  c.hook_into :webmock

  c.ignore_localhost = true

  c.configure_rspec_metadata!

  c.register_request_matcher :telegram_get_file_custom_matcher do |r1, r2|
    r1.body.split(/file_/)[0] == r2.body.split(/file_/)[0]
  end

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
