class SearchesController < ApplicationController
  def index; end

  def create
    query = params[:query].to_s.strip.downcase
    user_ip = request.remote_ip

    # Retrieve existing search suggestions based on the entered prefix and matching ip_address
    search_suggestions = Search.where('lower(query) LIKE ? AND ip_address = ?', "#{query}%", user_ip)
                                .group(:query, :count)
                                .order('count DESC')
                                .limit(10)
                                .pluck(:query)

    # Check if the current query is a prefix of any existing search queries
    existing_search = Search.find_by('lower(query) = ? AND ip_address = ?', query, user_ip)

    if query.split.length >= 3 && last_word_length_not_less_than_3?(query)
      if existing_search
        existing_search.increment!(:count)
      else
        Search.create(query: query, ip_address: user_ip)
      end
    end

    render json: { suggestions: search_suggestions }
  end

  private

  def last_word_length_not_less_than_3?(query)
    last_word = query.split.last
    last_word.length >= 3
  end
end
