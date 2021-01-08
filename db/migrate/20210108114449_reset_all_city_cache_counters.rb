class ResetAllCityCacheCounters < ActiveRecord::Migration[6.0]
  def up
    City.all.each do |city|
      City.reset_counters(city.id, :restaurants)
    end
  end

  def down
    # no rollback needed
  end
end
