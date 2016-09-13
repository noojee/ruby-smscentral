require 'smscentral/version'
require 'smscentral/api_version'
require 'rest-client'

RESPONSE_REGEXP = Regexp.new('^(?<code>[0-9]+) (?<message>.*)$')

# Smscentral REST client
class Smscentral
  # @param [String] username
  # @param [String] password
  # @api public
  def initialize(username, password)
    @username = username
    @password = password
    @uri = "https://my.smscentral.com.au/api/#{API_VERSION}"
  end

  # @param [String] originator may be a phone number, alphanumeric, or the
  # special values 'shared' or 'dedicated'.  See the documentation at:
  # http://www.smscentral.com.au/sms-api/rest-api/
  # @param [String] recipeient must be a phone number, recommended to use
  # international format (ie - 61412341234)
  # @param [String] message_text is the text body.  Messages longer than
  # 160 characters will be split into multiple messages.
  # @return [Hash] contains a response :code [Int] and :message [String]
  # @api public
  def send(originator, recipient, message_text)
    response = RestClient.post(@uri, {
      :USERNAME => @username,
      :PASSWORD => @password,
      :ACTION => 'send',
      :ORIGINATOR => originator,
      :RECIPIENT => recipient,
      :MESSAGE_TEXT => message_text,
    })
    if response.body == '0'
      return {
        :code => 0,
        :message => 'Success',
      }
    end
    result = RESPONSE_REGEXP.match(response.body)
    raise IOError, "Unprocessable response from SMS Central: #{response}" if result.nil?
    return {
      :code => result[:code].to_i,
      :message => result[:message],
    }
  end
end
