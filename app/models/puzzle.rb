class Puzzle < ApplicationRecord
    has_many :grid_boxes
    has_many :puzzle_words
    has_many :words, through: :puzzle_words

    ACROSS = 'across'
    DOWN = 'down'

    def self.new_blank_puzzle
      puzzle = Puzzle.create
      inc = 1
      while inc < 121
        GridBox.create(box_id: inc, puzzle: puzzle, key: "", value: "", className: "filled")
        inc += 1
      end
      puzzle
    end

    def empty_grid
      self.grid_boxes.destroy_all
      self.puzzle_words.destroy_all
      inc = 1
      while inc < 121
        GridBox.create(box_id: inc, puzzle: self, key: "", value: "", className: "filled")
        inc += 1
      end
      self
    end

    def add_word(word, align, box_id)
      PuzzleWord.create(word: word, puzzle: self, alignment: align, box_id: box_id)
      grid = self.grid_boxes.sort_by{|b| b.box_id}

      ind = box_id - 1
      word_string = word.answer.upcase

      if align == ACROSS

        word_string.split("").each do |char|
          box = grid[ind]
          if ind == box_id - 1
            box.update(key: char, className: "empty numbered")
          else
            box.update(key: char, className: "empty")
          end
          ind += 1
        end

      else

        word_string.split("").each do |char|
          box = grid[ind]
          if ind == box_id - 1
            box.update(key: char, className: "empty numbered")
          else
            box.update(key: char, className: "empty")
          end
          ind += 15
        end

      end
    end

    def is_valid_crossword
      self.grid_boxes.find{ |b| b.box_id == 31 }.className == "filled"
    end

end
