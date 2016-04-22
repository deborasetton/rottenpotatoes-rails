class Review < ActiveRecord::Base
  # Associations
  belongs_to :movie
  belongs_to :moviegoer

  # Validations would go here.
  validates            :movie_id, presence: true
  validates_associated :movie
end
