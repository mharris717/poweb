class Rating
  include Mongoid::Document
  include Mongoid::Timestamps
  field :raw_str
  field :week, :type => Fixnum
  field :output_page
  field :status
  field :iterations, :type => Fixnum
  
  before_save do |obj|
    obj.status = 'Done' if obj.status == 'Open' && obj.output_page.present? && !(obj.output_page =~ /processing error/i)
    obj.iterations ||= 10000
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
    new(:week => current_week, :status => 'Open', :iterations => 10000)
  end
  def self.all_sorted
    all.sort_by { |x| x.created_at || Time.local(2011,1,1) }.reverse
  end
end