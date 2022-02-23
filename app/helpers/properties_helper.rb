module PropertiesHelper

  def property_thumbnail property
    img = property.photo.present? ? property.photo.thumb.url : "placeholder.png"
    image_tag img, class: "property-thumb"
  end

  def property_thumbnail_url property
    property.photo.present? ? property.photo.thumb.url : "placeholder.png"
  end

  def property_photo_url property
    property.photo.present? ? property.photo.url : asset_url("placeholder.png")
  end

  def mortage_monthly_repayment property
    # deduct 10% downpayment
    mortgage_amount = property.price - (property.price * 0.1)

    # 30 year mortgage
    total_months = 30 * 12
    # based on 3.4% annual interest
    interest_rate = 0.034
    annual_repayment = mortgage_amount / 30
    total_repayment = 0

    # compounding interest
    30.times do |i|
      total_repayment = i == 0 ? annual_repayment : annual_repayment + (total_repayment * (1 + interest_rate))
    end

    number_to_currency((total_repayment / total_months), precision: 0)
  end

end
