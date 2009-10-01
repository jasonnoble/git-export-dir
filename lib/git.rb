$:.unshift File.join(File.dirname(__FILE__))
require 'open3'
require 'fileutils'

module Git
  class ExportDir
    VERSION = '0.0.1'

    attr_reader :options
    def initialize(options = {})
      @options = options
    end

    def self.version
      VERSION
    end

    def export
      unless clone(options[:repository])
        puts "Error cloning #{options[:repository]} to #{options[:working_dir]}"
        exit 1
      end
      copy_directories(options[:working_dir])
    end

    private
    def clone(repository)
      _, out, err = Open3.popen3("git clone #{repository} #{options[:working_dir]}")

      out = out.read.strip
      err = err.read.strip

      return false if err.any?
      return true
    end
    
    def copy_directories(source_directory)
      Dir.new(source_directory).each{ |filename| 
        if filename =~ /^\.{1,2}$/ || filename =~ /^.git$/
          next
        end
        if options[:directories].include?(filename)
          copy_file(options[:working_dir] + '/' + filename, ".")
        elsif options[:interactive]
          print "Copy #{filename}? [y/N]: "
          answer = STDIN.gets.chomp
          if answer =~ /y/i
            copy_file(options[:working_dir] + '/' + filename, ".")
          else
            puts "Skipping #{filename}"
          end
        else
          puts "Skipping #{filename}"
        end
      }
    end
    
    def copy_file(source, destination)
      puts "Copying #{source}"
      FileUtils.cp_r(source, destination)
    end
  end
end