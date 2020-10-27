module UserHelper
  def add_friend(user)
    link_to('Add friend', user_friendships_path(user_id: current_user.id, friend_id: user.id, c: false), method: :post)
  end

  def cancel_friend_request(user)
    link_to('Cancel Friend Request', user_cancel_request_path(id: user.id, user_id: current_user.id), method: :delete)
  end

  def same_user?(user_a, user_b)
    user_a == user_b
  end

  def pending_friends?(user)
    current_user.pending_friends.include?(user)
  end

  def no_friend_requested?(user)
    current_user.friend_requests.include?(user) ? false : true
  end

  def display_users(current_user, user)
    render 'users', user: user unless same_user?(current_user, user) || current_user.friend_requests.include?(user)
  end

  def user_current_relation(user)
    if current_user.friend?(user)
      state = 'Friends'
    elsif pending_friends?(user)
      state = cancel_friend_request(user)
    elsif no_friend_requested?(user)
      state = add_friend(user)
    end

    content_tag(:span, state, class: 'user-state')
  end
end
