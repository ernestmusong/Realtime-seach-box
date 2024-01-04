class SearchesController < ApplicationController
  def create
    query = params[:query]
    complete_query = query if valid_search_query?(query)

    if complete_query.present?
      @search = Search.new(query: complete_query)
      @search.save

      # You can also track the user's IP address here if needed
    end

    render partial: 'search_results'
  end

  private

  def valid_search_query?(query)
    return false unless query.start_with?('w', 'W', 'h', 'H')

    words = query.split(' ')
    return false unless words.length >= 3

    case words[1].downcase
    when "is"
      return valid_is_question?(words)
    when "are"
      return valid_are_question?(words)
    end

    false
  end

  def valid_is_question?(words)
    return false unless words[2].casecmp?("the")

    valid_third_word = ["meaning", "use", "reason"]
    valid_third_word.any? { |word| words[3].casecmp?(word) }
  end

  def valid_are_question?(words)
    return false unless words[2].casecmp?("the")

    valid_third_word = ["meanings", "uses", "reasons"]
    valid_third_word.any? { |word| words[3].casecmp?(word) }
  end
end