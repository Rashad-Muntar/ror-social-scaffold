class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def confirm_friend
    update_attributes(status: true)
    Friendship.create!(friend_id: user_id,
                       user_id: friend_id,
                       status: true)
  end
end
