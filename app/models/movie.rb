# == Schema Information
#
# Table name: movies
#
#  id          :integer          not null, primary key
#  title       :string
#  year        :integer
#  duration    :integer
#  description :text
#  image_url   :string
#  director_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Movie < ApplicationRecord
    #  - director_id: must be present
    validates :director_id, :presence => true
    
    #  - title: must be present; must be unique in combination with year
    validates :title, :presence => true, :uniqueness => { :scope => :year, message: "Title and year must be unique" }
    
    #  - year: must be integer between 1870 and 2050
    validates :year, :numericality => { :only_integer => true, :greater_than => 1869, :less_than => 2051 }
    
    #  - duration: must be integer between 0 and 2764800, but it can be blank (hint: there is an option `:allow_blank => true`)
    validates :duration, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 2764800, :allow_blank => true }
    
    #  - description: no rules
    #  - image_url: no rules
    
    belongs_to :director, :class_name => "Director", :foreign_key => "director_id"
    
    has_many :characters, :class_name => "Character", :foreign_key => "movie_id"
end
