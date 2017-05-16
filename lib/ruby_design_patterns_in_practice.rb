Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), "ruby_design_patterns_in_practice")) + "/**/*.rb"].each do |file|
    require file
end

module RubyDesignPatternsInPractice
end
