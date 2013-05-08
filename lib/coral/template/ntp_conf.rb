
module Coral
module Template
class NTPConf < Base
  #-----------------------------------------------------------------------------
  # Renderers  
   
  def render(input)
    output = ''
        
    case input      
    when Hash
      input.each do |name, data|
        output << render_command(name, data)
      end
    end              
    return output     
  end
  
  #-----------------------------------------------------------------------------
    
  def render_command(name, data)
    output = ''
    
    case data
    when Array
      data.each do |value|
        output << "#{name} #{value}\n"
      end
      
    when String
      output << "#{name} #{data}\n"  
    end
    return output
  end
end
end
end