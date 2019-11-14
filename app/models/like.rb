class Like < ApplicationRecord
  belongs_to :likeable, polymorphic: true
  belongs_to :author
end
