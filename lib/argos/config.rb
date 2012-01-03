require 'user-choices'

module Argos
  class Config < UserChoices::Command
    include UserChoices

    attr_accessor :user_choices

    def add_sources( builder )
      builder.add_source(YamlConfigFileSource, :from_complete_path, ".argos")
      builder.add_source  CommandLineSource,
                          :usage,
                            "\n",
                            "Usage: ruby #{$0} SOURCES [options]",
                            "Tags and Renames an MP3, mulitple MP3s, or a directory structure of MP3s based upon your preferences.",
                            "\n",
                            "SOURCES can be any of the following types:",
                            "\n",
                            "  * A simple filename",
                            "  * A space separated list of filenames",
                            "  * A single directory (globbing is supported)",
                            "  * A space seperated list of directories",
                            "\n",
                            "If you are on a UNIX operating system, it is suggested that you enclose your SOURCE arguments in double-quotes.",
                            "This allows EchoNest to analyze the files in parallel."
    end

    def add_choices( builder )
      builder.add_choice(:sources) { |command_line| command_line.uses_arglist }

      builder.add_choice(:api_key, :type => :string) do |command_line|
        command_line.uses_option "-a",
                                  "--api_key ECHONEST_KEY",
                                  "Your EchoNest API Key"
      end

      builder.add_choice(:start, :type => :integer, :default => 10) do |command_line|
        command_line.uses_option "-s",
                                  "--start TIME",
                                  "The start time in seconds to begin parsing each track. Defaults to 10"
      end

      builder.add_choice(:duration, :type => :integer, :default => 30) do |command_line|
        command_line.uses_option "-d",
                                  "--duration TIME",
                                  "The duration of audio in seconds to use in identification. EchoNest needs at least 20 seconds. Larger values result in longer analysis times. Defaults to 30"
      end

      builder.add_choice(:formatter, :type => :string) do |command_line|
        command_line.uses_option "-f",
                                  "--formatter FORMATTER",
                                  "TODO"
      end


      builder.add_choice(:tag, :type => :boolean, :default => true) do |command_line|
        command_line.uses_switch  "-t",
                                  "--tag",
                                  "Re-tags the MP3. Defaults to TRUE"
      end

      builder.add_choice(:rename, :type => :boolean, :default => true) do |command_line|
        command_line.uses_switch  "-r",
                                  "--rename",
                                  "Renames the MP3. Defaults to TRUE"
      end

    end

    def postprocess_user_choices
      @user_choices[:sources] = Dir['**/*.mp3'] if @user_choices[:sources].empty?
    end

    # Delegate Hash methods to @user_choices
    def method_missing( method_id, *args, &block )
      if @user_choices.respond_to?(method_id)
        @user_choices.send( method_id, *args, &block )
      else
        super
      end
    end

    def respond_to?( method_id )
      @user_choices.respond_to?(method_id) || super
    end

  end
end
