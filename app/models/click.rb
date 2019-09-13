class Click < ActiveRecord::Base
  def self.create(service_id)
    service_click_times = $redis.get service_id
    if service_click_times
      $redis.incr service_id
    else
      $redis.set service_id, 1
    end
  end
end
