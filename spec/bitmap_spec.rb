require 'rspec'
require './lib/bitmap'

describe Bitmap do

    context "initilize" do
        it "create bitmap data for image of diminsions 5x6" do
            bitmap = Bitmap.new(5, 6)
            expect(bitmap.data.size).to eq 6
            bitmap.data.each do |row|
                expect(row.size).to eq 5
            end
        end

        it "create bitmap data for image with all pixels as colored white (#{Bitmap::DEFAULT_COLOR})" do
            bitmap = Bitmap.new(5, 6)
            expect(bitmap.data.size).to eq 6
            bitmap.data.each do |row|
                expect(row.size).to eq 5
                row.each do |pixel|
                    expect(pixel).to eq Bitmap::DEFAULT_COLOR
                end
            end
        end

        it "handles input less then #{Bitmap::MIN_SIZE} for columns" do
            columns = Bitmap::MIN_SIZE - 1
            bitmap = Bitmap.new(columns, Bitmap::MIN_SIZE)
            expect(bitmap.data.size).to eq Bitmap::MIN_SIZE
            bitmap.data.each do |row|
                expect(row.size).to eq Bitmap::MIN_SIZE
            end
        end

        it "handles input more then #{Bitmap::MAX_SIZE} for columns" do
            columns = Bitmap::MAX_SIZE + 1
            bitmap = Bitmap.new(columns, Bitmap::MIN_SIZE)
            expect(bitmap.data.size).to eq Bitmap::MIN_SIZE
            bitmap.data.each do |row|
                expect(row.size).to eq Bitmap::MAX_SIZE
            end
        end

        it "handles input less then #{Bitmap::MIN_SIZE} for rows" do
            rows = Bitmap::MIN_SIZE - 1
            bitmap = Bitmap.new(Bitmap::MIN_SIZE, rows)
            expect(bitmap.data.size).to eq Bitmap::MIN_SIZE
            bitmap.data.each do |row|
                expect(row.size).to eq Bitmap::MIN_SIZE
            end
        end

        it "handles input more then #{Bitmap::MAX_SIZE} for rows" do
            rows = Bitmap::MAX_SIZE + 1
            bitmap = Bitmap.new(Bitmap::MIN_SIZE, rows)
            expect(bitmap.data.size).to eq Bitmap::MAX_SIZE
            bitmap.data.each do |row|
                expect(row.size).to eq Bitmap::MIN_SIZE
            end
        end
    end
    
    context "Check a Pixel" do
        it "check a pixel color" do
            bitmap = Bitmap.new(5, 6)

            bitmap.color(1, 3, 'A')
            expect(bitmap.get_pixel_color(1, 3)).to eq 'A'
            
            bitmap.color(1, 3, 'W')
            expect(bitmap.get_pixel_color(1, 3)).to eq 'W'
        end
    end

    context "Color a Pixel" do
        it "change a pixel color to (A)" do
            bitmap = Bitmap.new(5, 6)
            bitmap.color(1, 3, 'A')

            expected = [
                ['O', 'O', 'O', 'O', 'O'],
                ['O', 'O', 'O', 'O', 'O'],
                ['A', 'O', 'O', 'O', 'O'],
                ['O', 'O', 'O', 'O', 'O'],
                ['O', 'O', 'O', 'O', 'O'],
                ['O', 'O', 'O', 'O', 'O']
            ]

            expect(bitmap.data).to match_array(expected)
            expect(bitmap.get_pixel_color(1, 3)).to eq 'A'
        end

        it "handles zero input for color" do
            bitmap = Bitmap.new(5, 6)
            bitmap.color(0, 3, 'A') # row/coulumn values starts with 1, any value below 1 will be rounded to 1

            expect(bitmap.get_pixel_color(0, 3)).to eq 'A' # column value 0 will be rounded to column value 1
            expect(bitmap.get_pixel_color(0, 3)).to eq bitmap.get_pixel_color(1, 3) # column value 0 will be rounded to column value 1
        end

        it "handles out-of-bound input for color" do
            bitmap = Bitmap.new(5, 6)
            bitmap.color(1, 8, 'A') # row/coulumn values could not exceed bitmap diminsions, any value more then bitmap diminsions will be rounded to bitmap diminsion

            expect(bitmap.get_pixel_color(1, 8)).to eq 'A' # row value 8 will be rounded to row value 6
            expect(bitmap.get_pixel_color(1, 8)).to eq bitmap.get_pixel_color(1, 6) # row value 8 will be rounded to row value 6
        end
    end

    context "Vertical segment" do
        it "draw a vertical segment" do
            bitmap = Bitmap.new(5, 6)
            bitmap.vertical_segment(2, 3, 6, 'W')

            expected = [
                ['O', 'O', 'O', 'O', 'O'],
                ['O', 'O', 'O', 'O', 'O'],
                ['O', 'W', 'O', 'O', 'O'],
                ['O', 'W', 'O', 'O', 'O'],
                ['O', 'W', 'O', 'O', 'O'],
                ['O', 'W', 'O', 'O', 'O']
            ]

            expect(bitmap.data).to match_array(expected)
        end

        it "handles zero input for vertical_segment" do
            bitmap = Bitmap.new(5, 6)
            bitmap.vertical_segment(0, 3, 6, 'W') # row/coulumn values starts with 1, any value below 1 will be rounded to 1
            
            expected = [
                ['O', 'O', 'O', 'O', 'O'],
                ['O', 'O', 'O', 'O', 'O'],
                ['W', 'O', 'O', 'O', 'O'],
                ['W', 'O', 'O', 'O', 'O'],
                ['W', 'O', 'O', 'O', 'O'],
                ['W', 'O', 'O', 'O', 'O']
            ]

            expect(bitmap.data).to match_array(expected)
        end

        it "handles out-of-bound input for vertical_segment" do
            bitmap = Bitmap.new(5, 6)
            bitmap.vertical_segment(2, 3, 7, 'W')

            expected = [
                ['O', 'O', 'O', 'O', 'O'],
                ['O', 'O', 'O', 'O', 'O'],
                ['O', 'W', 'O', 'O', 'O'],
                ['O', 'W', 'O', 'O', 'O'],
                ['O', 'W', 'O', 'O', 'O'],
                ['O', 'W', 'O', 'O', 'O']
            ]

            expect(bitmap.data).to match_array(expected)
        end
    end

    context "Horizontal segment" do
        it "draw a horizontal segment" do
            bitmap = Bitmap.new(5, 6)
            bitmap.horizontal_segment(3, 5, 2, 'Z')

            expected = [
                ['O', 'O', 'O', 'O', 'O'],
                ['O', 'O', 'Z', 'Z', 'Z'],
                ['O', 'O', 'O', 'O', 'O'],
                ['O', 'O', 'O', 'O', 'O'],
                ['O', 'O', 'O', 'O', 'O'],
                ['O', 'O', 'O', 'O', 'O']
            ]

            expect(bitmap.data).to match_array(expected)
        end

        it "handles zero input for horizontal_segment" do
            bitmap = Bitmap.new(5, 6)
            bitmap.horizontal_segment(0, 5, 2, 'Z') # row/coulumn values starts with 1, any value below 1 will be rounded to 1
            
            expected = [
                ['O', 'O', 'O', 'O', 'O'],
                ['Z', 'Z', 'Z', 'Z', 'Z'],
                ['O', 'O', 'O', 'O', 'O'],
                ['O', 'O', 'O', 'O', 'O'],
                ['O', 'O', 'O', 'O', 'O'],
                ['O', 'O', 'O', 'O', 'O']
            ]

            expect(bitmap.data).to match_array(expected)
        end

        it "handles out-of-bound input for horizontal_segment" do
            bitmap = Bitmap.new(5, 6)
            bitmap.horizontal_segment(3, 8, 2, 'Z')

            expected = [
                ['O', 'O', 'O', 'O', 'O'],
                ['O', 'O', 'Z', 'Z', 'Z'],
                ['O', 'O', 'O', 'O', 'O'],
                ['O', 'O', 'O', 'O', 'O'],
                ['O', 'O', 'O', 'O', 'O'],
                ['O', 'O', 'O', 'O', 'O']
            ]

            expect(bitmap.data).to match_array(expected)
        end
    end

    context "Clear Table" do
        it "Reset all pixels to #{Bitmap::DEFAULT_COLOR}" do
            bitmap = Bitmap.new(5, 6)
            bitmap.horizontal_segment(3, 5, 2, 'Z')

            expected = [
                ['O', 'O', 'O', 'O', 'O'],
                ['O', 'O', 'Z', 'Z', 'Z'],
                ['O', 'O', 'O', 'O', 'O'],
                ['O', 'O', 'O', 'O', 'O'],
                ['O', 'O', 'O', 'O', 'O'],
                ['O', 'O', 'O', 'O', 'O']
            ]

            expect(bitmap.data).to match_array(expected)

            bitmap.clear()

            bitmap.data.each do |row|
                row.each do |pixel|
                    expect(pixel).not_to eq 'Z' # no pixel should be 'Z' after clear
                end
            end
        end
    end

    context "Show" do
        it "displays complete bitmap table" do
            bitmap = Bitmap.new(5, 1)
            bitmap.horizontal_segment(3, 5, 1, 'Z')
            expect { bitmap.show }.to output("OOZZZ\n").to_stdout
        end
    end
end
