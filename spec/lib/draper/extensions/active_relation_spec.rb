require "spec_helper"

describe "#decorate on active_relation" do
  let(:listing) { ArListing.create!(name: "Listing 1") }
  let!(:event)  { listing.events.create!(name: "BugSmash") }
  subject       { listing.events.decorate }

  it "returns Draper::CollectionDecorator" do
    expect(subject).to be_kind_of(Draper::CollectionDecorator)
    expect(subject.decorator_class).to be(ArEventDecorator)
  end

  it "#decorated_collection" do
    expect(subject.decorated_collection.count).to eq(1)
    expect(subject.decorated_collection[0]).to be_instance_of(ArEventDecorator)
  end
end