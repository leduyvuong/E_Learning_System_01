class Admin::StatisticsController < ApplicationController
  before_action :admin_teacher
  def index
    @users = User.filter_statistic(params[:type])
  end
  def filter_statistic
    @users
    if (params_filter["month"].to_i <= Date.today.strftime("%m").to_i)
      @users = User.filter_month_year(params_filter["month"],params_filter["year"])
    else
      @users = User.filter_month_year(Date.today.strftime("%m"),params_filter["year"])
    end
    @users
    render :index
  end
  def category_statistic
    @wordlists = Wordlist.filter(params[:category_name])
  end
  def export_excel
    @users = User.all
    @categories = Category.all
    @users_growth = User.filter_month_year((DateTime.now.strftime("%m").to_i - 1),"2021")
    @user_list = parse_data_user(User.group(:role).count)
    respond_to do |format|
      format.xlsx {
        response.headers["Content-Disposition"] = "attachment; filename=statistic#{DateTime.current}.xlsx"
      }
    end
  end
  private
    def params_filter
      params.permit(:month, :year)
    end
end
