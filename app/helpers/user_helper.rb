module UserHelper
  def add_friend(user)
    link_to('Add friend', user_friendships_path(user_id: current_user.id, friend_id: user.id, confirmed: false), method: :post )
  end

  def cancel_friend_request(user)
    link_to('Cancel', user_cancel_request_path(id: user.id, user_id: current_user.id), method: :delete)
  end

  def same_user?(a, b)
    a == b ? true : false
  end

  def friend_name(friendship)
    if  same_user?(friendship.user.name, current_user.name)
      friendship.friend.name
    else
      friendship.user.name
    end
  end

  def pending_friends?(user)
    current_user.pending_friends.include?(user) ? true : false
  end

  def no_friend_requested?(user)
    current_user.friend_requests.include?(user) ? false : true
  end
end
