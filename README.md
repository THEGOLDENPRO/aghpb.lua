<div align="center">

  # 🌕 aghpb.lua 📚
  <sub>Lua API wrapper for the anime girls holding programming books [API](https://api.devgoldy.xyz/aghpb/v1/docs)</sub>

  [![LuaRocks](https://img.shields.io/luarocks/v/THEGOLDENPRO/aghpb)](https://luarocks.org/modules/THEGOLDENPRO/aghpb)

</div>

<div align="center">

  <img src="./assets/book_1.png" width="500px">

</div>

<br>

> #### This is my first ever Lua code, so I would be happy to accept feedback and contributions.

## Install
```sh
luarocks install aghpb
```
*The LuaRocks package can be located [**here**](https://luarocks.org/modules/THEGOLDENPRO/aghpb).*

**or** (from source)
```sh
git clone https://github.com/THEGOLDENPRO/aghpb.lua/
cd aghpb.lua
sudo luarocks make 
```

## Examples
This is how you may retrieve a random anime girl holding a programming book:
```lua
aghpb = require("aghpb")

local book = aghpb.random()

print(book.name)
print(book.category)
print(book.date_added)

local file = assert(io.open("./anime_girl.png", "wb"))
file:write(book.image_bytes)
file:close()
```
You can also retrieve specific categories of anime girls holding programming books like so:
```lua
aghpb.random("lua")
```

<br>

This is how you may retrieve a list of available categories:
```lua
aghpb = require("aghpb")

local categories = aghpb.categories()

for key, value in pairs(categories) do
    print(key, value)
end
```

Made using my API at 👉 https://api.devgoldy.xyz/aghpb/v1/
