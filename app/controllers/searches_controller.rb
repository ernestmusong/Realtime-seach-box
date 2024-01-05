class SearchesController < ApplicationController
  @prefixes = [
    'what is',
    'what are',
    'what does',
    'what should',
    'how is',
    'how are',
    'how does',
    'how should',
    'why is',
    'why are',
    'why does',
    'why should',
    'when is',
    'when does',
    'when are',
    'when should'
  ]
  def create
    query = params[:query]
    ip_address = request.remote_ip
    incomplete_query = unsummarize_query(query)
    complete_query = query if summarize_query(query)
    @results = perform_search(incomplete_query)

    if complete_query.present?
      @search = Search.new(query: complete_query, ip_address: ip_address)
      @search.save
    end

    render json: { success: complete_query.present? }
  end

  private

  def summarize_query(query)
    query_start = query.split(" ").first.downcase
    return query if prefixes.include?(query_start) && query.split(" ").length >= 3
  end

  def unsummarize_query(query)
    query_start = query.split(" ").first.downcase
    return query if prefixes.include?(query_start)
  end

  def perform_search(query)
    Search.where('LOWER(query) LIKE ?', "%#{query.downcase}%").pluck(:query)
  end
end
