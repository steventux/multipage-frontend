class MultipartContent

  METADATA_ATTRIBUTES = %i(content_id base_path title description)
  DETAILS_ATTRIBUTES = %i(public_updated_at)

  attr_reader :parts

  def initialize(attrs)
    @attributes = attrs.deep_symbolize_keys
    self.singleton_class.instance_eval { attr_reader *attr_names }
    assign_attributes(self.class.metadata_attr_names, attributes)
    assign_attributes(self.class.details_attr_names, attributes[:details])
    assign_parts
  end

  def part?(slug)
    parts.find{ |p| p.slug == slug }.present?
  end

protected

  def self.attr_names
    metadata_attr_names + details_attr_names
  end

  def self.metadata_attr_names
    METADATA_ATTRIBUTES
  end

  def self.details_attr_names
    DETAILS_ATTRIBUTES
  end

private

  attr_reader :attributes, :details

  def assign_attributes(attribute_keys, attrs)
    attribute_keys.each do |attr|
      instance_variable_set("@#{attr}", attrs[attr]) if attrs.key?(attr)
    end
  end

  def assign_parts
    return unless attributes[:details].key?(:parts)
    @parts = attributes[:details][:parts].map { |part| Part.new(part) }
  end

end

class Part
  attr_reader :slug, :title, :body

  def initialize(attrs)
    @slug = attrs.fetch(:slug)
    @title = attrs.fetch(:title)
    @body = attrs.fetch(:body)
  end
end
