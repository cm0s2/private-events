class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events, foreign_key: :creator_id

  has_many :event_users, foreign_key: :attendee_id
  has_many :attended_events, through: :event_users do
    def invited
      where("event_users.status = ?", EventUser.statuses[:invited])
    end

    def accepted
      where("event_users.status = ?", EventUser.statuses[:accepted])
    end
  end
end
