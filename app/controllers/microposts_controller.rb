class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create


####################
    content = micropost_params[:content]

    if content.start_with?(":lisp")

      body = content.delete_prefix(":lisp").strip

      lines = body.lines.map(&:chomp)
      
      expr = lines.reject(&:empty?).last

      if expr.length > 100
        content = "Lisp Error: expression too long (max 100 chars)"
      else

      comment_lines = lines[0...lines.rindex(expr)].map do |line|
        line.sub(/^;\s*/, "")
      end
      
      result = Lisp.eval(expr)
      
      content =
        "#{comment_lines.join("\n")}\n\n" \
        "#{expr}\n" \
        "=> #{result}"
     end
end
####################


    @micropost = current_user.microposts.build(
      content: content)

    @micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home', status: :unprocessable_content
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    if request.referrer.nil?
      redirect_to root_url, status: :see_other
    else
      redirect_to request.referrer, status: :see_other
    end
  end

#######################################
  def pin
    micropost = current_user.microposts.find(params[:id])
    
    current_user.update(pinned: micropost.id)
    
    flash[:success] = "Micropost pinned!"
    redirect_back(fallback_location: root_url)
  end
#######################################

  private

    def micropost_params
      params.require(:micropost).permit(:content, :image)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url, status: :see_other if @micropost.nil?
    end
end
