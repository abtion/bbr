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
          heating: response.at_xpath("//Varmeinstallation/Value").try(:content),
          heating_source: response.at_xpath("//Opvarmningsmiddel/Value").try(:content),
          outer_wall_material: response.at_xpath("//Ydervaegsmateriale/Value").try(:content),
          floors: response.at_xpath("//AntalEtager").try(:content),
          material: response.at_xpath("//Tagdaekningsmateriale/Value").try(:content),
          roof_area: response.at_xpath("//UdnyttetTagetageareal").try(:content)
        }
      else
        Hash.new
      end
    end
  end
end
