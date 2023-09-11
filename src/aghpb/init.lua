local aghpb = {}
local json = require('cjson')
local http = require("socket.http")
local urlencode = require("urlencode")

local BASE_URL = "https://api.devgoldy.xyz/aghpb"

local Book = { name = nil, category = nil, date_added = nil, image_bytes = nil }
Book.__index = Book

--- @param name string
--- @param category string
--- @param date_added string
--- @param image_bytes string
function Book:new(name, category, date_added, image_bytes)
    local object = {}
    setmetatable(object, Book)

    object.name = name
    object.category = category
    object.date_added = date_added
    object.image_bytes = image_bytes

    return object
end


---
--- Returns a random anime girl holding a programming book. 
---
--- Uses the ``/v1/random`` endpoint.
---
--- @param category? string
--- @return Book # Book data.
function aghpb.random(category)
    category = category or nil

    local url = BASE_URL .. "/v1/random"

    if category ~= nil then
        url = url .. "?category=" .. urlencode.encode_url(category)
    end

    local body, code, headers, _ = http.request(url)

    if code == 404 then
        error(json.decode(body).message)
    end

    return Book:new(
        headers["book-name"],
        headers["book-category"],
        headers["book-date-added"],
        body
    )

end

---
--- Returns a list of available categories. 
--- 
--- Uses the ``/v1/categories`` endpoint.
---
function aghpb.categories()
    local url = BASE_URL .. "/v1/categories"

    local body, _, _, _ = http.request(url)

    return json.decode(body)

end

return aghpb
