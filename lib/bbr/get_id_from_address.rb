module BBR
  class GetIdFromAddress
    extend BBR

    def self.call(address)
      formatted_response(request(request_action, xml_body(address)))
    end

  private
    def self.xml_body(address)
      <<-XML
        <da:EnhedSearch>
          <da:inputRecord>
            <ns:Field>
              <ns:Type>EntireAddress</ns:Type>
              <ns:Value>#{ address }</ns:Value>
            </ns:Field>
          </da:inputRecord>
        </da:EnhedSearch>
      XML
    end

    def self.request_action
      @request_action ||= 'EnhedSearch'
    end

    def self.formatted_response(response=nil)
      response.present? ? response.at_xpath('//BygningId').try(:content) : nil
    end
  end
end
