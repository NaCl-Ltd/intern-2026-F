class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @pinned_micropost = current_user.pinned_micropost #add myself
      # @feed_items = current_user.feed.paginate(page: params[:page])

      #########################
      @feed_items =
        if @pinned_micropost
          current_user.feed
            .where.not(id: @pinned_micropost.id)
            .paginate(page: params[:page])
        else
          current_user.feed.paginate(page: params[:page])
        end
      #########################

    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
