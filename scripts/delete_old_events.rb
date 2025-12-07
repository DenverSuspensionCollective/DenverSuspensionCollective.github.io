#!/usr/bin/env ruby

require 'yaml'
require 'date'
require 'pathname'

class EventCleaner
  def initialize
    @events_file = nil
  end

  def run
    determine_events_file_path
    delete_old_events
  rescue StandardError => e
    puts "❌ Error: #{e.message}"
    exit 1
  end

  private

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

  def delete_old_events
    puts "Loading events from: #{@events_file}"

    # Load existing events data
    events_data = load_events_yaml

    # Get today's date
    today = Date.today

    # Filter out past events
    if events_data['upcoming_events']
      original_count = events_data['upcoming_events'].length

      events_data['upcoming_events'] = events_data['upcoming_events'].select do |event|
        begin
          event_date = event['start_date'].is_a?(Date) ? event['start_date'] : Date.parse(event['start_date'])
          event_date >= today
        rescue => e
          puts "⚠️  Warning: Could not parse date '#{event['start_date']}' for event at #{event['location']}: #{e.message}"
          # Keep the event if we can't parse the date to be safe
          true
        end
      end

      removed_count = original_count - events_data['upcoming_events'].length

      if removed_count > 0
        # Save updated data
        save_events_yaml(events_data)
        puts "✅ Removed #{removed_count} past event(s)"
        puts "✅ Successfully updated #{@events_file}"
      else
        puts "ℹ️  No past events found to remove"
      end
    else
      puts "ℹ️  No upcoming_events section found in events.yml"
    end
  end
end

# Run the script if called directly
if __FILE__ == $0
  EventCleaner.new.run
end
