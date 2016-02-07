
module Xcov
  class Source < Xcov::Base

    attr_accessor :name
    attr_accessor :coverage
    attr_accessor :functions
    attr_accessor :function_templates

    def initialize (name, coverage, functions)
      @name = name
      @coverage = coverage
      @functions = functions
      @displayable_coverage = self.create_displayable_coverage
    end

    def print_description
      puts "\t\t#{@name} (#{@coverage})"
      @functions.each do |function|
        function.print_description
      end
    end

    def html_value
      @function_templates = ""
      @functions.each do |function|
        @function_templates << function.html_value
      end

      Function.template("file").result(binding)
    end

    # Class methods

    def self.map dictionary
      name = dictionary["name"]
      coverage = dictionary["coverage"]
      functions = dictionary["functions"].map { |function| Function.map(function)}

      Source.new(name, coverage, functions)
    end

  end
end
