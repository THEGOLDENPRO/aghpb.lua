aghpb = require("aghpb")

local book = aghpb.random()

print(book.name)
print(book.category)
print(book.date_added)

local file = assert(io.open("./anime_girl.png", "wb"))
file:write(book.image_bytes)
file:close()