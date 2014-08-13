json.array!(@apartments) do |apartment|
  json.extract! apartment, :id, :address, :link, :contact, :price, :hunt_id
  json.url apartment_url(apartment, format: :json)
end
