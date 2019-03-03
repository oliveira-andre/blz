# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
## User

user = User.find_by email: 'rv@gmail.com'
if user.nil?
  user = User.new
  user.name = 'Rivelino'
  user.email = 'rv@gmail.com'
  user.password = '123456'
  user.password_confirmation = '123456'
  user.save!
end

## Categories

Category.find_or_create_by!(
  name: 'Cabelos',
  description: 'Breve descrição'
)

Category.find_or_create_by!(
  name: 'Esmalteria',
  description: 'Breve descrição'
)

Category.find_or_create_by!(
  name: 'Depilação',
  description: 'Breve descrição'
)

Category.find_or_create_by!(
  name: 'Penteados e maquiagens',
  description: 'Breve descrição'
)

Category.find_or_create_by!(
  name: 'Massagem',
  description: 'Breve descrição'
)

Category.find_or_create_by!(
  name: 'Pele',
  description: 'Breve descrição'
)

## EStablichment

Establishment.find_or_create_by!(
  cpf_cnpj: '510165056165161',
  name: 'Raiz',
  email: 'lugarbeleza@blz.life',
  phone: '9698989989898',
  timetable: '9:00 - 18:00',
  user_id: User.first.id
)

## Services

categories_ids = Category.ids

Service.find_or_create_by!(
  title: 'Corte feminino',
  description: 'Ao contrário do que se acredita, Lorem Ipsum não é simplesmente um texto randômico. Com mais de 2000 anos, suas raízes podem ser encontradas em uma obra de literatura latina clássica datada de 45 AC. Richard McClintock, um professor de latim do Hampden-Sydney College na Virginia',
  category_id: categories_ids.sample,
  amount: 20.0,
  duration: 30,
  establishment_id: Establishment.first.id
)

Service.find_or_create_by!(
  title: 'Massagem nas costas',
  description: 'Ao contrário do que se acredita, Lorem Ipsum não é simplesmente um texto randômico. Com mais de 2000 anos, suas raízes podem ser encontradas em uma obra de literatura latina clássica datada de 45 AC. Richard McClintock, um professor de latim do Hampden-Sydney College na Virginia',
  category_id: categories_ids.sample,
  amount: 20.0,
  duration: 30,
  establishment_id: Establishment.first.id
)

Service.find_or_create_by!(
  title: 'Unhas perfeitas',
  description: 'Ao contrário do que se acredita, Lorem Ipsum não é simplesmente um texto randômico. Com mais de 2000 anos, suas raízes podem ser encontradas em uma obra de literatura latina clássica datada de 45 AC. Richard McClintock, um professor de latim do Hampden-Sydney College na Virginia',
  category_id: categories_ids.sample,
  amount: 20.0,
  duration: 30,
  establishment_id: Establishment.first.id
)

Service.find_or_create_by!(
  title: 'Maquiagem completa',
  description: 'Ao contrário do que se acredita, Lorem Ipsum não é simplesmente um texto randômico. Com mais de 2000 anos, suas raízes podem ser encontradas em uma obra de literatura latina clássica datada de 45 AC. Richard McClintock, um professor de latim do Hampden-Sydney College na Virginia',
  category_id: categories_ids.sample,
  amount: 20.0,
  duration: 30,
  establishment_id: Establishment.first.id
)

Service.find_or_create_by!(
  title: 'Penteado para casamento',
  description: 'Ao contrário do que se acredita, Lorem Ipsum não é simplesmente um texto randômico. Com mais de 2000 anos, suas raízes podem ser encontradas em uma obra de literatura latina clássica datada de 45 AC. Richard McClintock, um professor de latim do Hampden-Sydney College na Virginia',
  category_id: categories_ids.sample,
  amount: 20.0,
  duration: 30,
  establishment_id: Establishment.first.id
)

Service.find_or_create_by!(
  title: 'Depilação a Laser',
  description: 'Ao contrário do que se acredita, Lorem Ipsum não é simplesmente um texto randômico. Com mais de 2000 anos, suas raízes podem ser encontradas em uma obra de literatura latina clássica datada de 45 AC. Richard McClintock, um professor de latim do Hampden-Sydney College na Virginia',
  category_id: categories_ids.sample,
  amount: 20.0,
  duration: 30,
  establishment_id: Establishment.first.id
)

Service.find_or_create_by!(
  title: 'Corte infantil',
  description: 'Ao contrário do que se acredita, Lorem Ipsum não é simplesmente um texto randômico. Com mais de 2000 anos, suas raízes podem ser encontradas em uma obra de literatura latina clássica datada de 45 AC. Richard McClintock, um professor de latim do Hampden-Sydney College na Virginia',
  category_id: categories_ids.sample,
  amount: 20.0,
  duration: 30,
  establishment_id: Establishment.first.id
)

Service.find_or_create_by!(
  title: 'Selagem + corte',
  description: 'Ao contrário do que se acredita, Lorem Ipsum não é simplesmente um texto randômico. Com mais de 2000 anos, suas raízes podem ser encontradas em uma obra de literatura latina clássica datada de 45 AC. Richard McClintock, um professor de latim do Hampden-Sydney College na Virginia',
  category_id: categories_ids.sample,
  amount: 20.0,
  duration: 30,
  establishment_id: Establishment.first.id
)