module FileHelper
  def send_file_in(path, options = {})
    options   = { disposition: 'inline' }.merge options
    extension = options.delete(:extension) || File.extname(path) 
    name      = options.delete(:name)      || File.basename(path, extension)
    
    options[:filename] = "#{name.gsub(/\W/, '-')}#{extension}"
    
    send_file File.join(Rails.root, path), options 
  end
end
