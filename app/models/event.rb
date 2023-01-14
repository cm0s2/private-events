class Event < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"

  has_many :event_users, foreign_key: :attended_event_id
  has_many :attendees, through: :event_users

  validates :name, :date, :location, presence: true
end
