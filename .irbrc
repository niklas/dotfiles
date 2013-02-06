require "#{ENV['HOME']}/.irb/irb_require_without_bundler_hack"

require_without_bundler 'pry', 'hirb', 'rdoc/ri/driver'

#if defined?(Wirble)
#  Wirble.init
#  Wirble.colorize
#else
#  STDERR.puts "could not load wirble"
#end

if defined?(Hirb)
  Hirb::View.enable
  extend Hirb::Console
  def system_ri(*queries)
    ::Hirb::View.capture_and_render { RDoc::RI::Driver.run(queries) }
  end

  def resized
    Hirb::View.resize
  end

  def tab(obj=nil, fields)
    table obj, :fields => fields
  end
else
  STDERR.puts "could not load hirb"
end

require "#{ENV['HOME']}/.irb/trace_helpers"
require "#{ENV['HOME']}/.irb/doc_helpers"
require "#{ENV['HOME']}/.irb/profile_helpers"


def history(from=0)
  entries = Readline::HISTORY.entries
  entries = entries.split("exit").last if Array.public_instance_methods.include?('split')
  puts entries[-from..-2].join("\n")
end


if defined?(Pry)
  Pry.start
  exit
end
