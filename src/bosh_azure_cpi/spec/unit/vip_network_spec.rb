require "spec_helper"

describe Bosh::AzureCloud::VipNetwork do
  let(:azure_properties) { mock_azure_properties }

  context "with resource_group_name" do
    let(:network_spec) {
      {
        "type" => "vip",
        "ip"=>"fake-vip",
        "cloud_properties" => {
          "resource_group_name" => "foo"
        }
      }
    }

    it "should get resource_group_name from cloud_properties" do
      nc = Bosh::AzureCloud::VipNetwork.new(azure_properties, "vip", network_spec)
      expect(nc.public_ip).to eq("fake-vip")
      expect(nc.resource_group_name).to eq("foo")
    end
  end

  context "without resource_group_name" do
    let(:network_spec) {
      {
        "type" => "vip",
        "ip"=>"fake-vip",
        "cloud_properties" => {}
      }
    }

    it "should get resource_group_name from global azure properties" do
      nc = Bosh::AzureCloud::VipNetwork.new(azure_properties, "vip", network_spec)
      expect(nc.public_ip).to eq("fake-vip")
      expect(nc.resource_group_name).to eq(azure_properties["resource_group_name"])
    end
  end
end
