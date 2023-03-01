# frozen_string_literal: true

require 'benchmark'

task measure_searching_performance: :environment do
  arr = ('a'..'z').to_a.sample(10)

  pg_search_performance = Benchmark.measure do
    arr.each do |query|
      results = PgSearch.multisearch(query)
      results.length
    end
  end

  puts "PG search completed the task in #{(pg_search_performance.real * 1000).to_i} miliseconds"

  elastic_search_performance = Benchmark.measure do
    arr.each do |query|
      results = Searchkick.search(
        query,
        models: [Product, Category],
        match: :word_start,
        load: false,
        misspellings: false
      )
      results.length
    end
  end

  puts "Elasticsearch completed the task in #{(elastic_search_performance.real * 1000).to_i} miliseconds"
end
