class CategoriesController < ApplicationController
  def cate
    @categories = Category.sp.paginate(page: params[:page])
  end
  def cate_detail
    @categories = Category.find_by(id: params[:id])
  end
end
