json.extract! route, :id, :starts_at, :ends_at, :load_type_id, :load_sum, :cities, :stops_amount, :vehicle_id, :driver_id, :created_at, :updated_at
json.url route_url(route, format: :json)
