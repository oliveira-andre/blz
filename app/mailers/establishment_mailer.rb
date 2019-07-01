class EstablishmentMailer < ApplicationMailer
  def feedback(establishment)
    @establishment = establishment
    mail to: @establishment.user.email,
         subject: 'BLZ - Seja Bem Vindo!'
  end
end
