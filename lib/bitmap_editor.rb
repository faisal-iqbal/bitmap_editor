require '.\lib\bitmap'

class BitmapEditor

  attr_reader :bitmap

  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)

    File.open(file).each do |line|
      line = line.chomp.split(' ')
      case line[0]
      when 'I'
        @bitmap = Bitmap.new(line[1], line[2].to_i) if valid_param_count(line, 2)
      when 'C'
        if bitmap_exists?
          @bitmap.clear()
        end
      when 'L'
        if bitmap_exists?
          @bitmap.color(line[1], line[2], line[3]) if valid_param_count(line, 3)
        end
      when 'V'
        if bitmap_exists?
          @bitmap.vertical_segment(line[1], line[2], line[3], line[4]) if valid_param_count(line, 4)
        end
      when 'H'
        if bitmap_exists?
          @bitmap.horizontal_segment(line[1], line[2], line[3], line[4]) if valid_param_count(line, 4)
        end
      when 'S'
        if bitmap_exists?
          @bitmap.show
        end
      else
          puts 'unrecognised command :('
      end
    end
  end

  private
  def bitmap_exists?
    result = true
    if @bitmap.nil?
      puts "There is no image"
      result = false
    end
    result
  end

  def valid_param_count(params, count)
    result = true
    params_count = (params.count - 1)
    if count != params_count
      puts "'#{params[0]}': wrong number of arguments (#{params_count} for #{count})"
      result = false
    end
    result
  end
end
