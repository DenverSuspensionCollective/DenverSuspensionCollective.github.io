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
    clean_old_meets
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

  def clean_old_meets
    puts "Loading events from: #{@events_file}"

    # Load existing events data
    events_data = load_events_yaml

    # Get today's date
    today = Date.today

    # Filter out past monthly meets
    if events_data['monthly_meets']
      original_count = events_data['monthly_meets'].length

      events_data['monthly_meets'] = events_data['monthly_meets'].select do |meet|
        begin
          meet_date = meet['start_date'].is_a?(Date) ? meet['start_date'] : Date.parse(meet['start_date'])
          meet_date >= today
        rescue => e
          puts "⚠️  Warning: Could not parse date '#{meet['start_date']}' for meet at #{meet['location']}: #{e.message}"
          # Keep the meet if we can't parse the date to be safe
          true
        end
      end

      removed_count = original_count - events_data['monthly_meets'].length

      if removed_count > 0
        # Save updated data
        save_events_yaml(events_data)
        puts "✅ Removed #{removed_count} past monthly meet(s)"
        puts "✅ Successfully updated #{@events_file}"
      else
        puts "ℹ️  No past monthly meets found to remove"
      end
    else
      puts "ℹ️  No monthly_meets section found in events.yml"
    end
  end
end

# Run the script if called directly
if __FILE__ == $0
  EventCleaner.new.run
end
