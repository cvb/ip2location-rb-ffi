class IP2L

  %w(country_short country_long region city isp
     latitude longitude domain zipcode timezone
     netspeed iddcode areacode weatherstationcode
     weatherstationname mcc mnc mobilebrand).each do |m|

    define_method("find_by_#{m}") do |ip|
      raise IP2LErrors::OutsideWithDb, "use this function inside with_db block" unless @db
      r = IP2LFFI.send("IP2Location_get_#{m}", @db, ip)
      return nil if r == FFI::Pointer::NULL
      ruby_result = r[m.to_sym]
      IP2LFFI.IP2Location_free_record(r)
      return ruby_result
    end
  end

  def with_db(dbfile, &code)
    @db = open_database(db_file)
    begin
      yield code
    ensure
      close_database db
    end
  end

  private

  def open_database(database_fname)
    db = IP2LFFI.IP2Location_open(database_fname)
    raise IP2LErrors::DbOpenError if db == FFI::Pointer::NULL
    return db
  end

  def close_database(database)
    IP2LFFI.IP2Location_close(database)
  end

end

module IP2LErrors
  class DbOpenError   < StandardError; end
  class OutsideWithDb < StandardError; end
end
