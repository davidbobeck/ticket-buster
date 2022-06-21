module TicketBroadcasts
  def broadcast_create_to_listeners
    self.broadcast_prepend_to "ticket-listeners", target: "tickets-go-here", partial: "tickets/spa_ticket", locals: {ticket: self}
    self.broadcast_replace_to "ticket-listeners", target: "ticket-notice", partial: "layouts/ticket_notice", locals: {notice: "Created: #{self.title}"}
    self.broadcast_replace_to "ticket-listeners", target: "new-ticket-form", partial: "tickets/spa_new_form", locals: {ticket: Ticket.new}
  end

  def broadcast_update_to_listeners
    self.broadcast_replace_to "ticket-listeners", target: "ticket-#{self.id}", partial: "tickets/spa_ticket", locals: {ticket: self}
    self.broadcast_replace_to "ticket-listeners", target: "ticket-notice", partial: "layouts/ticket_notice", locals: {notice: "Updated: #{self.title}"}
  end

  def broadcast_destroy_to_listeners
    self.broadcast_remove_to "ticket-listeners", target: "ticket-#{self.id}" #, partial: "tickets/ticket", locals: {ticket: self}
    self.broadcast_replace_to "ticket-listeners", target: "ticket-notice", partial: "layouts/ticket_notice", locals: {notice: "Deleted: #{self.title}"}
  end

  def broadcast_edit_to_listeners
    self.broadcast_replace_to "ticket-listeners", target: "ticket-#{self.id}", partial: "tickets/spa_edit_form", locals: {ticket: self}
  end

  def broadcast_edit_cancel_to_listeners
    self.broadcast_replace_to "ticket-listeners", target: "ticket-#{self.id}", partial: "tickets/spa_ticket", locals: {ticket: self}
  end
end
