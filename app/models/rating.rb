class Rating
  include Mongoid::Document
  include Mongoid::Timestamps
  field :raw_str
  field :week, :type => Fixnum
  field :output_page
  field :status
  field :iterations, :type => Fixnum
  
  before_save do |obj|
    obj.status = 'Done' if obj.status == 'Open' && obj.output_page.present?
    obj.iterations ||= 1000
  end
  
  def self.current_week
    h = {}
    d = Date.new(2011,9,11)
    i = 0
    (0...17).each do |xx|
      return i if Date.today < d
      i += 1
      d += 7
    end
    return nil
  end
  def self.fresh
    new(:week => current_week, :status => 'Open', :iterations => 1000)
  end
end