require "spec_helper"

describe PromisePay::Item do
  let(:request) { double("PromisePay::Request", execute: sample_response) }

  before do
    PromisePay::Request.stub(:new) { request }
  end

  describe ".find" do
    let(:sample_response) { File.read("./spec/support/fixtures/item_find.json") }
    let(:item_id)         { "wef9834tg" }

    it "returns a hash representation of the item" do
      expect(described_class.find(item_id)).to be_a_kind_of Hash
    end

    it "instantiates PromisePay::Request with the correct endpoint" do
      valid_endpoint = PromisePay::TEST_ENDPOINT + PromisePay::Item::PATH + item_id.to_s
      PromisePay::Request.should_receive(:new).with(endpoint: valid_endpoint)
      described_class.find(item_id)
    end
  end

  describe ".all" do
    let(:sample_response) { File.read("./spec/support/fixtures/item_all.json") }

    it "returns a hash representation of the items" do
      expect(described_class.all).to be_a_kind_of Hash
    end

    it "instantiates PromisePay::Request with the correct endpoint" do
      valid_endpoint = PromisePay::TEST_ENDPOINT + PromisePay::Item::PATH
      PromisePay::Request.should_receive(:new).with(endpoint: valid_endpoint)
      described_class.all
    end
  end
end