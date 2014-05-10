require "spec_helper"

describe Draper::CollectionDecorator, "pagination" do
  let(:listing) { ArListing.create!(name: "Listing 1") }
  let!(:events) { listing.events.create!([{name: "BugSmash"}, {name: "KataCamp"}]) }

  subject       { listing.events.page(1).decorate }

  it "#current_page" do
    expect(subject.current_page).to eq(subject.send(:object).current_page)
  end

  it "#total_pages" do
    expect(subject.total_pages).to eq(subject.send(:object).total_pages)
  end

  it "#per_page" do
    expect(subject.per_page).to eq(subject.send(:object).limit_value)
  end

  it "#limit_value" do
    expect(subject.limit_value).to eq(subject.send(:object).limit_value)
  end

  it "#next_page" do
    expect(subject.next_page).to eq(subject.send(:object).next_page)
  end

  it "#prev_page" do
    expect(subject.prev_page).to eq(subject.send(:object).prev_page)
  end

  it "#total_count" do
    expect(subject.total_count).to eq(subject.send(:object).total_count)
  end
end

describe Draper::CollectionDecorator, "#decorates_scope" do
  let(:listing) { MongoListing.create!(name: "Listing 1") }
  let!(:events) { listing.events.create!([{name: "BugSmash"}, {name: "KataCamp"}]) }

  it "invokes on valid scope :upcomings" do
    decorates = listing.decorate.events.upcomings

    expect(decorates).to be_instance_of(MongoEventsDecorator)
    expect(decorates.send(:object).selector).not_to be_blank
  end

  it "invokes on invalid scope :invalids" do
    expect {
      listing.decorate.events.invalids
    }.to raise_error(ArgumentError, "MongoEvent doesn't define scope: invalids")
  end
end