class Tour < ApplicationRecord
  has_many :steps
  
  def est_time
    time = 0
    self.steps.each do |step|
      time += step.est_time
    end
    return time
  end

end
