class SearchesController < ApplicationController
  def index; end

  def create
    query = params[:query].to_s.strip
    @user_ip = request.remote_ip
    Search.create(query: query, ip_address: @user_ip)
    @articles = Article.where('lower(title) LIKE ?', "%#{query.downcase}%")
    render json: { articles: @articles }
  end

  def analytics
    @search_terms = Search.group(:query).count
  end

  private

  def summarize_query(query)
    query_start = query.split.first.downcase
    # string = query.join
    # float = string.length.to_f
    # length = query.split.length
    return nil if prefixes.include?(query_start) == false

    # return nil if length < 3
    # return nil if query_start.nil? == false

    # return nil if prefixes&.include?(query_start) || query_start.nil? || (query.chars.length < 3)
    # return nil if prefixes.include?(query_start) || query_start.nil? || (length < 3)

    query
  end

  def unsummarize_query(query)
    query_start = query.split.first.downcase
    return nil if prefixes.include?(query_start) == false

    query
  end

  def perform_search(query)
    @user_ip = request.remote_ip
    return if @user_ip.nil?

    # saved_queries = Search.where(ip_address: @user_ip).pluck(:query)
    suggestions = generate_suggestions

    # matching_queries = saved_queries.select { |saved_query| saved_query.downcase.include?(query.downcase) }
    # return matching_queries if matching_queries.present?

    suggestions.select { |suggestion| suggestion.downcase.include?(query.downcase) }
  end

  def generate_suggestions
    return [] if prefixes.nil? || topics.nil?

    prefixes.flat_map do |prefix|
      topics.map { |topic| "#{prefix} #{topic}" }
    end
  end
end
