aghpb = require("src.aghpb.init")

local book = aghpb.get("1")

print(book.name)
print(book.category)
print(book.date_added)