require "rubygems"
require "ai4r"
require 'rmagick'
include Magick

#Basic methods

def getImage(path)

  image = Image.read(path).first
  thumb = image.scale(16, 16)

  pixelList = []
  for x in 0 ... thumb.rows
    for y in 0 ... thumb.columns
      onePixel = thumb.pixel_color(y, x)
      rgbValue = Math.sqrt( (onePixel.red/(2**8))**2 + (onePixel.green/(2**8))**2 + (onePixel.blue/(2**8))**2 )  #Distancia euclidiana
      pixelList << rgbValue.to_i
    end
  end

  pixelList
end
  
def result_label(result)
  if result[0] > result[1] && result[0] > result[2]
    "TRIANGLE"
  elsif result[1] > result[2] 
    "SQUARE"
  else    
    "CROSS"
  end
end

#Data for the net

netDataList = []


#Triangle Example

TRIANGLE = [
  [ 0,  0,  0,  0,  0,  0,  0, 127, 127,  0,  0,  0,  0,  0,  0,  0],
  [ 0,  0,  0,  0,  0,  0, 25,  229,  229, 25,  0,  0,  0,  0,  0,  0],
  [ 0,  0,  0,  0,  0,  0, 127, 127, 127, 127,  0,  0,  0,  0,  0,  0],
  [ 0,  0,  0,  0,  0, 25,  229, 25, 25,  229, 25,  0,  0,  0,  0,  0],
  [ 0,  0,  0,  0,  0, 127, 127,  0,  0, 127, 127,  0,  0,  0,  0,  0],
  [ 0,  0,  0,  0, 25,  229, 25,  0,  0, 25,  229, 25,  0,  0,  0,  0],
  [ 0,  0,  0,  0, 127, 127,  0,  0,  0,  0, 127, 127,  0,  0,  0,  0],
  [ 0,  0,  0, 25,  229, 25,  0,  0,  0,  0, 25,  229, 25,  0,  0,  0],
  [ 0,  0,  0, 127, 127,  0,  0,  0,  0,  0,  0, 127, 127,  0,  0,  0],
  [ 0,  0, 25,  229, 25,  0,  0,  0,  0,  0,  0, 25,  229, 25,  0,  0],
  [ 0,  0, 127, 127,  0,  0,  0,  0,  0,  0,  0,  0, 127, 127,  0,  0],
  [ 0, 25,  229, 25,  0,  0,  0,  0,  0,  0,  0,  0, 25,  229, 25,  0],
  [ 0, 127, 127,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 127, 127,  0],
  [25,  229, 25,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 25,  229, 25],
  [127, 127,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 127, 127],
  [255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255]

]


data = Hash.new
data[:name] = "Triangle"
data[:input] = TRIANGLE.flatten.collect { |input| input.to_f / 10 }
data[:output] = [1,0,0]
netDataList << data


#Square Example

SQUARE = [
  [255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255],
  [255,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 255],
  [255,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 255],
  [255,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 255],
  [255,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 255],
  [255,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 255],
  [255,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 255],
  [255,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 255],
  [255,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 255],
  [255,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 255],
  [255,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 255],
  [255,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 255],
  [255,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 255],
  [255,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 255],
  [255,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 255],
  [255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255]

]

data = Hash.new
data[:name] = "Square"
data[:input] = SQUARE.flatten.collect { |input| input.to_f / 10 }
data[:output] = [0,1,0]
netDataList << data



#Cross Example

CROSS = [
  [ 0,  0,  0,  0,  0,  0,  0, 127, 127,  0,  0,  0,  0,  0,  0,  0],
  [ 0,  0,  0,  0,  0,  0,  0, 127, 127,  0,  0,  0,  0,  0,  0,  0],
  [ 0,  0,  0,  0,  0,  0,  0, 127, 127,  0,  0,  0,  0,  0,  0,  0],
  [ 0,  0,  0,  0,  0,  0,  0, 127, 127,  0,  0,  0,  0,  0,  0,  0],
  [ 0,  0,  0,  0,  0,  0,  0, 127, 127,  0,  0,  0,  0,  0,  0,  0],
  [ 0,  0,  0,  0,  0,  0,  0, 127, 127,  0,  0,  0,  0,  0,  0,  0],
  [ 0,  0,  0,  0,  0,  0,  0, 127, 127,  0,  0,  0,  0,  0,  0,  0],
  [127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127],
  [127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127],
  [ 0,  0,  0,  0,  0,  0,  0, 127, 127,  0,  0,  0,  0,  0,  0,  0],
  [ 0,  0,  0,  0,  0,  0,  0, 127, 127,  0,  0,  0,  0,  0,  0,  0],
  [ 0,  0,  0,  0,  0,  0,  0, 127, 127,  0,  0,  0,  0,  0,  0,  0],
  [ 0,  0,  0,  0,  0,  0,  0, 127, 127,  0,  0,  0,  0,  0,  0,  0],
  [ 0,  0,  0,  0,  0,  0,  0, 127, 127,  0,  0,  0,  0,  0,  0,  0],
  [ 0,  0,  0,  0,  0,  0,  0, 127, 127,  0,  0,  0,  0,  0,  0,  0],
  [ 0,  0,  0,  0,  0,  0,  0, 127, 127,  0,  0,  0,  0,  0,  0,  0]
]

data = Hash.new
data[:name] = "Cross"
data[:input] = CROSS.flatten.collect { |input| input.to_f / 10 }
data[:output] = [0,0,1]
netDataList << data


#Files

squareImages = Dir["#{Dir.pwd}/input/squares/*"]
squareImages.each do |path|
  data = Hash.new
  data[:name] = "Square"
  data[:input] = getImage(path).collect { |input| input.to_f / 10 }
  data[:output] = [0,1,0]
  netDataList << data
end



crossImages = Dir["#{Dir.pwd}/input/crosses/*"]
crossImages.each do |path|
  data = Hash.new
  data[:name] = "Cross"
  data[:input] = getImage(path).collect { |input| input.to_f / 10 }
  data[:output] = [0,0,1]
  netDataList << data
end


triangleImages = Dir["#{Dir.pwd}/input/triangles/*"]
triangleImages.each do |path|
  data = Hash.new
  data[:name] = "Triangle"
  data[:input] = getImage(path).collect { |input| input.to_f / 10 } 
  data[:output] = [1,0,0]
  netDataList << data
end

testPaths = Dir["#{Dir.pwd}/test/*"]
testImages = []
testPaths.each do |path|
  testImages << getImage(path).collect { |input| input.to_f / 10 } 
end


# Create a network with 256 inputs, 2 hidden layers and 3 outputs
net = Ai4r::NeuralNetwork::Backpropagation.new([256, 200, 50, 3])

# Train the network
puts "Training the network, please wait."
120.times do |i|
  error = []

  netDataList.each do |data|
    error << net.train(data[:input], data[:output])
  end

  puts "Error after iteration #{i}:\t#{error.max}" if i%10 == 0
end


puts "Testing the net"
netDataList.each do |data| 
  puts "Name = #{data[:name]} \t #{net.eval(data[:input]).inspect} => #{result_label(net.eval(data[:input]))}"
end

puts "Testing with other results"
testImages.each do |image|
  puts "#{net.eval(image).inspect} => #{result_label(net.eval(image))}"
end
