module AddressHelper
  def address_str(address)
    "#{address.street}, #{address.number}, #{address.neighborhood}"
  end
end