require 'spec_helper'

describe Bbr do
  it 'has a version number' do
    expect(Bbr::VERSION).not_to be nil
  end

  context "valid address and id" do
    let(:address) { "Danas Plads 17, 1915 Frederiksberg" }
    let(:id) { "e85796fd-a59a-4563-aa98-aef6e7c71d19" }

    it 'finds building data from address' do
      expect(BBR.building_data_from_address(address)[:building_area]).to be_present
    end

    it "finds an ID from address" do
      expect(BBR.bbr_id_from_address(address)).to be_present
    end

    it "finds building data from ID" do
      expect(BBR.building_data_from_bbr_id(id)[:building_area]).to be_present
    end
  end

  context "invalid address and id" do
    let(:address) { "en ikke eksisterende adresse" }
    let(:id) { "mærkeligt ID" }

    it 'finds building data from address' do
      expect(BBR.building_data_from_address(address)).to eq({})
    end

    it "finds an ID from address" do
      expect(BBR.bbr_id_from_address(address)).to be_nil
    end

    it "finds building data from ID" do
      expect(BBR.building_data_from_bbr_id(id)).to eq({})
    end
  end
end
