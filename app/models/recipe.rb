class Recipe < ApplicationRecord
    belongs_to :cuisine
    belongs_to :recipe_type
    validates :title, :recipe_type, :cuisine_id, :difficulty, :cook_time, 
              :ingredients, :cook_method, presence: {message: 'Você deve informar todos os dados da receita'}
    has_attached_file :photo
    validates_attachment_content_type :photo, content_type: /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/, message: "Por favor envie um arquivo válido"
end
