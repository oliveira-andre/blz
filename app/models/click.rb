class Click < ActiveRecord::Base
  def self.create(service_id)
    service = $redis.get service_id
    if service
      $redis.incr service_id, (service + 1)
    else
      $redis.incr service_id, 1
    end
  end
end
