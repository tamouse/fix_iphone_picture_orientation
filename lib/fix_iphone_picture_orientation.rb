require 'json'
require "fix_iphone_picture_orientation/version"
require "fix_iphone_picture_orientation/cmd_runner"
require 'methadone'


module FixIphonePictureOrientation

  extend Methadone::CLILogging
  
  def self.run(dir)
    rotate_pictures(dir,build_work_list(dir)).empty?
  end
  

  def self.build_work_list(dir)
    Dir.chdir(dir) do |dir|
      o, e, st = CmdRunner.run("exiftool -j -ORIENTATION #{file_list(dir).join(" ")}")
      raise "exiftool failed: #{st.exitstatus} #{e}" unless st.success?
      list = ::JSON.parse(o)
      list.map!{|i| ::OpenStruct.new(i)}
      list.reject!{|i| i.Orientation == "Horizontal (normal)"}
    end
  end

  def self.rotate_pictures(dir,list)
    Dir.chdir(dir) do |dir|
      list.each do |image|
        rotate = 0
        case image.Orientation
        when /90 CW/
          rotate = 90
        when /180/
          rotate = 180
        when /270 CW/
          rotate = -90
        end
        info "Converting #{image.SourceFile}"
        o,e,st = CmdRunner.run("mogrify -verbose -rotate '#{rotate}' '#{image.SourceFile}'")
        raise "mogrify failed: #{st.exitstatus} #{e}" unless st.success?
        o,e,st = CmdRunner.run("exiftool -ORIENTATION=\"Horizontal (normal)\" '#{image.SourceFile}'")
        raise "exiftool failed: #{st.exitstatus} #{e}" unless st.success?
      end
      build_work_list(dir)
    end
  end

  def self.file_list(dir=Dir.pwd)
    Dir.chdir(dir) do |dir|
      Dir["*.JPG","*.jpg","*.PNG","*.png","*.JEPG","*.jpeg"]
    end
  end

end
