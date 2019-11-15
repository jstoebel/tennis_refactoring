# frozen_string_literal: true

class TennisGame1
  def initialize(_player1_name, _player2_name)
    @p1points = 0
    @p2points = 0
  end

  def won_point(player_name)
    if player_name == 'player1'
      @p1points += 1
    else
      @p2points += 1
    end
  end

  def score
    if @p1points == @p2points
      tied_score
    elsif (@p1points >= 4) || (@p2points >= 4)
      end_game_score
    else
      standard_score
    end
  end

  private

  def tied_score
    return 'Deuce' if @p1points > 2

    "#{tennis_score(@p1points)}-All"
  end

  def end_game_score
    player1_lead = @p1points - @p2points
    if player1_lead == 1
      'Advantage player1'
    elsif player1_lead == -1
      'Advantage player2'
    elsif player1_lead >= 2
      'Win for player1'
    else
      'Win for player2'
    end
  end

  def standard_score
    [@p1points, @p2points].map { |n| tennis_score(n) }.join('-')
  end

  def tennis_score(numeric_score)
    {
      0 => 'Love',
      1 => 'Fifteen',
      2 => 'Thirty',
      3 => 'Forty'
    }[numeric_score]
  end
end

class TennisGame2
  def initialize(player1_name, player2_name)
    @player1 = Player.new player1_name
    @player2 = Player.new player2_name
  end

  def won_point(player_name)
    if player_name == @player1.name
      @player1.award
    else
      @player2.award
    end
  end

  def score
    if tied_game?
      tied_game_score
    elsif mid_game?
      mid_game_score
    elsif late_game?
      late_game_score
    else
      end_game_score
    end
  end

  def tied_game?
    @player1.score == @player2.score
  end

  def tied_game_score
    return 'Deuce' if @player1.score > 2

    "#{@player1.tennis_score}-All"
  end

  # if niether player has more than 3 points
  def mid_game?
    @player1.score <= 3 && @player2.score <= 3
  end

  def mid_game_score
    [@player1.tennis_score, @player2.tennis_score].join('-')
  end

  # both platers have at least 3 points
  def late_game?
    @player1.score >= 3 && @player2.score >= 3 && !end_game?
  end

  def late_game_score
    _follower, leader = follower_leader

    "Advantage #{leader.name}"
  end

  # somebody has won
  def end_game?
    follower, leader = follower_leader
    leader.score >= 4 && leader.score - follower.score >= 2
  end

  def end_game_score
    _follower, leader = follower_leader

    "Win for #{leader.name}"
  end

  def follower_leader
    [@player1, @player2].sort
  end

  class Player
    attr_reader :score, :name
    def initialize(name)
      @name = name
      @score = 0
    end

    def award
      @score += 1
    end

    def tennis_score
      {
        0 => 'Love',
        1 => 'Fifteen',
        2 => 'Thirty',
        3 => 'Forty'
      }[@score]
    end

    def <(other)
      score < other.score
    end

    def >(other)
      score > other.score
    end

    def <=>(other)
      return -1 if score < other.score
      return 0 if score == other.score
      return 1 if score > other.score
    end
  end
end

class TennisGame3
  def initialize(player1Name, player2Name)
    @p1N = player1Name
    @p2N = player2Name
    @p1 = 0
    @p2 = 0
  end

  def won_point(n)
    if n == @p1N
      @p1 += 1
    else
      @p2 += 1
    end
  end

  def score
    if ((@p1 < 4) && (@p2 < 4)) && (@p1 + @p2 < 6)
      p = %w[Love Fifteen Thirty Forty]
      s = p[@p1]
      @p1 == @p2 ? s + '-All' : s + '-' + p[@p2]
    else
      if @p1 == @p2
        'Deuce'
      else
        s = @p1 > @p2 ? @p1N : @p2N
        (@p1 - @p2) * (@p1 - @p2) == 1 ? 'Advantage ' + s : 'Win for ' + s
      end
    end
  end
end
