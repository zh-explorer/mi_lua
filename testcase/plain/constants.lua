constants = {}

--@Desc : file_constants
constants.file_webuser = "/data/ippserver/webuser"
constants.file_bonjour_name = "/data/ippserver/name"
constants.file_bonjour_location = "/data/ippserver/location"
constants.file_bonjour_geolocation = "/data/ippserver/geolocation"
constants.file_print_user = "/data/ippserver/printuser"
constants.file_cartridge = "/var/dm/ews/cartridge"
constants.file_ink = "/var/dm/ews/ink"
constants.file_upgrade = "/data/dm/backends/status/ota"

constants.bonjour_file_name = "bonjour"
constants.name = "sys_name"
constants.password = "sys_password"


--@Desc : bonjour file and keys
constants.print_head = "print_head"
constants.update_process = "update_process"

--@Desc : request param bonjour
constants.param_bonjour_service_name = "bonjourServiceName"
constants.param_bonjour_service_note = "bonjourServiceNote"
constants.param_bonjour_geo_location_longitude = "locationLongitude"
constants.param_bonjour_geo_location_latitude = "locationLatitude"
constants.param_bonjour_geo_location_altitude = "locationAltitude"



--@Desc : cert param
constants.param_country_name = "countryName"
constants.param_provience_name = "provienceName"
constants.param_locality_name = "localityName"
constants.param_organization_name = "organizationName"
constants.param_organization_unit_name = "organizationUnitName"
constants.param_common_name = "commonName"
constants.param_email_name = "emailName"

 
--@Desc : request param
constants.param_name = "name"
constants.param_password = "password"
constants.param_repassword = "repassWord"
constants.param_oldpassword = "oldpassword"
constants.param_privilege = "privilege"
constants.param_upgradeUrl = "upgradeUrl"



return constants
