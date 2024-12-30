class UsersController < ApplicationController
  before_action :find_following, only: %i[ send_request index ]
  def index
    @potential_friends = User.potential_friends.where.not(id: current_user.id)

    @pending_followers = current_user.pending_followers
    @accepted_followers = current_user.followers


    @pending_followings = current_user.pending_followings
    @accepted_followings = current_user.followings
  end

  def send_request
    current_user.send_follow_request(@following)
    redirect_to users_path
  end

  def find_following
    @following = User.find_by(id: params[:following_id])
  end
end
