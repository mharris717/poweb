class InputFile
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body
  field :file_type

  validates_uniqueness_of :file_type
  validates_presence_of :file_type, :body
end
