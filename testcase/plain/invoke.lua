invoke = {}

--query ink quantity 
function invoke.invokeUpgradeTime()
    local order = 'stat /etc/db_fw_version |grep Change||awk \'{print $2 " " $3}\''
    return invokeShell(order)
end

--query system status
function invoke.invokeQuerySysStatus()
--    local order = 'ps x |grep ippserver|grep -v grep';
    local order = '/etc/init.d/ippserver status'
    return invokeShell(order)
end

--query firmware version
function invoke.invokeQueryFirmwareVer()
    -- body
end

--start equip
function invoke.invokeDoStartEquip()
    local enable = '/etc/init.d/ippserver enable'
    local start = '/etc/init.d/ippserver start'
    invokeShellWithoutReturn(enable)
    invokeShellWithoutReturn(start)

    local usb_airprint_enable = '/etc/init.d/usb_ipp_bridge enable'
    local usb_airprint_start = '/etc/init.d/usb_ipp_bridge start'
    invokeShellWithoutReturn(usb_airprint_enable)
    invokeShellWithoutReturn(usb_airprint_start)

    local avahi_enable = '/etc/init.d/avahi-daemon enable'
    local avahi_start = '/etc/init.d/avahi-daemon start'
    invokeShellWithoutReturn(avahi_enable)
    invokeShellWithoutReturn(avahi_start)
end

--stop equip
function invoke.invokeDoStopEquip()
    local avahi_disable = '/etc/init.d/avahi-daemon disable'
    local avahi_stop = '/etc/init.d/avahi-daemon stop'
    invokeShellWithoutReturn(avahi_disable)
    invokeShellWithoutReturn(avahi_stop)

    local usb_airprint_disable = '/etc/init.d/usb_ipp_bridge disable'
    local usb_airprint_stop = '/etc/init.d/usb_ipp_bridge stop'
    invokeShellWithoutReturn(usb_airprint_disable)
    invokeShellWithoutReturn(usb_airprint_stop)

    local disable = '/etc/init.d/ippserver disable'
    local stop = '/etc/init.d/ippserver stop'
    invokeShellWithoutReturn(disable)
    invokeShellWithoutReturn(stop)
end

--restart 
function invoke.invokeDoRestartEquip()
    local restart = '/etc/init.d/ippserver restart'
    invokeShellWithoutReturn(restart)

    local avahi_restart = '/etc/init.d/avahi-daemon restart'
    invokeShellWithoutReturn(avahi_restart)
end

--invoke system upgrade
function invoke.invokeDoSysUpgrade(url)
    local order = "/sbin/ews_ota.sh -u '"..url.."'"
    return invokeShell(order)
end

function invoke.invokeQueryCurrentVersion()
	local order = '/sbin/ews_ota.sh -l'
    return invokeShell(order)
end

function invoke.invokeQueryServerVersion()
	local order = '/sbin/ews_ota.sh -s'
	return invokeShell(order)
end

function invokeShell(order)
	local t = io.popen(order)
	local a = t:read("*all")
	return a
end

function invokeShellWithoutReturn(order)
	local t = io.popen(order)
end

return invoke
