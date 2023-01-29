class Event < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"

  has_many :event_users, foreign_key: :attended_event_id, dependent: :destroy
  has_many :attendees, through: :event_users do
    def invited
      where("event_users.status = ?", EventUser.statuses[:invited])
    end

    def accepted
      where("event_users.status = ?", EventUser.statuses[:accepted])
    end
  end

  def invitees
    User.where.not(id: attendees.ids)
  end


  validates :name, :date, :location, presence: true

  scope :future, -> { where('date >= ?', DateTime.now) }
  scope :past, -> { where('date < ?', DateTime.now) }
end