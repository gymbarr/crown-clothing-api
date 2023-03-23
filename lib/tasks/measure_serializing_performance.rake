# frozen_string_literal: true

require 'benchmark'

task measure_serializing_performance: :environment do
  products = Product.first(100)
  product = products.sample

  active_model_performance_one_object = Benchmark.measure do
    ActiveModelSerializers::ProductSerializer.new(product).to_json
  end

  puts 'Active model completed serializing 1 object in ' \
       "#{(active_model_performance_one_object.real * 1000).to_i} miliseconds"

  panko_performance_one_object = Benchmark.measure do
    PankoSerializers::ProductSerializer.new.serialize(product).to_json
  end

  puts 'Panko completed serializing 1 object in ' \
       "#{(panko_performance_one_object.real * 1000).to_i} miliseconds"
  puts

  active_model_performance_many_objects = Benchmark.measure do
    ActiveModelSerializers::SerializableResource.new(
      products,
      each_serializer: ActiveModelSerializers::ProductSerializer
    ).to_json
  end

  puts 'Active model completed serializing 100 objects in ' \
       "#{(active_model_performance_many_objects.real * 1000).to_i} miliseconds"

  panko_performance_many_objects = Benchmark.measure do
    Panko::ArraySerializer.new(products, each_serializer: PankoSerializers::ProductSerializer).to_json
  end

  puts 'Panko completed serializing 100 objects in ' \
       "#{(panko_performance_many_objects.real * 1000).to_i} miliseconds"
end
