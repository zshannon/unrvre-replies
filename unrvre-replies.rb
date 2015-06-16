require 'sqlite3'

db = SQLite3::Database.new "/Users/zcs/Library/Messages/chat.db"

message_table_index_to_column_name = {}

db.execute("PRAGMA table_info(message);") do |result|
  message_table_index_to_column_name[result[0]] = result[1].to_sym
end

my_messages = []

db.execute( "SELECT * FROM message WHERE is_from_me = 1" ) do |row|
  message = {}
  row.each_with_index do |column, i|
    message[message_table_index_to_column_name[i]] = column
  end
  my_messages << message
end

puts "Found #{my_messages.count} messages."