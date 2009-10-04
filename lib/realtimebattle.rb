String.class_eval do
  def underscore
    gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
  end
end

Module.module_eval do
  
  
  def const_missing_with_autoloading(const)
    file = Dir.glob(File.dirname(__FILE__) + "/realtimebattle/**/#{const.to_s.underscore}.rb").first
    if File.exist?(file)
      require file
      const_get const
    else
      raise NameError.new("uninitialized constant #{const}")
    end
  end
  
  alias_method :const_missing_without_autoloading, :const_missing
  alias_method :const_missing, :const_missing_with_autoloading
end