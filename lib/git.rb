$:.unshift File.join(File.dirname(__FILE__))
require 'open3'
require 'fileutils'

module Git
  class ExportDir
    VERSION = '0.0.3'

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
      cleanup(options[:working_dir])
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
          copy_file(filename, ".")
        elsif options[:interactive]
          print "Copy #{filename}? [y/N]: "
          answer = STDIN.gets.chomp
          if answer =~ /y/i
            copy_file(filename, ".")
          else
            puts "Skipping #{options[:repository]}/#{filename}"
          end
        else
          puts "Skipping #{options[:repository]}/#{filename}"
        end
      }
    end

    def cleanup(source_directory)
      print "Remove temp directory (#{filename})? [y/N]: "
      answer = STDIN.gets.chomp
      if answer =~ /y/i
        FileUtils.rm_r(source_directory)
      end
    end
  end

  def copy_file(source, destination)
    puts "Copying #{options[:repository]}/#{source}"
    FileUtils.cp_r(options[:working_dir] + '/' + source, destination)
  end
end
end
