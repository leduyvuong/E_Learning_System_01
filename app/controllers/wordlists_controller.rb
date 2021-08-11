class WordlistsController < ApplicationController
  before_action :now_user, only: [:create]
  def now_user
    if @user = current_user
      return @user
    else
      flash[:danger] = t("errors.not_login")
      redirect_to root_path
    end
  end
  def create
    if !Wordlist.where("category_id = ? and user_id = ?", params[:id_cate], current_user.id).first
      @word = Wordlist.new(category_id: params[:id_cate], user_id: current_user.id)
      if @word.save
        flash[:success] = t("errors.wordlist.success")
        redirect_to cate_path
      else
        flash[:danger] = flash_errors(@word)
        redirect_to cate_path
      end
    else
      flash[:danger] = t("errors.wordlist.unsucces")
      redirect_to cate_path
    end   
  end
  private
    def wordlist_params
    end
end
