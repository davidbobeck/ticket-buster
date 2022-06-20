class Ticket < ApplicationRecord
  include TicketBroadcasts
  validates :title, presence: true, length: { minimum: 1, maximum: 50 }

  after_create_commit lambda{ broadcast_create_to_listeners }
  after_update_commit lambda{ broadcast_update_to_listeners }
  after_destroy_commit lambda{ broadcast_destroy_to_listeners }

  # broadcasts
end
