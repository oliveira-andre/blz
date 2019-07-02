class EstablishmentMailer < ApplicationMailer
  def registration_success(establishment)
    @establishment = establishment
    mail to: @establishment.user.email,
         subject: 'BLZ - Seja Bem Vindo!'
  end
end
