module ApiGoogleSheet
  class GetOrSetDataInGoogleSheetBase
    include CallableService

    VALUE_INPUT_OPTION = 'USER_ENTERED'.freeze
    SCOPE = 'https://www.googleapis.com/auth/spreadsheets'.freeze
    FIN_PLAN_SPREAD_SHEET_ID = '1-pLYGFJzcLh9DJHpC0vaP9sEbfAZk5dFZeOP7B9SmAg'.freeze

    def call
      prepare_request_data
      make_request
      parse_response
    end

    private

    def prepare_request_data
      @range = "#{Date.today.year}!A#{start_line_to_search}:CJ#{end_line_to_search}"
    end

    def make_request
      @response = service_google_sheet.get_spreadsheet_values(FIN_PLAN_SPREAD_SHEET_ID, @range)
    end

    def parse_response
      raise NoImplementedError
    end

    def find_by_word
      raise NoImplementedError
    end

    def start_line_to_search
      60
    end

    def end_line_to_search
      100
    end

    def next_index_value_to_find
      1
    end

    def balance_to_return
      index_column_to_remember = 0
      balance_to_return = 0

      @response.values.each do |value_array|
        value_array.each_with_index do |value, index|
          if value == Date.today.month.to_s
            index_column_to_remember = index
          end
          break if !index_column_to_remember.zero?
        end
      end

      index_value_to_find = index_column_to_remember + next_index_value_to_find

      @response.values.each do |value_array|
        value_array.each do |value|
          if value == find_by_word
            balance_to_return = value_array[index_value_to_find]
          end
          break if balance_to_return.is_a?(String)
        end
      end

      balance_to_return
    end

    def service_google_sheet
      return @service_google_sheet if defined? @service_google_sheet

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
      @service_google_sheet = ::Google::Apis::SheetsV4::SheetsService.new
      @service_google_sheet.authorization = Google::Auth::ServiceAccountCredentials.make_creds(
        json_key_io: StringIO.new(json_key_hash.to_json),
        scope: SCOPE
      )
      @service_google_sheet.authorization.fetch_access_token!
      @service_google_sheet
    end
  end
end
