aghpb = require("src.aghpb.init")

local books = aghpb.search("lua")

local book = aghpb.get(books[1]["search_id"])

print(book.id)
print(book.name)