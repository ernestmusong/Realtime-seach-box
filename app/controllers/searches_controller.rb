class SearchesController < ApplicationController
  def index; end

  def create
    query = params[:query].to_s.strip
    if query.split.length >= 3
      @user_ip = request.remote_ip
      Search.create(query: query, ip_address: @user_ip)
    end
    @articles = Article.where('lower(title) LIKE ?', "%#{query.downcase}%")
    render json: { articles: @articles }
  end
end
