require "bbr/version"
require 'active_support/all'
require 'net/http'
require 'nokogiri'
require 'bbr/get_id_from_address'
require 'bbr/get_building_data_from_id'

module BBR
  class << self
    attr_accessor :username, :password
  end

  def self.building_data_from_address(address)
    building_data_from_bbr_id(bbr_id_from_address(address))
  end

  def self.raw_building_data_from_address(address)
    raw_building_data_from_bbr_id(bbr_id_from_address(address))
  end

  def self.bbr_id_from_address(address)
    BBR::GetIdFromAddress.call(address)
  end

  def self.building_data_from_bbr_id(id)
    BBR::GetBuildingDataFromId.call(id)
  end

  def self.raw_building_data_from_bbr_id(id)
    BBR::GetBuildingDataFromId.raw_call(id)
  end

private
  def request(action, body)
    response = nil

    3.times do
      begin
        response = Timeout.timeout(5) { formatted_xml_response(http.post(uri.path, xml(body), headers(action))) }
      rescue
        puts "SOAP-action failed: #{ action }"
      end
      break if response
    end

    response
  end

  def formatted_xml_response(response=nil)
    if response.present?
      response = Nokogiri::XML response.body
      response.remove_namespaces!
    else
      nil
    end
  end

  def xml(body)
    <<-XML
      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:da="http://services.conzoom.eu/ejendomsdatabasen/v1/da" xmlns:ns="http://services.conzoom.eu/2007/06">
        <soapenv:Header>
          <Security xmlns="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd">
            <UsernameToken>
                <Username>#{ BBR.username }</Username>
                <Password>#{ BBR.password }</Password>
            </UsernameToken>
          </Security>
        </soapenv:Header>
        <soapenv:Body>
          #{ body }
        </soapenv:Body>
      </soapenv:Envelope>
    XML
  end

  def headers(action)
    {
      'Content-Type' => 'text/xml;charset=UTF-8',
      'SOAPAction' => "http://services.conzoom.eu/ejendomsdatabasen/v1/da/IBbrService/#{ action }",
      'Host' => 'services.conzoom.eu'
    }
  end

  def uri
    URI.parse("https://services.conzoom.eu/Ejendomsdatabasen/v1/da/BbrService.svc")
  end

  def http
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    http
  end
end
