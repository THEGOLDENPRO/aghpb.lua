local aghpb = {}
local json = require('cjson')
local http = require("socket.http")
local urlencode = require("urlencode")

local BASE_URL = "https://api.devgoldy.xyz/aghpb"

--- @class Book
--- @field id integer
--- @field name string
--- @field category string
--- @field date_added string
--- @field image_bytes any
local Book = {
    id = 0,
    name = "",
    category = "",
    date_added = "",
    image_bytes = nil
}

--- @param id integer
--- @param name string
--- @param category string
--- @param date_added string
--- @param image_bytes string
--- @return Book
function Book:new(id, name, category, date_added, image_bytes)
    local object = {}
    setmetatable(object, Book)

    object.id = id
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
--- @return Book
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
        headers["book-search-id"],
        headers["book-name"],
        headers["book-category"],
        headers["book-date-added"],
        body
    )
end

---
--- Returns a Book for the given id.
---
--- @param id? string
--- @return Book
function aghpb.get(id)
    local url = BASE_URL .. "/v1/get/id/" .. urlencode.encode_url(id)

    local body, code, headers, _ = http.request(url)

    if code == 404 then
        error(json.decode(body).message)
    end 

    return Book:new(
        headers["book-search-id"],
        headers["book-name"],
        headers["book-category"],
        headers["book-date-added"],
        body
    )
end

---
--- Returns a table for the given query.
---
--- @param query? string
--- @param category? string
--- @return table
function aghpb.search(query, category)
    local url = BASE_URL .. "/v1/search?query=" .. urlencode.encode_url(query)

    if category ~= nil then
        url = url .. "&category=" .. urlencode.encode_url(category)
    end

    local body, _, _, _ = http.request(url)

    return json.decode(body)
end

---
--- Returns a list of available categories. 
--- 
--- Uses the ``/v1/categories`` endpoint.
---
--- @return table
function aghpb.categories()
    local url = BASE_URL .. "/v1/categories"

    local body, _, _, _ = http.request(url)

    return json.decode(body)
end

return aghpb