aghpb = require("src.aghpb.init")

local categories = aghpb.categories()

for key, value in pairs(categories) do
    print(key, value)
end