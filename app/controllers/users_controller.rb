class UsersController < ApplicationController
  before_action :find_following, only: %i[ send_request index ]
  before_action :find_follower, only: %i[ approve_request ]
  before_action :find_follow_requests, only: %i[reject_request approve_request]

  def index
    @potential_friends = User.where.not(id: current_user.id)

    @pending_followers = current_user.pending_followers
    @accepted_followers = current_user.followers


    @pending_followings = current_user.pending_followings
    @accepted_followings = current_user.followings
  end

  def send_request
    current_user.send_follow_request(@following)
    redirect_to users_path
  end

  def approve_request
    @request.approve_follow_request
    redirect_to users_path
  end

  def reject_request
    @request.destroy!
    redirect_to users_path
  end

  private

  def find_follow_requests
    @request = current_user.received_follow_requests.find_by(follower_id: params[:follower_id])
  end

  def find_following
    @following = User.find_by(id: params[:following_id])
  end
  def find_follower
    @follower = User.find_by(id: params[:follower_id])
  end
end
