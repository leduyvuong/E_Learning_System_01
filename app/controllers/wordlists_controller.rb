class WordlistsController < ApplicationController
  before_action :check_login, only: [:create]
  def create
    @wordlist = Wordlist.found_dup params[:id_cate], current_user.id
    if  @wordlist.first 
      flash[:danger] = t("categories.inform.unsuccess")
      redirect_to categories_path
    else
      @word = Wordlist.new(category_id: params[:id_cate], user_id: current_user.id)
      if @word.save
        flash[:success] = t("categories.inform.success")
        redirect_to categories_path
      else
        flash[:danger] = t("categories.inform.error")
        redirect_to categories_path
      end
    end   
  end
  def index
  end
  private 
    def check_login
      unless logged_in?
        flash[:danger] = t("errors.not_login")
        redirect_to root_path
      end
    end
end