class Movie < ActiveRecord::Base

  GRANDFATHERED_DATE = Date.parse('1 Nov 1968')
  RATINGS = %w[G PG PG-13 R NC-17]

  # Associations
  has_many :reviews, dependent: :destroy
  has_many :moviegoers, through: :reviews

  # Validations
  validates :title, :release_date, presence: true
  validate  :released_1930_or_later
  validates :rating, inclusion: { in: RATINGS }, unless: :grandfathered?

  # Callbacks
  before_save :capitalize_title

  # Scopes
  scope :for_kids, -> { where(rating: ['G', 'PG']) }

  scope :with_good_reviews, ->(threshold) {
    joins(:reviews).group(:movie_id).having("AVG(reviews.potatoes) > ?", threshold.to_i)
  }

  def self.all_ratings
    RATINGS
  end

  def released_1930_or_later
    if release_date && release_date < Date.parse('Jan 1930')
      errors.add(:release_date, 'must be 1930 or later')
    end
  end

  def grandfathered?
    release_date && release_date < GRANDFATHERED_DATE
  end

  def capitalize_title
    self.title = title.split(/\s+/)
                      .map(&:downcase)
                      .map(&:capitalize)
                      .join(' ')
  end

end
