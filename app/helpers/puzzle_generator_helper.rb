module PuzzleGeneratorHelper
  def crossword_random_template_1
    # GridBoxStructure = 12 x 12
    # 12 ROW
    # 12 Column
    # 28 Question
    # 28 Answer

    # ALL OVERLAPS
    # Answer0 -> 6 Characters Where -> Answer0[1] == Answer1[1] && Answer0[2] == Answer10[0] && Answer0[3] == Answer11[0] && Answer0[4] == Answer19[0]
    # Answer1 -> 6 Characters Where -> Answer1[1] == Answer0[1] && Answer1[2] == Answer3[0] && Answer1[3] == Answer2[1] && Answer1[5] == Answer4[1]
    # Answer2 -> 3 Characters Where -> Answer2[1] == Answer1[3] && Answer1[2] == Answer10[2]
    # Answer3 -> 9 Characters Where -> Answer3[0] == Answer1[2] && Answer3[1] == Answer10[1] && Answer3[2] == Answer11[2] && Answer3[3] == Answer19[1] && Answer3[5] == Answer19[1]

    # OVERLAPS
    # Answer0 -> 6 Characters
    # Answer1 -> 6 Characters Where -> Answer1[1] == Answer0[1]
    # Answer2 -> 3 Characters Where -> Answer2[1] == Answer1[3]
    # Answer3 -> 9 Characters Where -> Answer3[0] == Answer1[2]
    # Answer4 -> 4 Characters Where -> Answer4[1] == Answer1[5]
    # Answer5 -> 4 Characters
    # Answer6 -> 3 Characters
    # Answer7 -> 4 Characters
    # Answer8 -> 3 Characters Where -> Answer8[0] == Answer5[1] && Answer8[2] == Answer6[1]
    # Answer9 -> 10 Characters
    # Answer10 -> 7 Characters Where -> Answer10[0] == Answer0[2] && Answer10[1] == Answer3[1] && Answer10[2] == Answer2[2] && Answer10[4] == Answer4[2] && Answer10[6] == Answer5[2]
    # Answer11 -> 3 Characters Where -> Answer11[1] == Answer0[3] && Answer11[2] == Answer3[2]
    # Answer12 -> 3 Characters Where -> Answer12[0] == Answer6[2] && Answer12[1] == Answer9[0] && Answer12[2] == Answer7[2]
    # Answer13 -> 7 Characters
    # Answer14 -> 5 Characters Where -> Answer14[1] == Answer4[3] && Answer14[3] == Answer5[3] && Answer14[4] == Answer13[0]
    # Answer15 -> 5 Characters
    # Answer16 -> 8 Characters
    # Answer17 -> 3 Characters Where -> Answer17[0] == Answer0[4] && Answer17[1] == Answer3[3] && Answer17[2] == Answer15[0]
    # Answer18 -> 7 Characters
    # Answer19 -> 6 Characters
    # Answer20 -> 2 Characters Where -> Answer20[0] == Answer3[5] && Answer20[1] == Answer15[2]
    # Answer21 -> 3 Characters
    # Answer22 -> 7 Characters Where -> Answer22[3] == Answer13[5] && Answer22[4] == Answer16[4] && Answer22[5] == Answer9[6] && Answer22[6] == Answer18[3]
    # Answer23 -> 3 Characters
    # Answer24 -> 8 Characters Where ->  Answer24[0] == Answer23[0] && Answer24[4] == Answer13[6] && Answer24[5] == Answer16[5] && Answer24[6] == Answer9[7] && Answer24[7] == Answer18[4]
    # Answer25 -> 5 Characters Where ->  Answer25[1] == Answer23[1]
    # Answer26 -> 3 Characters Where ->  Answer26[0] == Answer16[6] && Answer26[1] == Answer9[8] && Answer26[2] == Answer18[5]
    # Answer27 -> 10 Characters Where ->  Answer27[2] == Answer23[2] && Answer27[7] == Answer16[7] && Answer27[8] == Answer9[9] && Answer27[9] == Answer18[6]



    GridBox.new(box_id: 1, type: :question, alignment: :both, questions: Question.random())

    one_across = Question.where("LENGTH(answer) = 5").order("RANDOM()").first
    two_across = Question.where("LENGTH(answer) = 3").order("RANDOM()").first
    two_down = Question.get_word([[0, two_across.answer[0]]], 3).shuffle.first
    three_across = Question.where("LENGTH(answer) = 3").order("RANDOM()").first
    four_across = Question.get_word([[4, two_down.answer[1]]], 5).shuffle.first
    five_across = Question.get_word([[7, two_down.answer[2]]], 8).shuffle.first
    five_down = Question.get_word([[0, five_across.answer[0]]], 5).shuffle.first
    six_across = Question.get_word([[3, five_down.answer[1]]], 5).shuffle.first
    seven_down = Question.where("LENGTH(answer) = 5").order("RANDOM()").first
    nine_across = Question.get_word([[4, seven_down.answer[1]]], 5).shuffle.first
    eleven_across = Question.get_word([[2, seven_down.answer[3]]], 3).shuffle.first
    twelve_across = Question.get_word([[4, seven_down.answer[4]]], 5).shuffle.first
    ten_across = Question.get_word([[4, five_down.answer[3]]], 8).shuffle.first
    eight_down = Question.get_word([[1, ten_across.answer[7]]], 3).shuffle.first

    words = [
      { word: one_across, alignment: ACROSS, box_id: 1 },
      { word: two_across, alignment: ACROSS, box_id: 13 },
      { word: three_across, alignment: ACROSS, box_id: 16 },
      { word: four_across, alignment: ACROSS, box_id: 24 },
      { word: five_across, alignment: ACROSS, box_id: 36 },
      { word: six_across, alignment: ACROSS, box_id: 48 },
      { word: nine_across, alignment: ACROSS, box_id: 71 },
      { word: ten_across, alignment: ACROSS, box_id: 77 },
      { word: eleven_across, alignment: ACROSS, box_id: 103 },
      { word: twelve_across, alignment: ACROSS, box_id: 116 },
      # { word: two_down, alignment: 'down', box_id: 13 },
      { word: five_down, alignment: DOWN, box_id: 36 },
      { word: seven_down, alignment: DOWN, box_id: 60 },
      { word: eight_down, alignment: DOWN, box_id: 69 }
    ]

    words.each{ |word| self.add_word(word[:word], word[:alignment], word[:box_id]) }

    # while self.grid_boxes.find{ |b| b.box_id === 31 }.className === 'empty' || self.puzzle_words.length < 13
    #   self.empty_grid
    #   self.crossword_random_gen
    # end
  end
end
