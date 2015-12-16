module MethodAnnotation
  class Trace < MethodAnnotation::Base
    self.annotation_name = 'trace'
    self.describe = 'Output the trace. It is still a prototype'

    around do |param|
      results = []
      trace = TracePoint.new(:call) do |tp|
        results << "  #{tp.path}:#{tp.lineno}: in `#{tp.method_id}'"
      end

      return_value = nil
      trace.enable { return_value = param.original.call(param) }

      start_message = "<===== #{self.class}.#{param.method_name} trace =====>"
      puts start_message
      results.reverse.each { |v| puts v }
      return_value
      puts "<#{'=' * (start_message.size - 2)}>"
    end
  end
end
