json.extract! appointment, :id, :start_time, :description, :pacient_id, :user_id, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)
