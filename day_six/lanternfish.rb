# frozen_string_literal: true

class LanternFish
  attr_accessor(:days_to_replication)

  def initialize(days_to_replication)
    @days_to_replication = days_to_replication
  end

  def tick
    replicating? ? @days_to_replication = 6 : @days_to_replication -= 1
  end

  def replicating?
    @days_to_replication.zero?
  end
end
