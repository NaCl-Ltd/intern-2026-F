class GameController < ApplicationController
  before_action :logged_in_user

  def parity
    micropost = current_user.microposts
                  .unscope(:order)
                  .order(Arel.sql("RANDOM()"))
                  .first
    
    if micropost.nil?
      @error_message = "ゲームに使用できる投稿がありません。"
      session.delete(:parity_micropost_id)
      return
    end
    
    session[:parity_micropost_id] = micropost.id
    
    Rails.logger.debug(
      "[PARITY] user=#{current_user.id}, " \
      "selected=#{micropost.id}, " \
      "session=#{session[:parity_micropost_id].inspect}"
    )
  end
  
  # def parity
  #   micropost = current_user.microposts.find_by(
  #     id: session[:parity_micropost_id]
  #   )

  #   if micropost.nil?
  #     micropost = current_user.microposts.order("RANDOM()").first
  #   end

  #   if micropost.nil?
  #     @error_message = "ゲームに使用できる投稿がありません。"
  #     session.delete(:parity_micropost_id)
  #     return
  #   end

  #   session[:parity_micropost_id] = micropost.id

  #   Rails.logger.debug(
  #     "[PARITY] user=#{current_user.id}, " \
  #     "selected=#{micropost.id}, " \
  #     "session=#{session[:parity_micropost_id].inspect}"
  #   )
  # end

  def answer_parity
    @guess = params[:guess]

    unless %w[even odd].include?(@guess)
      redirect_to parity_game_path,
                  alert: "偶数または奇数を選択してください。"
      return
    end

    micropost_id = session[:parity_micropost_id]

    Rails.logger.debug(
      "[PARITY ANSWER] user=#{current_user.id}, " \
      "session=#{micropost_id.inspect}, " \
      "guess=#{@guess.inspect}"
    )

    @micropost = current_user.microposts.find_by(
      id: micropost_id
    )

    if @micropost.nil?
      redirect_to parity_game_path,
                  alert: "問題の投稿が見つかりませんでした。"
      return
    end

    @character_count =
      @micropost.content.gsub(/[[:space:]]/, "").length

    @correct_parity =
      @character_count.even? ? "even" : "odd"

    @correct = @guess == @correct_parity

    session.delete(:parity_micropost_id)
  end
end
