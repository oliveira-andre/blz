# frozen_string_literal: true

## Categories
Category.find_or_create_by!(
  name: 'Barbearia',
  description: 'Cuidados para os homens',
  order: 1
)

Category.find_or_create_by!(
  name: 'Cabelo',
  description: 'Cortes, penteados. pintura e alisamentos. Tudo para o cabelo',
  order: 2
)

Category.find_or_create_by!(
  name: 'Corpo',
  description: 'Cuidados com o corpo, como depilação, massagens, etc.',
  order: 3
)

Category.find_or_create_by!(
  name: 'Maquiagem',
  description: 'Maquiagem para casamento, festas, entre outros e design de sobracelha',
  order: 4
)

Category.find_or_create_by!(
  name: 'Unhas',
  description: 'Tudo para unhas: manicure e pedicute',
  order: 5
)

Category.find_or_create_by!(
  name: 'Outros',
  description: 'Demais categorias',
  order: 6
)
