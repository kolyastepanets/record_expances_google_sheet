module ApiGoogleVision
  class GoogleVisionBase
    include CallableService

    SCOPE = 'https://www.googleapis.com/auth/cloud-vision'.freeze

    def call
      prepare_request_data
      make_request
      parse_response
    end

    private

    def prepare_request_data
      @request = Google::Apis::VisionV1::BatchAnnotateImagesRequest.new(
        requests: [
          {
            image: {
              # content: Faraday.new(url: url).get.body
              # content: File.read('public/out.jpg')
              content: @image
            },
            features: [
              {
                type: "TEXT_DETECTION" ,
                maxResults: 1
              }
            ]
          }
        ]
      )
    end

    def make_request
      @response = service_vision.annotate_image(@request)
    end

    def parse_response
      raise NoImplementedError
    end

    def service_vision
      return @service_vision if defined? @service_vision

      json_key_hash = {
        "type" => ENV['GOOGLE_TYPE'],
        "project_id" => ENV['GOOGLE_PROJECT_ID'],
        "private_key_id" => ENV['GOOGLE_PRIVATE_KEY_ID'],
        "private_key" => Base64.urlsafe_decode64(ENV['GOOGLE_PRIVATE_KEY']),
        "client_email" => ENV['GOOGLE_CLIENT_EMAIL'],
        "client_id" => ENV['GOOGLE_CLIENT_ID'],
        "auth_uri" => ENV['GOOGLE_AUTH_URI'],
        "token_uri" => ENV['GOOGLE_TOKEN_URI'],
        "auth_provider_x509_cert_url" => ENV['GOOGLE_AUTH_PROVIDER'],
        "client_x509_cert_url" => ENV['GOOGLE_CLIENT_CERT_URL']
      }
      @service_vision = ::Google::Apis::VisionV1::VisionService.new
      @service_vision.authorization = Google::Auth::ServiceAccountCredentials.make_creds(
        json_key_io: StringIO.new(json_key_hash.to_json),
        scope: SCOPE
      )
      @service_vision.authorization.fetch_access_token!
      @service_vision
    end
  end
end
