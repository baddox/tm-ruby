class Move
  LEFT = Move.new
  RIGHT = Move.new
  NONE = Move.new

  def left?
    self == LEFT
  end

  def right?
    self == RIGHT
  end

  def none?
    self == NONE
  end

  def verb_phrase
    if left?
      "move left"
    elsif right?
      "move right"
    elsif none?
      "not move"
    end
  end

  def to_s
    if left?
      "Move::LEFT"
    elsif right?
      "Move::RIGHT"
    elsif none?
      "Move::NONE"
    end
  end
end