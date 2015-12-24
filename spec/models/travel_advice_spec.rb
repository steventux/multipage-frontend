require "rails_helper"

RSpec.describe TravelAdvice do
  describe "initialize" do
    let(:content_id) { SecureRandom.uuid }
    let(:details) do
      {
        "country" => {
          "name" => "Albania",
          "slug" => "albania",
        },
        "public_updated_at" => "2015-10-15T11:00:20+01:00",
        "summary" => "The summary",
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

    it "inherits attributes assignment" do
      expect(subject.content_id).to eq(content_id)
    end

    it "overrides details attributes assignment" do
      expect(subject.summary).to eq("The summary")
    end

    it "assigns the country" do
      expect(subject.country).to be
      expect(subject.country.name).to eq("Albania")
      expect(subject.country.slug).to eq("albania")
    end
  end
end
