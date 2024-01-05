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


  def index
    incomplete_query = unsummarize_query(query)
    @results = perform_search(incomplete_query)
    render json: { results: @resutls }
  end

  def create
    query = params[:query]
    ip_address = request.remote_ip
    complete_query = query if summarize_query(query)
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
    @user_ip = request.remote_ip
    saved_queries = Search.where(ip_address: user_ip).pluck(:query)

    suggestions = @prefixes.map do |prefix|
      topics.map do |topic|
        "#{prefix} #{topic}"
      end
    end.flatten

    # Check if there are any saved queries matching the user input
    matching_queries = saved_queries.select { |saved_query| saved_query.downcase.include?(query.downcase) }

    # If there are matching queries, return them
    return matching_queries if matching_queries.present?

    suggestions.select { |suggestion| suggestion.downcase.include?(query.downcase) }
  end
end
