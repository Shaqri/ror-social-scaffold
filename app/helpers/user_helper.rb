module UserHelper
  def add_friend(user)
    link_to('Add friend', user_friendships_path(user_id: current_user.id, friend_id: user.id, confirmed: false), method: :post )
  end

  def confirm_friend(friend)
    link_to('Confirm friend request', user_friendship_path(id: friend.id), method: :patch)
  end

  def decline_friend(friend)
    link_to('Decline', user_friendship_path(id: friend.id), method: :delete)
  end

  def cancel_friend_request(user)
    link_to('Cancel', user_friendship_path(id: user.id, user_id: 'true'), method: :delete)
  end

end
