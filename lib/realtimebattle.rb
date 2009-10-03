$LOAD_PATH << File.dirname(__FILE__) + '/lib'

Dir.glob(File.dirname(__FILE__) + '/lib/*.rb').each do |file|
  require file
end
