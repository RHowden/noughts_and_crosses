require "test_helper"

class GameTest < ActiveSupport::TestCase
  test "new game should have state of in_play" do
    game = Game.new
    assert_equal :in_play, game.state
  end

  test "game state should be stalemate when all moves taken" do
    game = Game.new
    game.board = [
      "X", "O", "X", 
      "O", "O", "X", 
      "X", "X", "O"]
    assert_equal :draw, game.state
  end

  test "horizontal line on first row should win the game for X" do
    game = Game.new
    game.board = [
      "X", "X", "X", 
      "O", "O", nil, 
      nil, nil, nil]
    assert_equal :x_wins, game.state
  end

  test "horizontal line on second row should win the game for X" do
    game = Game.new
    game.board = [
      nil, nil, nil, 
      "X", "X", "X", 
      "O", "O", nil]
    assert_equal :x_wins, game.state
  end

  test "horizontal line should win the game for O" do
    game = Game.new
    game.board = [
      nil, nil, nil,
      "O", "O", "O", 
      "X", "X", nil
      ]
    assert_equal :o_wins, game.state
  end

  test "vertical line on first column should win the game for X" do
    game = Game.new
    game.board = [
      "X", "O", nil, 
      "X", "O", nil, 
      "X", nil, nil
    ]
    assert_equal :x_wins, game.state
  end

  test "vertical line on second column should win the game for X" do
    game = Game.new
    game.board = [
      "O", "X", nil, 
      "O", "X", nil, 
      nil, "X", :nil]
    assert_equal :x_wins, game.state
  end

  test "vertical line should win the game for O" do
    game = Game.new
    game.board = [
      nil, "O", "X", 
      nil, "O", "X", 
      nil, "O", nil]
    assert_equal :o_wins, game.state
  end

  test "diagonal line should win the game for X" do
    game = Game.new
    game.board = [
      "X", "O", nil, 
      "O", "X", nil, 
      "X", nil, "X"
    ]
    assert_equal :x_wins, game.state
  end

  test "diagonal line should win the game for O" do
    game = Game.new
    game.board = [
      nil, "X", "O", 
      "X", "O", nil, 
      "O", "X", :nil]
    assert_equal :o_wins, game.state
  end

  test "move should not change board when game is stalemate" do
    initial_board = [
      "X", "O", "X", 
      "O", "O", "X", 
      "X", "X", "O"]
    game = Game.new
    game.board = initial_board
    game.current_player = "O"

    game.move!(0)
     assert_equal initial_board, game.board
  end

  test "move should not change current player when game is stalemate" do
    game = Game.new
    game.board = [
      "X", "O", "X", 
      "O", "O", "X", 
      "X", "X", "O"]
    game.current_player = "O"

    game.move!(0)
     assert_equal "O", game.current_player
  end

  test "move should not change board when game is won" do
    initial_board = [
      "O", "O", "O", 
      "X", nil, "X", 
      nil, nil, nil]
    game = Game.new
    game.board = initial_board
    game.current_player = "O"

    game.move!(0)
    assert_equal initial_board, game.board
  end

  test "move should not change current player when game is won" do
    game = Game.new
    game.board = [
      "O", "O", "O", 
      "X", nil,"X", 
      nil, nil, nil]
    game.current_player = "O"

    game.move!(0)
    assert_equal "O", game.current_player
  end

  test "move should update board" do
    game = Game.new
    game.current_player = "O"

    game.move!(0)

    expected = ["O"] + 8.times.collect { nil}
    assert_equal expected, game.reload.board
  end

  test "move should update current_player" do
    game = Game.new
    game.current_player = "O"

    game.move!(0)

    assert_equal "X", game.reload.current_player
  end
end
