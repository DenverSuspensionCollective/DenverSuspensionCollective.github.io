#!/usr/bin/env ruby

=begin
Script to add new events to events.yml

Usage:
    ruby add_event.rb --start_date YYYY-MM-DD --location "Location Name" [--event_type TYPE]
    ruby add_event.rb -d YYYY-MM-DD -l "Location Name" [-t TYPE]

Event types:
    monthly_meet (default) - Regular monthly meet
    hook_pull - Community hook pull event

Examples:
    ruby add_event.rb --start_date 2025-11-15 --location "Denver, CO"
    ruby add_event.rb -d 2025-12-20 -l "Boulder, CO"
    ruby add_event.rb --start_date 2025-11-15 --location "Denver, CO" --event_type hook_pull
=end

require 'yaml'
require 'optparse'
require 'date'
require 'pathname'

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
      opts.separator "Add a new event to events.yml"
      opts.separator ""
      opts.separator "Options:"

      opts.on('-d', '--start_date DATE', 'Start date in YYYY-MM-DD format (required)') do |date|
        validate_date(date)
        @options[:start_date] = date
      end

      opts.on('-l', '--location LOCATION', 'Location for the event (required)') do |location|
        @options[:location] = location
      end

      opts.on('-t', '--event_type TYPE', 'Event type: monthly_meet or hook_pull (optional, defaults to monthly_meet)') do |type|
        validate_event_type(type)
        @options[:event_type] = type
      end

      opts.on('-h', '--help', 'Show this help message') do
        puts opts
        puts ""
        puts "Examples:"
        puts "  #{$0} --start_date 2025-11-15 --location \"Denver, CO\""
        puts "  #{$0} -d 2025-12-20 -l \"Boulder, CO\""
        puts "  #{$0} --start_date 2025-11-15 --location \"Denver, CO\" --event_type hook_pull"
        exit
      end
    end

    parser.parse!

    # Set default event type if not provided
    @options[:event_type] ||= 'monthly_meet'

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

  def validate_event_type(type)
    valid_types = ['monthly_meet', 'hook_pull']
    unless valid_types.include?(type)
      raise ArgumentError, "Invalid event type: #{type}. Valid options are: #{valid_types.join(', ')}"
    end
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

  def add_event(events_data, start_date, location, event_type)
    # Ensure upcoming_events section exists
    events_data['upcoming_events'] ||= []

    # Create new entry
    new_entry = {
      'start_date' => start_date,
      'location' => location
    }

    # Set name field based on event type
    if event_type == 'hook_pull'
      new_entry['name'] = 'Community Hook Pull'
    end

    # Add to upcoming events
    events_data['upcoming_events'] << new_entry

    events_data
  end

  def add_event_to_file
    puts "Loading events from: #{@events_file}"

    # Load existing events data
    events_data = load_events_yaml

    # Add new event
    events_data = add_event(events_data, @options[:start_date], @options[:location], @options[:event_type])

    # Save updated data
    save_events_yaml(events_data)

    # Success message
    event_description = @options[:event_type] == 'hook_pull' ? 'hook pull' : 'monthly meet'
    puts "✅ Successfully added #{event_description}: #{@options[:start_date]} at #{@options[:location]}"
  end
end

# Run the script if called directly
if __FILE__ == $0
  EventAdder.new.run
end

