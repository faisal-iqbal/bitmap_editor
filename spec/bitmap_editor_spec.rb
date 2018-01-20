require 'rspec'
require './lib/bitmap_editor'

describe BitmapEditor do

    context "Legacy Code" do
        it "test parameter validations" do
            bitmap_editor = BitmapEditor.new
            expect { bitmap_editor.run(nil) }.to output("please provide correct file\n").to_stdout
            expect { bitmap_editor.run("!IMPOSIBLE^File!") }.to output("please provide correct file\n").to_stdout
        end

        it "test show.txt" do
            expect { BitmapEditor.new.run("examples/show.txt") }.to output("There is no image\n").to_stdout
        end

        it "test unrecognised command" do
            expect { BitmapEditor.new.run("spec/fixtures/unrecognised.txt") }.to output("unrecognised command :(\n").to_stdout
        end
    end

    context "Assignment Implementations" do
        it "test supported commands" do
            expect { BitmapEditor.new.run("spec/fixtures/recognised.txt") }.not_to output("unrecognised command :(\n").to_stdout
        end

        context "Initialization (I) implementation" do
            it "initilize bitmap table" do
                bitmap_editor = BitmapEditor.new
                bitmap_editor.run("spec/fixtures/init.txt")
    
                bitmap_data = bitmap_editor.bitmap.data
                expect(bitmap_data.size).to eq 1
                bitmap_data.each do |row|
                    expect(row.size).to eq 5
                    row.each do |pixel|
                        expect(pixel).to eq 'O'
                    end
                end
            end
    
            it "handle wrong number of arguments" do
                expect { BitmapEditor.new.run("spec/fixtures/init_invalid_input.txt") }.to output(/wrong number of arguments/).to_stdout
            end
        end
    
        context "Show (S) implementation" do
            it "Show complete bitmap table" do
                expect { BitmapEditor.new.run("spec/fixtures/show.txt") }.to output("OOOOO\n").to_stdout
            end
    
            it "handle extra arguments" do
                expect { BitmapEditor.new.run("spec/fixtures/show_extra_input.txt") }.to output("OOOOO\n").to_stdout
            end
    
            it "test show without initialization" do
                expect { BitmapEditor.new.run("spec/fixtures/show_wo_init.txt") }.to output("There is no image\n").to_stdout
            end
        end
    
        context "Color (L) implementation" do
            it "color single pixel" do
                expect { BitmapEditor.new.run("spec/fixtures/color.txt") }.to output("OOAOO\n").to_stdout
            end
    
            it "handle wrong number of arguments" do
                expect { BitmapEditor.new.run("spec/fixtures/color_invalid_input.txt") }.to output(/wrong number of arguments/).to_stdout
            end
    
            it "test color without initialization" do
                expect { BitmapEditor.new.run("spec/fixtures/color_wo_init.txt") }.to output("There is no image\n").to_stdout
            end
        end
    
        context "Clear (C) implementation" do
            it "clear all pixels" do
                expect { BitmapEditor.new.run("spec/fixtures/clear.txt") }.to output("OOOOO\n").to_stdout
            end
    
            it "handle extra arguments" do
                expect { BitmapEditor.new.run("spec/fixtures/clear_extra_input.txt") }.to output("OOOOO\n").to_stdout
            end
    
            it "test clear without initialization" do
                expect { BitmapEditor.new.run("spec/fixtures/color_wo_init.txt") }.to output("There is no image\n").to_stdout
            end
        end
    
        context "Vertical Segment (V) implementation" do
            it "create vertical segments" do
                expect { BitmapEditor.new.run("spec/fixtures/vertical.txt") }.to output("OOOOO\nOOWOO\nOOWOO\nOOOOO\n").to_stdout
            end
    
            it "handle wrong number of arguments" do
                expect { BitmapEditor.new.run("spec/fixtures/vertical_invalid_input.txt") }.to output(/wrong number of arguments/).to_stdout
            end
    
            it "test (V) without initialization" do
                expect { BitmapEditor.new.run("spec/fixtures/vertical_wo_init.txt") }.to output("There is no image\n").to_stdout
            end
        end
    
        context "Horizontal Segment (H) implementation" do
            it "create horizontal segments" do
                expect { BitmapEditor.new.run("spec/fixtures/horizontal.txt") }.to output("OOOOO\nOOZZZ\nOOOOO\n").to_stdout
            end
    
            it "handle wrong number of arguments" do
                expect { BitmapEditor.new.run("spec/fixtures/horizontal_invalid_input.txt") }.to output(/wrong number of arguments/).to_stdout
            end
    
            it "test (H) without initialization" do
                expect { BitmapEditor.new.run("spec/fixtures/horizontal_wo_init.txt") }.to output("There is no image\n").to_stdout
            end
        end
    end
end