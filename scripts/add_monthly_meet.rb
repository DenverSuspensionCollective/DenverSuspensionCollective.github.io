#!/usr/bin/env ruby

=begin
Script to add new monthly meet events to events.yml

Usage:
    ruby add_monthly_meet.rb --start_date YYYY-MM-DD --location "Location Name"
    ruby add_monthly_meet.rb -d YYYY-MM-DD -l "Location Name"

Examples:
    ruby add_monthly_meet.rb --start_date 2025-11-15 --location "Denver, CO"
    ruby add_monthly_meet.rb -d 2025-12-20 -l "Boulder, CO"
=end

require 'yaml'
require 'optparse'
require 'date'

class EventAdder
  def initialize
    @options = {}
    @events_file = nil
  end

  def run
    parse_arguments
    determine_events_file_path
    add_event_to_file
  rescue StandardError => e
    puts "❌ Error: #{e.message}"
    exit 1
  end

  private

  def parse_arguments
    parser = OptionParser.new do |opts|
      opts.banner = "Usage: #{$0} [options]"
      opts.separator ""
      opts.separator "Add a new monthly meet event to events.yml"
      opts.separator ""
      opts.separator "Options:"

      opts.on('-d', '--start_date DATE', 'Start date in YYYY-MM-DD format (required)') do |date|
        validate_date(date)
        @options[:start_date] = date
      end

      opts.on('-l', '--location LOCATION', 'Location for the event (required)') do |location|
        @options[:location] = location
      end

      opts.on('-h', '--help', 'Show this help message') do
        puts opts
        puts ""
        puts "Examples:"
        puts "  #{$0} --start_date 2025-11-15 --location \"Denver, CO\""
        puts "  #{$0} -d 2025-12-20 -l \"Boulder, CO\""
        exit
      end
    end

    parser.parse!

    # Check required arguments
    missing_args = []
    missing_args << '--start_date' unless @options[:start_date]
    missing_args << '--location' unless @options[:location]

    unless missing_args.empty?
      puts "❌ Error: Missing required arguments: #{missing_args.join(', ')}"
      puts ""
      puts parser
      exit 1
    end
  end

  def validate_date(date_string)
    Date.strptime(date_string, '%Y-%m-%d')
  rescue Date::Error
    raise ArgumentError, "Invalid date format: #{date_string}. Use YYYY-MM-DD format."
  end

  def determine_events_file_path
    script_dir = Pathname.new(__FILE__).dirname
    @events_file = script_dir.parent + '_data' + 'events.yml'

    unless @events_file.exist?
      raise "Events file not found: #{@events_file}"
    end
  end

  def load_events_yaml
    YAML.safe_load(File.read(@events_file), permitted_classes: [Date])
  rescue Psych::SyntaxError => e
    raise "Error parsing YAML file: #{e.message}"
  end

  def save_events_yaml(data)
    File.open(@events_file, 'w') do |file|
      file.write(YAML.dump(data))
    end
  rescue StandardError => e
    raise "Error writing YAML file: #{e.message}"
  end

  def add_monthly_meet(events_data, start_date, location)
    # Ensure monthly_meets section exists
    events_data['monthly_meets'] ||= []

    # Create new entry
    new_entry = {
      'start_date' => start_date,
      'location' => location
    }

    # Add to monthly_meets
    events_data['monthly_meets'] << new_entry

    events_data
  end

  def add_event_to_file
    puts "Loading events from: #{@events_file}"

    # Load existing events data
    events_data = load_events_yaml

    # Add new monthly meet
    events_data = add_monthly_meet(events_data, @options[:start_date], @options[:location])

    # Save updated data
    save_events_yaml(events_data)

    # Success message
    puts "✅ Successfully added monthly meet: #{@options[:start_date]} at #{@options[:location]}"
  end
end

# Run the script if called directly
if __FILE__ == $0
  EventAdder.new.run
end

