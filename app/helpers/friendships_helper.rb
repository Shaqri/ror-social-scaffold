module FriendshipsHelper
  def delete_friend(friend)
    link_to('Unfriend', user_delete_friend_path(id: friend.id), method: :delete)
  end

  def confirm_friend(friend)
    link_to('Confirm friend request', user_friendship_path(id: friend.id, user_id: current_user.id), method: :patch)
  end

  def decline_friend(friend)
    link_to('Decline', user_decline_request_path(id: friend.id, user_id: current_user.id), method: :delete)
  end

  def display_friend_requests_h2(friend_requests)
    content_tag(:h2, "Friend requests (#{friend_requests.size})", class: 'friends-title') if friend_requests.any?
  end
end
