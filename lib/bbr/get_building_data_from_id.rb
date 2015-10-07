module BBR
  class GetBuildingDataFromId
    extend BBR

    def self.call(id)
      id.present? ? formatted_response(request(request_action, xml_body(id))) : Hash.new
    end

  private
    def self.xml_body(id)
      <<-XML
        <da:BygningGetById>
           <da:bbrId>#{ id }</da:bbrId>
        </da:BygningGetById>
      XML
    end

    def self.request_action
      @request_action ||= 'BygningGetById'
    end

    def self.formatted_response(response=nil)
      if response.present? && !response.at_xpath("//Fault").try(:content).present?
        {
          building_area: response.at_xpath("//BebyggetAreal").try(:content),
          building_age: (Time.now.year - response.at_xpath("//Opfoerselsaar").try(:content).to_i).to_i,
          roof_type: response.at_xpath("//Tagdaekningsmateriale/Value").try(:content),
          roof_tilt: roof_tilt(response),
          heating: response.at_xpath("//Varmeinstallation/Value").try(:content),
          heating_source: response.at_xpath("//Opvarmningsmiddel/Value").try(:content),
          formatted_heating: formatted_heating(response),
          outer_wall_material: response.at_xpath("//Ydervaegsmateriale/Value").try(:content)
        }
      else
        Hash.new
      end
    end

    def self.roof_tilt(response)
      floors    = response.at_xpath("//AntalEtager").try :content
      material  = response.at_xpath("//Tagdaekningsmateriale/Value").try :content
      roof_area = response.at_xpath("//UdnyttetTagetageareal").try :content

      if floors
        t = floors == 1 ? 2 : 3
        if material == 'BuiltUp'
          t = 1
        elsif roof_area.to_i > 0
          t = 3
        end
        t
      else
        2
      end
    end

    def self.formatted_heating(response)
      heating         = response.at_xpath("//Varmeinstallation/Value").try :content
      heating_source  = response.at_xpath("//Opvarmningsmiddel/Value").try :content

      case heating
      when 'FjernvarmeBlokvarme'
        'Fjernvarme'
      when 'ElovneElpaneler'
        'Elvarme'
      when 'Varmepumpe'
        'Varmepumpe'
      when 'Gasradiator'
        'Gas'
      when 'CentralvarmeFraEgetAnlaegEtKammerFyr', 'CentralvarmeMedToFyringsenheder', 'Ovne'
        case heating_source
        when 'Elektricitet'
          'Elvarme'
        when 'Gasvaerksgas', 'Naturgas'
          'Gas'
        when 'FastBraendsel', 'Halm'
          'Træpillefyr/Halmfyr'
        else
          'Oliefyr'
        end
      else
        "#{ heating } / #{ heating_source }"
      end
    end
  end

end
