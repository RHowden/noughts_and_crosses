require "test_helper"

class GameTest < ActiveSupport::TestCase
  test "new game should have state of in_play" do
    game = Game.new
    assert_equal :in_play, game.state
  end

  test "game state should be stalemate when all moves taken" do
    game = Game.new
    game.board = [
      "x", "y", "x", 
      "y", "y", "x", 
      "x", "x", "y"]
    assert_equal :draw, game.state
  end

  test "horizontal line on first row should win the game for x" do
    game = Game.new
    game.board = [
      "x", "x", "x", 
      "y", "y", nil, 
      nil, nil, nil]
    assert_equal :x_wins, game.state
  end

  test "horizontal line on second row should win the game for x" do
    game = Game.new
    game.board = [
      nil, nil, nil, 
      "x", "x", "x", 
      "y", "y", nil]
    assert_equal :x_wins, game.state
  end

  test "horizontal line should win the game for y" do
    game = Game.new
    game.board = [
      nil, nil, nil,
      "y", "y", "y", 
      "x", "x", nil
      ]
    assert_equal :y_wins, game.state
  end

  test "vertical line on first column should win the game for x" do
    game = Game.new
    game.board = [
      "x", "y", nil, 
      "x", "y", nil, 
      "x", nil, nil
    ]
    assert_equal :x_wins, game.state
  end

  test "vertical line on second column should win the game for x" do
    game = Game.new
    game.board = [
      "y", "x", nil, 
      "y", "x", nil, 
      nil, "x", :nil]
    assert_equal :x_wins, game.state
  end

  test "vertical line should win the game for y" do
    game = Game.new
    game.board = [
      nil, "y", "x", 
      nil, "y", "x", 
      nil, "y", nil]
    assert_equal :y_wins, game.state
  end

  test "diagonal line should win the game for x" do
    game = Game.new
    game.board = [
      "x", "y", nil, 
      "y", "x", nil, 
      "x", nil, "x"
    ]
    assert_equal :x_wins, game.state
  end

  test "diagonal line should win the game for y" do
    game = Game.new
    game.board = [
      nil, "x", "y", 
      "x", "y", nil, 
      "y", "x", :nil]
    assert_equal :y_wins, game.state
  end

  test "move should not change board when game is stalemate" do
    initial_board = [
      "x", "y", "x", 
      "y", "y", "x", 
      "x", "x", "y"]
    game = Game.new
    game.board = initial_board
    game.current_player = "y"

    game.move!(0)
     assert_equal initial_board, game.board
  end

  test "move should not change current player when game is stalemate" do
    game = Game.new
    game.board = [
      "x", "y", "x", 
      "y", "y", "x", 
      "x", "x", "y"]
    game.current_player = "y"

    game.move!(0)
     assert_equal "y", game.current_player
  end

  test "move should not change board when game is won" do
    initial_board = [
      "y", "y", "y", 
      "x", nil, "x", 
      nil, nil, nil]
    game = Game.new
    game.board = initial_board
    game.current_player = "y"

    game.move!(0)
    assert_equal initial_board, game.board
  end

  test "move should not change current player when game is won" do
    game = Game.new
    game.board = [
      "y", "y", "y", 
      "x", nil,"x", 
      nil, nil, nil]
    game.current_player = "y"

    game.move!(0)
    assert_equal "y", game.current_player
  end

  test "move should update board" do
    game = Game.new
    game.current_player = "y"

    game.move!(0)

    expected = ["y"] + 8.times.collect { nil}
    assert_equal expected, game.reload.board
  end

  test "move should update current_player" do
    game = Game.new
    game.current_player = "y"

    game.move!(0)

    assert_equal "x", game.reload.current_player
  end
end
