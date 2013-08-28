class App

  attr_accessor :name, :path

  def self.all
    Dir["/apps/*"].map{ |p| App.new(p) }.select{ |h| h.valid  }
  end

  def initialize path
    self.path = path
    self.name = path.match(/[^\/]+\/$/).to_s[0..-2]
  end

  def autostart?
    `ls #{path}/start_me` != ""
  end

  def autostart (value)
    `rm -f #{path}/start_me` unless value
    `touch #{path}/start_me` if value
  end

  def command cmd
    `cd #{path} && ./root/app #{cmd}`
  end

  def to_hash
    {
      :path => self.path,
      :autostart => self.autostart?,
      :name => self.name
    }
  end

  def valid
    !Dir.glob("#{path}/boot/app").empty?
  end


end
