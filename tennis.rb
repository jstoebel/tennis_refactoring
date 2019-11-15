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
  def initialize(player1Name, player2Name)
    @player1Name = player1Name
    @player2Name = player2Name
    @p1points = 0
    @p2points = 0

    @player1 = Player.new player1Name
    @player2 = Player.new player2Name
  end

  def won_point(playerName)
    if playerName == @player1Name
      p1Score
    else
      p2Score
    end
  end

  def score
    result = ''

    return "#{@player1.tennis_score}-All" if tied_game? && @player1.score < 3
    return 'Deuce' if (@p1points == @p2points) && (@p1points > 2)

    p1res = ''
    p2res = ''
    if (@p1points > 0) && (@p2points == 0)
      p1res = 'Fifteen' if @p1points == 1
      p1res = 'Thirty' if @p1points == 2
      p1res = 'Forty' if @p1points == 3
      p2res = 'Love'
      result = p1res + '-' + p2res
    end
    if (@p2points > 0) && (@p1points == 0)
      p2res = 'Fifteen' if @p2points == 1
      p2res = 'Thirty' if @p2points == 2
      p2res = 'Forty' if @p2points == 3

      p1res = 'Love'
      result = p1res + '-' + p2res
    end

    if (@p1points > @p2points) && (@p1points < 4)
      p1res = 'Thirty' if @p1points == 2
      p1res = 'Forty' if @p1points == 3
      p2res = 'Fifteen' if @p2points == 1
      p2res = 'Thirty' if @p2points == 2
      result = p1res + '-' + p2res
    end
    if (@p2points > @p1points) && (@p2points < 4)
      p2res = 'Thirty' if @p2points == 2
      p2res = 'Forty' if @p2points == 3
      p1res = 'Fifteen' if @p1points == 1
      p1res = 'Thirty' if @p1points == 2
      result = p1res + '-' + p2res
    end
    if (@p1points > @p2points) && (@p2points >= 3)
      result = 'Advantage ' + @player1Name
    end
    if (@p2points > @p1points) && (@p1points >= 3)
      result = 'Advantage ' + @player2Name
    end
    if (@p1points >= 4) && (@p2points >= 0) && ((@p1points - @p2points) >= 2)
      result = 'Win for ' + @player1Name
    end
    if (@p2points >= 4) && (@p1points >= 0) && ((@p2points - @p1points) >= 2)
      result = 'Win for ' + @player2Name
    end
    result
  end

  def setp1Score(number)
    (0..number).each do |_i|
      p1Score
    end
  end

  def setp2Score(number)
    (0..number).each do |_i|
      p2Score
    end
  end

  def p1Score
    @p1points += 1
    @player1.award_point
  end

  def p2Score
    @p2points += 1
    @player2.award_point
  end

  def tied_game?
    @player1.score == @player2.score
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

    def award_point
      @score += 1
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
