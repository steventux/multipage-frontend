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
    country_attrs = attributes[:details].fetch(:country)
    @country = Country.new(country_attrs)
  end
end

class Country
  attr_reader :slug, :name

  def initialize(attrs)
    @slug = attrs.fetch(:slug)
    @name = attrs.fetch(:name)
  end
end
