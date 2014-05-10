require "spec_helper"

describe Kaminari::PaginatableArray do
  let(:listing1) { ArListing.create!(name: "listing1") }
  let(:listing2) { ArListing.create!(name: "listing2") }

  it "#decorate on non-empty array" do
    expect(Kaminari::PaginatableArray.new([listing1, listing2]).decorate).to be_instance_of(Draper::CollectionDecorator)
  end

  it "#decorate on non-empty array" do
    expect(Kaminari::PaginatableArray.new.decorate).to be_instance_of(Draper::CollectionDecorator)
  end
end