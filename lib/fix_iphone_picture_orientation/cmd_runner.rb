require 'methadone'
require 'open3'

module FixIphonePictureOrientation::CmdRunner
  
  extend Methadone::CLILogging

  def self.run(cmd,*args)
    Open3.capture3(cmd,*args)
  end
  
end
