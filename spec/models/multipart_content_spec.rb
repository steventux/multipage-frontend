require "rails_helper"

RSpec.describe MultipartContent do
  describe "initialize" do
    context "with no attribute filtering" do
      let(:instance) do
        described_class.new("foo" => "foo",
                            "bar" => "bar",
                            "details" => { "thing" => "thing" })
      end

      it "adds an attr_reader for each attribute" do
        expect(instance).to respond_to(:foo)
        expect(instance).to respond_to(:bar)

        expect(instance).not_to respond_to(:meh)
      end

      it "assigns each attribute" do
        expect(instance.foo).to eq("foo")
        expect(instance.bar).to eq("bar")
      end

      it "flattens details attributes and assigns them" do
        expect(instance.thing).to eq("thing")
      end
    end

    context "with attribute filtering" do
      let(:instance) do
        described_class.new({"foo" => "foo",
                             "bar" => "bar",
                             "baz" => [1,2,3],
                             "details" => { "thing" => "thing" }
        }, [:foo,:baz, :thing])
      end

      it "adds an attr_reader for each permitted attribute" do
        expect(instance).to respond_to(:foo)
        expect(instance).to respond_to(:baz)
        expect(instance).to respond_to(:thing)

        expect(instance).not_to respond_to(:bar)
      end

      it "assigns each permitted attribute" do
        expect(instance.foo).to eq("foo")
        expect(instance.baz).to eq([1,2,3])
        expect(instance.thing).to eq("thing")
      end
    end
  end
end
