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

## Establishments
emails = ['spa@blz.life', 'barber@blz.life', 'saloon@blz.life']
names = ['Spa delas', 'The barber', 'Centro da beleza']
(0..2).each do |i|
  user = User.find_by email: emails[i]
  if user.nil?
    user = User.new
    user.name = names[i]
    user.email = emails[i]
    user.password = '123456'
    user.password_confirmation = '123456'
    user.save!
  end

  e = Establishment.find_or_create_by!(
    cpf_cnpj: rand(999_999_999_99),
    name: user.name,
    email: user.email,
    phone: '69981001225',
    timetable: "#{rand(6..9)}:00 - #{rand(16..22)}:00",
    user: user
  )

  p = e.professionals.build name: 'Maria Amanda'
  p.save!
end

user = User.find_by email: 'rv@gmail.com'
if user.nil?
  user = User.new
  user.name = 'Rivelino'
  user.email = 'rv@gmail.com'
  user.password = '123456'
  user.password_confirmation = '123456'
  user.save!
end

## Services

categories_ids = Category.ids

Service.find_or_create_by!(
  title: 'Corte feminino',
  description: 'Ao contrário do que se acredita, Lorem Ipsum não é simplesmente um texto randômico. Com mais de 2000 anos, suas raízes podem ser encontradas em uma obra de literatura latina clássica datada de 45 AC. Richard McClintock, um professor de latim do Hampden-Sydney College na Virginia',
  category_id: categories_ids.sample,
  amount: 20.0,
  status: Service.statuses.keys.sample,
  local_type: Service.local_types.keys.sample,
  duration: 30,
  establishment_id: Establishment.all.sample.id
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