class MultipartContent
  attr_reader :permitted_attrs

  def initialize(attrs, permitted_attrs={})
    @permitted_attrs = permitted_attrs

    attrs = attrs.deep_symbolize_keys
    attrs = flatten_details_attrs(attrs)

    initialize_attr_readers(attrs.keys)
    assign_attrs(attrs)
  end

private

  def initialize_attr_readers(keys)
    keys.keep_if { |k| permitted_attrs.include?(k) } if permitted_attrs.any?
    self.singleton_class.instance_eval { attr_reader *keys }
  end

  def assign_attrs(attrs)
    attrs.each do |key, value|
      if permitted_attrs.empty? || permitted_attrs.include?(key)
        self.instance_variable_set("@#{key}", value)
      end
    end
  end

  def flatten_details_attrs(attrs)
    details_attrs = attrs[:details] || {}
    attrs.merge(details_attrs)
  end
end
