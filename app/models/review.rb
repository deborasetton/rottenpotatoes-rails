class Review < ActiveRecord::Base
  # Associations
  belongs_to :movie
  belongs_to :moviegoer

  # Validations would go here.
  # ...
end
