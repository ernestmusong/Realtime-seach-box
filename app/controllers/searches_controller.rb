class SearchesController < ApplicationController
  attr_reader :prefixes, :topics


  def initialize
    super
    @prefixes = [
      'what is',
      'what are',
      'what does',
      'what should',
      'how is',
      'how are',
      'how does',

    ]

    @topics = [
      'cook rice',
      'bake a cake',
      'learn programming',
      'start a business',
      'grow plants',
      'write a book',
      'play guitar',
      'build a website'
    ]
  end

  def index
    query = params[:query]
    incomplete_query = unsummarize_query(query)
    @results = perform_search(incomplete_query)
    render json: { results: @resutls }
  end

  def create
    @user_ip = request.remote_ip
    query = params[:query]
    complete_query = summarize_query(query)
    if complete_query.present?
      @search = Search.new(query: complete_query, ip_address: @user_ip)
      @search.save
    end

    render json: { success: complete_query.present? }
  end

  private

  def summarize_query(query)
    query_start = query&.chars&.first&.downcase
    return nil if prefixes&.include?(query_start) || query.chars.length < 3

    query
  end

  def unsummarize_query(query)
    return query if query.nil?

    query_start = query.chars.first.downcase
    return query if @prefixes.include?(query_start)
  end

  def perform_search(query)
    @user_ip = request.remote_ip
    return if @user_ip.nil?

    saved_queries = Search.where(ip_address: @user_ip).pluck(:query)
    suggestions = generate_suggestions

    # Check if there are any saved queries matching the user input
    matching_queries = saved_queries.select { |saved_query| saved_query.downcase.include?(query.downcase) }

    # If there are matching queries, return them
    return matching_queries if matching_queries.present?

    suggestions.select { |suggestion| suggestion.downcase.include?(query.downcase) }
  end

  def generate_suggestions
    return [] if prefixes.nil? || topics.nil?

    prefixes.flat_map do |prefix|
      topics.map { |topic| "#{prefix} #{topic}" }
    end
  end
end
