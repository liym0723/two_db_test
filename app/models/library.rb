module Library
  mattr_accessor :renv
  mattr_accessor :connection_name

  self.renv = Rails.env
  self.connection_name = "library_#{renv}"
end
