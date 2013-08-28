class App < Struct.new(:path)
  BLACKLIST = ["LICENSE",
               "README.md",
               ".gitignore",
               ".",
               "..",
               ".gitignore",
               "common",
               "definitions",
               "examples"]

  class << self
    def all
      Dir["/apps/*"].map{ |p| App.new(p) }.select{ |h| h.valid?  }
    end
  end

  def name
    #@name ||= path.match(/[^\/]+$/).to_s[0..-2]
    @name ||= path.split('/').last
  end

  def start_me
    "#{path}/start_me"
  end

  def autostart?
    File.exists?(start_me)
  end

  def autostart value
    value ?  FileUtils.touch(start_me) : File.delete(start_me)
  end

  def command cmd, scope = 'app'
    Dir.chdir(path) do
     IO.popen "./boot/#{scope} #{cmd}"
    end
  end

  def to_hash
    {
      path:       path,
      autostart:  autostart?,
      name:       name,
      scopes:     scopes
    }
  end

  def valid?
    !Dir.glob("#{path}/boot/app").empty?
  end

  def scopes
    Dir.entries("#{path}/boot") - BLACKLIST
  end

end
