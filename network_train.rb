require "rubygems"
require "ai4r"
require "rmagick"
require "yaml"
include Magick
load "others/basic_methods.rb"
load "others/data_pattern.rb"

## Obtaining configuration file
net_attributes = YAML.load_file("config.yml")



## Input data for training

net_data_list = []

pattern_images = Dir["#{Dir.pwd}/input/AAP/*"]
pattern_images.each do |path|
  image = get_image(path)
  data = DataPattern.new
  data.name = "AAP"
  data.input = image.collect { |input| input.to_f }
  data.output = [1,0,0,0]
  net_data_list << data
end


pattern_images = Dir["#{Dir.pwd}/input/AT/*"]
pattern_images.each do |path|
  image = get_image(path)
  data = DataPattern.new
  data.name = "AT"
  data.input = image.collect { |input| input.to_f }
  data.output = [0,1,0,0]
  net_data_list << data
end


pattern_images = Dir["#{Dir.pwd}/input/TF/*"]
pattern_images.each do |path|
  image = get_image(path)
  data = DataPattern.new
  data.name = "TF"
  data.input = image.collect { |input| input.to_f }
  data.output = [0,0,1,0]
  net_data_list << data
end

pattern_images = Dir["#{Dir.pwd}/input/PR/*"]
pattern_images.each do |path|
  image = get_image(path)
  data = DataPattern.new
  data.name = "PR"
  data.input = image.collect { |input| input.to_f }
  data.output = [0,0,0,1]
  net_data_list << data
end




##Creating the network with:
    # 256 inputs
    # 1 hidden layer with 200 neurons
    # 1 hidden layer with 15 neurons
    # 4 outputs

net = Ai4r::NeuralNetwork::Backpropagation.new(net_attributes["layers"])

net.set_parameters( 
    :momentum => net_attributes["momentum"], 
    :learning_rate => net_attributes["learning_rate"],
    :propagation_function =>  lambda { |x| 1/(1+Math.exp(-1*(x))) }, # Sigmoid function
    :derivative_propagation_function => lambda { |y| y*(1-y) }
)



## Train the network

puts "Training the network, please wait..."

iterations = net_attributes["training_iterations"]

iterations.times do |i|
  error = []

  net_data_list.each do |data|
    error << net.train(data.input, data.output)
  end

  puts "Error after iteration #{i}: \t #{error.max}" if i%10 == 0
end
puts "Done!"


## Saving weights in weights.txt
save_weights(net.weights)


## Testing network

puts "Testing with the data used for training:"
net_data_list.each do |data|
  output = net.eval(data.input)
  puts "Pattern: #{data.name} \t=>\t Result: #{result_label(output)}"
end