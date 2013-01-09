local ab = require 'addressbook'
local function main()
	ab.add("rabbit","roger","Warner","012345")
	ab.remove("rabbit")
end
main()
