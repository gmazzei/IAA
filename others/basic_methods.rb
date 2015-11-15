N = 16 # Image size. For example, N = 16 means a 16x16 pixel array.

def get_image(path)

  image = Image.read(path).first
  thumb = image.scale(N, N)

  pixel_list = []
  
  for x in 0 ... thumb.rows
    for y in 0 ... thumb.columns
      one_pixel = thumb.pixel_color(y, x)
      rgb_value = Math.sqrt( (one_pixel.red/(2**8))**2 + (one_pixel.green/(2**8))**2 + (one_pixel.blue/(2**8))**2 )  #Distancia euclidiana

      pixel_list << rgb_value
    end
  end

  return pixel_list
end



def result_label(results)
  pattern_names = ["AAP", "AT", "TF", "PR"]
  max_value_index = results.rindex(results.max)
  return pattern_names[max_value_index]
end


def print_image(image_array)
  
  for x in 0 ... N
    a_start = N*x
    a_end = (N*(x+1))-1
    puts pixel_list[a_start..a_end].inspect
  end

end


$weights_file = 'weights.txt' 

def save_weights(weights)
  serialized_array = Marshal.dump(weights)
  File.open($weights_file, 'w') { 
    |f| f.write(serialized_array) 
  }
end

def get_weights()
  Marshal.load File.read($weights_file)
end