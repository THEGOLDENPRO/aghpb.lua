aghpb = require("aghpb")

local categories = aghpb.search("lua")

for key, value in pairs(categories) do
    print(key, value["name"])
end