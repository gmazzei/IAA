require "rubygems"
require "ai4r"
require "rmagick"
require "yaml"
include Magick
load "others/basic_methods.rb"
load "others/data_pattern.rb"

## Get configuration file
net_attributes = YAML.load_file("config.yml")



## Unknown data for testing

testing_data_list = []

testing_images = Dir["#{Dir.pwd}/test/*"]
testing_images.each do |path|
  image = get_image(path)
  data = DataPattern.new
  data.name = path
  data.input = image.collect { |input| input.to_f / 10 }
  testing_data_list << data
end




##Creating a network with:
    # 256 inputs
    # 1 hidden layer with 200 neurons
    # 1 hidden layer with 15 neurons
    # 4 outputs

net = Ai4r::NeuralNetwork::Backpropagation.new(net_attributes["layers"])

net.set_parameters( 
    :momentum => net_attributes["momentum"], 
    :learning_rate => net_attributes["learning_rate"],
    :propagation_function =>  lambda { |x| 1/(1+Math.exp(-1*(x))) },
    :derivative_propagation_function => lambda { |y| y*(1-y) }
)



#Initializing weights as in weights.txt

net.init_network()
net.weights = get_weights()



#Testing

puts "Testing with unknown input:"
testing_data_list.each do |data|
  output = net.eval(data.input)
  result = result_label(output)
  puts "Filename: #{data.name} \t => \t Result: #{result}"
end
