
require_relative "./hand.rb"

class HandComparer

  def pick_winner(a, b)
    return 1 if a.royal_flush?
    return 2 if b.royal_flush?

    return 1 if a.straight_flush?
    return 2 if b.straight_flush?

    return 1 if a.four_of_a_kind?
    return 2 if b.four_of_a_kind?

    return 1 if a.full_house?
    return 2 if b.full_house?

    return 1 if a.flush?
    return 2 if b.flush?

    return 1 if a.straight?
    return 2 if b.straight?

    return 1 if a.three_of_a_kind?
    return 2 if b.three_of_a_kind?

    return 1 if a.two_pair?
    return 2 if b.two_pair?

return 3
    return 1 if a.straight_flush?
    return 2 if b.straight_flush?

  end
end

