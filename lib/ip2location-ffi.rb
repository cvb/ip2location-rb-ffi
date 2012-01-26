module IP2LFFI
  extend FFI::Library
  ffi_lib 'libIP2Location.so'

  # IP2Location *IP2Location_open(char *db);
  attach_function :IP2Location_open, [ :string ], :pointer
  # uint32_t IP2Location_close(IP2Location *loc);
  attach_function :IP2Location_close, [:pointer], :uint

  # get IP2Location, return IP2LocationRecord
  attach_function :IP2Location_get_country_short,      [:pointer, :string], :pointer
  attach_function :IP2Location_get_country_long,       [:pointer, :string], :pointer
  attach_function :IP2Location_get_region,             [:pointer, :string], :pointer
  attach_function :IP2Location_get_city,               [:pointer, :string], :pointer
  attach_function :IP2Location_get_isp,                [:pointer, :string], :pointer
  attach_function :IP2Location_get_latitude,           [:pointer, :string], :pointer
  attach_function :IP2Location_get_longitude,          [:pointer, :string], :pointer
  attach_function :IP2Location_get_domain,             [:pointer, :string], :pointer
  attach_function :IP2Location_get_zipcode,            [:pointer, :string], :pointer
  attach_function :IP2Location_get_timezone,           [:pointer, :string], :pointer
  attach_function :IP2Location_get_netspeed,           [:pointer, :string], :pointer
  attach_function :IP2Location_get_iddcode,            [:pointer, :string], :pointer
  attach_function :IP2Location_get_areacode,           [:pointer, :string], :pointer
  attach_function :IP2Location_get_weatherstationcode, [:pointer, :string], :pointer
  attach_function :IP2Location_get_weatherstationname, [:pointer, :string], :pointer
  attach_function :IP2Location_get_mcc,                [:pointer, :string], :pointer
  attach_function :IP2Location_get_mnc,                [:pointer, :string], :pointer
  attach_function :IP2Location_get_mobilebrand,        [:pointer, :string], :pointer
  attach_function :IP2Location_get_all,                [:pointer, :string], :pointer

  # void IP2Location_free_record(IP2LocationRecord *record);
  attach_function :IP2Location_free_record, [:pointer], :void

  class IP2LocationRecord < FFI::ManagedStruct
    layout
    :country_short,      :string,
    :country_long,       :string,
    :region,             :string,
    :city,               :string,
    :isp,                :string,
    :latitude,           :float,
    :longitude,          :float,
    :domain,             :string,
    :zipcode,            :string,
    :timezone,           :string,
    :netspeed,           :string,
    :iddcode,            :string,
    :areacode,           :string,
    :weatherstationcode, :string,
    :weatherstationname, :string,
    :mcc,                :string,
    :mnc,                :string,
    :mobilebrand,        :string
  end

  class IP2Location < FFI::ManagedStruct
    layout
    :filehandle,     :pointer,
    :databasetype,   :char,
    :databasecolumn, :char,
    :databaseday,    :char,
    :databasemonth,  :char,
    :databaseyear,   :char,
    :databasecount,  :uint,
    :databaseaddr,   :uint,
    :ipversion,      :uint
  end

end

