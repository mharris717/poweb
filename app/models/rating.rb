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
    end_of_week = Date.new(2013,9,9)
    week = 0
    17.times do
      return week if Date.today < end_of_week
      week += 1
      end_of_week += 7
    end
    return nil
  end
  def self.fresh
    new(:week => current_week, :status => 'Open', :iterations => 10000)
  end
  def self.all_sorted
    all.sort_by { |x| x.created_at || Time.local(2011,1,1) }.reverse
  end
  def created_at_tz
    created_at ? created_at - 3600*4 : nil
  end
end