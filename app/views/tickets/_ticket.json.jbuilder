json.extract! ticket, :id, :title, :problem, :fixed, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
