class Perfil < ApplicationRecord
  belongs_to :user
  has_one_attached :foto

   def nombre_completo
    "#{primer_nombre} #{segundo_nombre} #{primer_apellido} #{segundo_apellido}".squish
  end
end
