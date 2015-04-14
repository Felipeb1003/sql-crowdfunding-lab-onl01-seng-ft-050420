require_relative 'environment'
class SQLRunner
  def initialize(db)
    @db = db
  end

  def execute_create_sql
    sql = File.read('lib/create.sql')
    execute_sql(sql)
  end

  def execute_insert_sql
    sql = File.read('lib/insert.sql')
    execute_sql(sql)
  end

  def execute_encoded_data
    encoded_data = "SU5TRVJUIElOVE8gdXNlcnMgKGlkLCBuYW1lLCBhZ2UpIFZBTFVFUyAoMSwg\nJ0Zpbm5lYmFyJywgMTcpLCAoMiwgJ0JlYXInLCA2KSwgKDMsICdJZ3VhbmEn\nLCA0KSwgKDQsICdBbGV4JywgMzMpLCAKKDUsICdBbWFuZGEnLCAyNCksICg2\nLCAnU29waGllJywgMjQpLCAoNywgJ1Jvc2V5JywgOSksICg4LCAnVmljdG9y\naWEnLCAyMyksICg5LCAnRnJhbnonLCAxMDApLCAoMTAsICdIZXJtaW9uZScs\nIDMwKSwgCigxMSwgJ1ZvbGRlbW9ydCcsIDkwKSwgKDEyLCAnTWFyaXNhJywg\nMjQpLCAoMTMsICdTd2l6emxlJywgNCksICgxNCwgJ1Npcml1cycsIDM2KSwg\nKDE1LCAnQWxidXMnLCAxMTMpLCAoMTYsICdTcXVpZCcsIDUpLCAKKDE3LCAn\nV2hhbGUnLCA2KSwgKDE4LCAnUGFjaGEnLCA1KSwgKDE5LCAnRW5hJywgMjQp\nLCAoMjAsICdLYXRpZScsIDI0KTsKCklOU0VSVCBJTlRPIHByb2plY3RzIChp\nZCwgdGl0bGUsIGNhdGVnb3J5LCBmdW5kaW5nX2dvYWwsIHN0YXJ0X2RhdGUs\nIGVuZF9kYXRlKSBWQUxVRVMgCigxLCAnSGVscCBtZSBidXkgYSBndWl0YXIn\nLCAnbXVzaWMnLCA1MDAuMDAsICcyMDEzLTA2LTMwJywgJzIwMTMtMDctMzAn\nKSwgCigyLCAnTXkgYm9vayBvbiBTUUwnLCAnYm9va3MnLCAyMC4wMCwgJzIw\nMTMtMDEtMDEnLCAnMjAxNC0wMS0wMScpLCAKKDMsICdUaGUgbmV4dCBIYXJy\neSBQb3R0ZXInLCAnYm9va3MnLCAxMDAwLjAwLCAnMjAxMy0wNS0zMCcsICcy\nMDE1LTA1LTMwJyksIAooNCwgJ0FuaW1hbCBzaGVsdGVyIG5lZWRzIGRvZyBm\nb29kJywgJ2NoYXJpdHknLCA0MDAuMDAsICcyMDEzLTAzLTE0JywgJzIwMTMt\nMDYtMzAnKSwgCig1LCAnVm9sZGVtZW50IG5lZWRzIGEgYm9keScsICdjaGFy\naXR5JywgNjAwMC4wMCwgJzIwMTMtMDMtMjAnLCAnMjAxMy0wOS0yMCcpLCAK\nKDYsICdUaGUgbmV4dCBJbm5hLUdhZGRhLURhdmlkYScsICdtdXNpYycsIDIw\nMC4wMCwgJzIwMTQtMTItMzAnLCAnMjAxNS0xMi0zMCcpLCAKKDcsICdJZ3Vh\nbmEgbmVlZHMgdGFpbCBvcGVyYXRpb24nLCAnY2hhcml0eScsIDIwMDAuMDAs\nICcyMDEzLTEwLTAyJywgJzIwMTMtMTAtMzAnKSwgCig4LCAnSSBoYXZlIGJl\nZCBidWdzIScsICdjaGFyaXR5JywgODAwLjAwLCAnMjAxNC0wNi0zMCcsICcy\nMDE0LTA2LTMxJyksIAooOSwgJ0kgd2FudCB0byB0ZWFjaCBFbmdsaXNoIGlu\nIENoaW5hJywgJ2NoYXJpdHknLCAzMDAwLjAwLCAnMjAxMy0wNi0zMCcsICcy\nMDEzLTA5LTMwJyksIAooMTAsICdIZWxwIHNhdmUgYmlyZHMgb2YgcGFyYWRp\nc2UnLCAnY2hhcml0eScsIDUwMDAuMDAsICcyMDEyLTAzLTIwJywgJzIwMTMt\nMDYtMzAnKTsKCklOU0VSVCBJTlRPIHBsZWRnZXMgKGlkLCBhbW91bnQsIHVz\nZXJfaWQsIHByb2plY3RfaWQpIFZBTFVFUwooMSwgMTAuMDAsIDEsIDIpLCAK\nKDIsIDIwLjAwLCAxLCAzKSwgCigzLCA0MC4wMCwgMSwgNCksIAooNCwgNTAu\nMDAsIDIsIDMpLCAKKDUsIDEwLjAwLCAzLCAyKSwgCig2LCAyMC4wMCwgNCwg\nNCksIAooNywgNDAuMDAsIDUsIDEwKSwgCig4LCA2MC4wMCwgNiwgMTApLCAK\nKDksIDUwLjAwLCA3LCA5KSwgCigxMCwgNzAwLjAwLCA4LCA4KSwgCigxMSwg\nMTAwMC4wMCwgOCwgNyksIAooMTIsIDQwLjAwLCA5LCA2KSwgCigxMywgNTAu\nMDAsIDksIDMpLCAKKDE0LCA1MC4wMCwgMTAsIDQpLCAKKDE1LCAyNC4wMCwg\nMTIsIDEpLCAKKDE2LCAzNC4wMCwgMTEsIDEpLCAKKDE3LCAxMi4wMCwgMTMs\nIDYpLCAKKDE4LCAxOS4wMCwgMTQsIDUpLCAKKDE5LCAyMC4wMCwgMTUsIDUp\nLCAKKDIwLCA0MC4wMCwgMTYsIDYpLCAKKDIxLCAzNS41MCwgMTcsIDcpLCAK\nKDIyLCA0MC4wMCwgMTgsIDgpLCAKKDIzLCA2MC4wMCwgMTksIDkpLCAKKDI0\nLCA3MC4wMCwgMjAsIDEwKSwgCigyNSwgMTAwLjAwLCAyMCwgNCksIAooMjYs\nIDQwLjAwLCAxOSwgMSksIAooMjcsIDIwLjAwLCAxOCwgNiksIAooMjgsIDkw\nLjAwLCAxNywgOSksIAooMjksIDIzMC4wMCwgMTYsIDYpLCAKKDMwLCA0NTAu\nMDAsIDE1LCA1KTs=\n"
    decoded_data = Base64.decode64(encoded_data)
    sql = File.open('lib/decoded_data.sql', 'w'){ |f| f.write (decoded_data) }
    sql = File.read('lib/decoded_data.sql')
    execute_sql(sql)
  end

  def execute_sql(sql)
    Statement.new(sql).each do |line|
      @db.execute(line)
    end
  end
end

class Statement
  attr_reader :raw_sql
  def initialize(raw_sql)
    @raw_sql = raw_sql
  end

  def each(&block)
    lines.each(&block)
  end

  def lines
    remove_comments(raw_sql).
    scan(/[^;]*;/m)
  end

  private

  def remove_comments(sql)
    sql.
    lines.
    reject { |line| line.include?("--")}.
    join
  end
end
