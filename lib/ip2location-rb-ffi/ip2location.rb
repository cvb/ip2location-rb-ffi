class IP2L

  NOT_SUPPORTED = "This parameter is unavailable for selected data file. Please upgrade the data file."

  %w(country_short country_long region city isp
     latitude longitude domain zipcode timezone
     netspeed iddcode areacode weatherstationcode
     weatherstationname mcc mnc mobilebrand).each do |m|

    define_method("find_#{m}_for") do |ip|
      raise IP2LErrors::OutsideWithDb, "use this function inside with_db block" if @db.nil?
      r = IP2LFFI.send("IP2Location_get_#{m}", @db, ip)
      return nil if r == FFI::Pointer::NULL
      ruby_result = IP2LFFI::IP2LocationRecord.new(r)[m.to_sym]
      return nil if ruby_result == NOT_SUPPORTED || ruby_result == '-'
      return ruby_result
    end
  end

  def initialize(dbfile=nil)
    @dbfile = dbfile
  end

  def set_db(dbfile)
    @dbfile = dbfile
  end

  def with_db(dbfile = nil, &code)
    @db = open_database((dbfile or @dbfile))
    begin
      yield code
    ensure
      close_database @db
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
