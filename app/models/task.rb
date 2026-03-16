class Task < ApplicationRecord
  belongs_to :list

  validates :title, presence: true

  before_create :set_default_position

  private

  def set_default_position
    self.position = list.tasks.maximum(:position).to_i + 1
  end
  
end
