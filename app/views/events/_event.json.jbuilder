json.extract! event, :id, :event_name, :event_category, :created_at, :updated_at
json.url event_url(event, format: :json)
