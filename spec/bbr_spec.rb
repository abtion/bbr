require 'spec_helper'

describe Bbr do
  it 'has a version number' do
    expect(Bbr::VERSION).not_to be nil
  end

  it 'finds building data from address' do
    expect(BBR.building_data_from_address("Danas Plads 17, 1915 Frederiksberg")[:building_area]).to be_present
  end

  it "finds an ID from address" do
    expect(BBR.bbr_id_from_address("Danas Plads 17, 1915 Frederiksberg")).to be_present
  end

  it "finds building data from ID" do
    expect(BBR.building_data_from_bbr_id("e85796fd-a59a-4563-aa98-aef6e7c71d19")[:building_area]).to be_present
  end
end
