require "rails_helper"

RSpec.describe MultipartContent do
  describe "initialize" do
    let(:content_id) { SecureRandom.uuid }
    let(:details) do
      {
        "public_updated_at" => "2015-10-15T11:00:20+01:00",
        "parts" => [
          {"title" => "Part one", "slug" => "part-one", "body" => "A new beginning"},
          {"title" => "Part two", "slug" => "part-two", "body" => "The next bit"},
        ]
      }
    end
    let(:attrs) do
      {
        "base_path" => "/foo/bar",
        "title" => "A two part guide to foobar",
        "description" => "What follows is a brief description...",
        "content_id" => content_id,
        "not_readable" => "not readable",
        "details" => details,
      }
    end
    subject { described_class.new(attrs) }

    it "adds an attr_reader for each attribute" do
      described_class::metadata_attr_names.each do |attr|
        expect(subject).to respond_to(attr)
      end

      expect(subject).not_to respond_to(:not_readable)
    end

    it "assigns each attribute" do
      described_class::metadata_attr_names.each do |attr|
        expect(subject.send(attr)).to eq(attrs[attr.to_s])
      end
    end

    it "flattens details attributes" do
      expect(subject.public_updated_at).to eq("2015-10-15T11:00:20+01:00")
    end

    it "assigns parts" do
      expect(subject.parts.size).to eq(2)

      expect(subject.parts.first.slug).to eq("part-one")
      expect(subject.parts.first.title).to eq("Part one")
      expect(subject.parts.first.body).to eq("A new beginning")

      expect(subject.parts.second.slug).to eq("part-two")
      expect(subject.parts.second.title).to eq("Part two")
      expect(subject.parts.second.body).to eq("The next bit")
    end
  end
end
