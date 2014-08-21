json.array!(@shop) do |shop|
  json.extract! shop, *Shop::API_ATTRIBUTES
  json.url api_v1_shop_url(shop, format: :json)
end


