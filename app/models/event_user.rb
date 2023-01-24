class EventUser < ApplicationRecord
  belongs_to :attendee, class_name: "User"
  belongs_to :attended_event, class_name: "Event"

  enum :status, { invited: 0, accepted: 1 }, null: false
end
