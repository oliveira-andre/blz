## Categories
Category.find_or_create_by!(
  name: 'Corpo',
  description: 'Cuidados com o corpo, como depilação, massagens, etc.'
)
Category.find_or_create_by!(
  name: 'Unhas',
  description: 'Tudo para unhas: manicure e pedicute'
)
Category.find_or_create_by!(
  name: 'Barbearia',
  description: 'Cuidados para os homens'
)
Category.find_or_create_by!(
  name: 'Cabelo',
  description: 'Cortes, penteados. pintura e alisamentos. Tudo para o cabelo'
)
Category.find_or_create_by!(
  name: 'Maquiagem',
  description: 'Maquiagem para casamento, festas, entre outros e design de sobracelha'
)
Category.find_or_create_by!(
  name: 'Outros',
  description: 'Demais categorias'
)

## User
User.create!(
  email: 'example@blz.life',
  name: 'Example Silva',
  cpf: '478.729.950-69',
  password: '123456',
  phone: '699810012225',
  birth_date: DateTime.now - 18.years,
  terms_acceptation: true
)

## Establishment
Establishment.create!(
  name: 'Example BLZ',
  timetable: '08:00 ás 18:00',
  user_id: User.first.id
)

## Address
Address.create!(
  street: 'Rua Indepêndia',
  number: '2803',
  neighborhood: 'Liberdade',
  zipcode: '76820518',
  addressable: Establishment.first
)

categories_ids = Category.all.ids

Service.find_or_create_by!(
  title: 'Selagem com corte feminino',
  description: 'Ao contrário do que se acredita, Lorem Ipsum não é simplesmente um texto randômico. Com mais de 2000 anos, suas raízes podem ser encontradas em uma obra de literatura latina clássica datada de 45 AC. Richard McClintock, um professor de latim do Hampden-Sydney College na Virginia',
  category_id: categories_ids.sample,
  amount: 280.0,
  status: :approved,
  local_type: Service.local_types.keys.sample,
  duration: 150,
  establishment_id: Establishment.all.sample.id
)

Professional.create!(
  name: 'Clariane Viera',
  description: '10 anos de experiência com cortes de cabelos femininos',
  establishment_id: Establishment.first.id
)

ProfessionalService.create!(
  professional_id: Professional.first.id,
  service_id: Service.first.id
)

Service.find_or_create_by!(
  title: 'Massagem nas costas',
  description: 'Ao contrário do que se acredita, Lorem Ipsum não é simplesmente um texto randômico. Com mais de 2000 anos, suas raízes podem ser encontradas em uma obra de literatura latina clássica datada de 45 AC. Richard McClintock, um professor de latim do Hampden-Sydney College na Virginia',
  category_id: categories_ids.sample,
  amount: 20.0,
  status: Service.statuses.keys.sample,
  local_type: Service.local_types.keys.sample,
  duration: 30,
  establishment_id: Establishment.all.sample.id
)

Service.find_or_create_by!(
  title: 'Unhas perfeitas',
  description: 'Ao contrário do que se acredita, Lorem Ipsum não é simplesmente um texto randômico. Com mais de 2000 anos, suas raízes podem ser encontradas em uma obra de literatura latina clássica datada de 45 AC. Richard McClintock, um professor de latim do Hampden-Sydney College na Virginia',
  category_id: categories_ids.sample,
  amount: 20.0,
  status: Service.statuses.keys.sample,
  local_type: Service.local_types.keys.sample,
  duration: 30,
  establishment_id: Establishment.all.sample.id
)

Service.find_or_create_by!(
  title: 'Maquiagem completa',
  description: 'Ao contrário do que se acredita, Lorem Ipsum não é simplesmente um texto randômico. Com mais de 2000 anos, suas raízes podem ser encontradas em uma obra de literatura latina clássica datada de 45 AC. Richard McClintock, um professor de latim do Hampden-Sydney College na Virginia',
  category_id: categories_ids.sample,
  amount: 20.0,
  status: Service.statuses.keys.sample,
  local_type: Service.local_types.keys.sample,
  duration: 30,
  establishment_id: Establishment.all.sample.id
)

Service.find_or_create_by!(
  title: 'Penteado para casamento',
  description: 'Ao contrário do que se acredita, Lorem Ipsum não é simplesmente um texto randômico. Com mais de 2000 anos, suas raízes podem ser encontradas em uma obra de literatura latina clássica datada de 45 AC. Richard McClintock, um professor de latim do Hampden-Sydney College na Virginia',
  category_id: categories_ids.sample,
  amount: 20.0,
  status: Service.statuses.keys.sample,
  local_type: Service.local_types.keys.sample,
  duration: 30,
  establishment_id: Establishment.all.sample.id
)

Service.find_or_create_by!(
  title: 'Depilação a Laser',
  description: 'Ao contrário do que se acredita, Lorem Ipsum não é simplesmente um texto randômico. Com mais de 2000 anos, suas raízes podem ser encontradas em uma obra de literatura latina clássica datada de 45 AC. Richard McClintock, um professor de latim do Hampden-Sydney College na Virginia',
  category_id: categories_ids.sample,
  amount: 20.0,
  status: Service.statuses.keys.sample,
  local_type: Service.local_types.keys.sample,
  duration: 30,
  establishment_id: Establishment.all.sample.id
)

Service.find_or_create_by!(
  title: 'Corte infantil',
  description: 'Ao contrário do que se acredita, Lorem Ipsum não é simplesmente um texto randômico. Com mais de 2000 anos, suas raízes podem ser encontradas em uma obra de literatura latina clássica datada de 45 AC. Richard McClintock, um professor de latim do Hampden-Sydney College na Virginia',
  category_id: categories_ids.sample,
  amount: 20.0,
  status: Service.statuses.keys.sample,
  local_type: Service.local_types.keys.sample,
  duration: 30,
  establishment_id: Establishment.all.sample.id
)

Service.find_or_create_by!(
  title: 'Selagem + corte',
  description: 'Ao contrário do que se acredita, Lorem Ipsum não é simplesmente um texto randômico. Com mais de 2000 anos, suas raízes podem ser encontradas em uma obra de literatura latina clássica datada de 45 AC. Richard McClintock, um professor de latim do Hampden-Sydney College na Virginia',
  category_id: categories_ids.sample,
  amount: 20.0,
  status: Service.statuses.keys.sample,
  local_type: Service.local_types.keys.sample,
  duration: 30,
  establishment_id: Establishment.all.sample.id
)