class TravelAdvice < MultipartContent

  DETAILS_ATTRIBUTES = %i(
    summary change_description alert_status email_signup_link
  )

  attr_reader :country

  def initialize(attrs)
    super
    assign_country
  end

  def self.details_attr_names
    super + DETAILS_ATTRIBUTES
  end

  def assign_country
    country_attrs = attributes[:details][:country]
    @country = Country.new(country_attrs)
  end
end

# TODO: Remove defensive code on country attrs
# this is only present while placeholders are
# returned from the content store
class Country
  attr_reader :slug, :name

  def initialize(attrs)
    return unless attrs
    @slug = attrs[:slug]
    @name = attrs[:name]
  end
end
