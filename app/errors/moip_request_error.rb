class MoipRequestError < StandardError
  def initialize(msg)
    super(msg)
  end
end
