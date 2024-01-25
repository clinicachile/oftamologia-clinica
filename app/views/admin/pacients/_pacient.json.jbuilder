json.extract! pacient, :id, :first_name, :last_name, :run, :age, :phone, :email, :created_at, :updated_at
json.url pacient_url(pacient, format: :json)
