module FriendshipsHelper

  def delete_friend(friend)
    link_to('Delete friend', user_delete_friend_path(id: friend.id), method: :delete )
  end

  def confirm_friend(friend)
    link_to('Confirm friend request', user_friendship_path(id: friend.id, user_id: current_user.id), method: :patch)
  end

  def decline_friend(friend)
    link_to('Decline', user_decline_request_path(id: friend.id, user_id: current_user.id ), method: :delete)
  end
end
