class SearchesController < ApplicationController
  def index; end

  def create
    query = params[:query].to_s.strip.downcase
    user_ip = request.remote_ip
    search_suggestions = Search.where('lower(query) LIKE ? AND ip_address = ?', "#{query}%", user_ip)
      .group(:query, :count).order('count DESC').limit(10).pluck(:query)
    if query.split.length >= 3
      existing_search = Search.find_by(query: query)
      if existing_search
        existing_search.increment!(:count)
      else
        Search.create(query: query, ip_address: user_ip)
      end
    end
    render json: { suggestions: search_suggestions }
  end
end
