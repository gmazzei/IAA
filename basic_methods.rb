def get_image(path)

  image = Image.read(path).first
  thumb = image.scale(16, 16)

  pixel_list = []
  
  for x in 0 ... thumb.rows
    for y in 0 ... thumb.columns
      one_pixel = thumb.pixel_color(y, x)
      rgb_value = Math.sqrt( (one_pixel.red/(2**8))**2 + (one_pixel.green/(2**8))**2 + (one_pixel.blue/(2**8))**2 )  #Distancia euclidiana
      pixel_list << rgb_value.to_i
    end
  end

  return pixelList
end


  
def result_label(results)
  pattern_names = ["APP", "AT", "TF", "PR"]
  maxValue_index = results.rindex(results.max)
  return pattern_names[maxValueIndex]
end