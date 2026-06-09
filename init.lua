
skeleton = {
	modname = core.get_current_modname(),
	log = function() end
}
skeleton.modpath = core.get_modpath(skeleton.modname)

if core.global_exists("register_mod_logger") then
	register_mod_logger(skeleton)
end


-- support mob libraries in order of preference
local mob_libs = {
	"mobs",
	"cmer",
	"creatures",
}

for _, ml in ipairs(mob_libs) do
	if core.get_modpath(ml) then
		skeleton.lib = ml
		break
	end
end

-- check for compatible library
if not skeleton.lib then
	skeleton.log("error", "Could not load. A compatible mob library was not found. Please install one of the following: "
		.. table.concat(mob_libs, ", "))
	skeleton = nil
	do return end
end

if skeleton.lib == "creatures" then
	skeleton.lib = "cmer"
end


local scripts = {
	"settings",
	"entity",
}

for _, script in ipairs(scripts) do
	dofile(skeleton.modpath .. "/" .. script .. ".lua")
end

skeleton.log("debug", "skeleton mob loaded")
