class Bitmap

    attr_reader :data
    attr_reader :column_size
    attr_reader :row_size

    MIN_SIZE = 1
    MAX_SIZE = 250
    DEFAULT_COLOR = 'O'

    def initialize(columns, rows)
        @data = []

        @column_size = ensure_valid_size(columns)
        @row_size = ensure_valid_size(rows)

        @row_size.times do
            row_data = []
            @column_size.times do
                row_data << DEFAULT_COLOR
            end
            @data << row_data
        end
    end

    def color(x, y, color)
        x = ensure_valid_index(x)
        y = ensure_valid_index(y)
        if x > -1 and y > -1
            if !@data[y].nil? and !@data[y][x].nil?
                @data[y][x] = color
            end
        end
    end

    def vertical_segment(x, y1, y2, color)
        x = ensure_valid_index(x)
        y1 = ensure_valid_index(y1)
        y2 = ensure_valid_index(y2)
        if x > -1 and y1 > -1 and y2 > -1
            (y1..y2).each do |y|
                if x > 0 and y > 0 and !@data[y].nil? and !@data[y][x].nil?
                    @data[y][x] = color
                end
            end
        end
    end

    def horizontal_segment(x1, x2, y, color)
        x1 = ensure_valid_index(x1)
        x2 = ensure_valid_index(x2)
        y = ensure_valid_index(y)
        if x1 > -1 and x2 > -1 and y > -1
            (x1..x2).each do |x|
                if !@data[y].nil? and !@data[y][x].nil?
                    @data[y][x] = color
                end
            end
        end
    end

    def clear
        max_rows = @row_size - 1
        max_column = @column_size - 1
        (0..max_rows).each do |y|
            (0..max_column).each do |x|
                @data[y][x] = DEFAULT_COLOR
            end
        end
    end

    def show
        @data.each do |row|
            line = []
            row.each do |pixel|
                line << pixel
            end
            puts line.join('')
        end
    end

    private
    def ensure_valid_size(size)
        size = size.to_i
        if size < MIN_SIZE
            size = MIN_SIZE
        else
            if size > MAX_SIZE
                size = MAX_SIZE
            end
        end
        size
    end

    def ensure_valid_index(indx)
        indx.to_i - 1
    end
end