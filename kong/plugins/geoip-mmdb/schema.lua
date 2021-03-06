local iputils = require "resty.iputils"

local function validate_ips(v, t, column)
  if v and type(v) == "table" then
    for _, ip in ipairs(v) do
      local _, err = iputils.parse_cidr(ip)
      if type(err) == "string" then -- It's an error only if the second variable is a string
        return false, "cannot parse '" .. ip .. "': " .. err
      end
    end
  end
  return true
end

return {
  fields = {
    whitelist_ips = {type = "array", func = validate_ips},
    blacklist_iso = {type = "array"},
    blacklist_geoname = {type = "array"},
    error_status = {type = "number", default=403},
    error_message = {type = "string", default="This site is unavailable in your region"}
  }
}
