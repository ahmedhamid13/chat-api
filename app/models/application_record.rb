class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  def as_json(options = {})
    options[:except] ||= :id
    super
  end
end
