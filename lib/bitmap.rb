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

    def get_pixel_color(x, y)
        x = ensure_valid_x_index(x)
        y = ensure_valid_y_index(y)

        @data[y][x]
    end

    def color(x, y, color)
        x = ensure_valid_x_index(x)
        y = ensure_valid_y_index(y)

        @data[y][x] = color
    end

    def vertical_segment(x, y1, y2, color)
        x = ensure_valid_x_index(x)
        y1 = ensure_valid_y_index(y1)
        y2 = ensure_valid_y_index(y2)

        (y1..y2).each do |y|
            @data[y][x] = color
        end
    end

    def horizontal_segment(x1, x2, y, color)
        x1 = ensure_valid_x_index(x1)
        x2 = ensure_valid_x_index(x2)
        y = ensure_valid_y_index(y)

        (x1..x2).each do |x|
            @data[y][x] = color
        end
    end

    def clear
        max_y = @row_size - 1
        max_x = @column_size - 1

        (0..max_y).each do |y|
            (0..max_x).each do |x|
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

    def ensure_valid_index(indx, size)
        valid_indx = indx.to_i - 1
        if valid_indx < 0
            valid_indx = 0
        end
        if valid_indx >= size
            valid_indx = size - 1
        end
        valid_indx
    end

    def ensure_valid_y_index(indx)
        ensure_valid_index(indx, @row_size)
    end

    def ensure_valid_x_index(indx)
        ensure_valid_index(indx, @column_size)
    end
end
