# Lookup the loopback address from a spreadsheet, worksheet.
# If an entry exists for this host, return it,
# else grab the first NULL entry and assign it to us.

require 'spreadsheet'


module Puppet::Parser::Functions
  newfunction(:get_loopback, :type => :rvalue) do |args|

    file = args[0]
    sheet = 'loopbacks'
    key_fact = 'hostname'
    stagefile = file + '.bak'

    changed = 0
    key = lookupvar(key_fact)
    value = nil
    Spreadsheet.open(file) do |book|
      book.worksheet(sheet).each do |row|
        if key == row[1]
          value = row[0]
          break
        elsif row[0] && row[1].nil?
          row[1] = key
          changed = 1
          value = row[0]
          break
        end
      end
      if changed == 1
        book.write(stagefile)
        File.rename(stagefile, file)
      end
    end
    value
  end
end
