# frozen_string_literal: true

module SearchHelpers
  def pg_search_query(query)
    PgSearch.multisearch(query)
  end

  def elastic_search_query(query)
    Searchkick.search(
      query,
      models: [Product, Category],
      match: :word_start,
      load: false,
      misspellings: false
    )
  end
end
