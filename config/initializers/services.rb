# Necesario para que me cree un campo comida, ropa, ducha (servicios primarios)
# si no existen en la base de datos
if Service.where(name: 'comida').empty?
  Service.create(name: 'comida', primary: true)
end

if Service.where(name: 'ducha').empty?
  Service.create(name: 'ducha', primary: true)
end

if Service.where(name: 'ropa').empty?
  Service.create(name: 'ropa', primary: true)
end

if Service.where(name: 'desayuno').empty?
  Service.create(name: 'desayuno', primary: true)
end