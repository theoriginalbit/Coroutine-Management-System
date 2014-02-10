--[[
  Coroutine-Management-System (CMS) v2.0 [Updated: 10 Feb 2014]
  
  Copyright © 2014 Joshua Asbury a.k.a. theoriginalbit [theoriginalbit@gmail.com]

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, and/or sublicense copies
  of the Software, and to permit persons to whom the Software is furnished to
  do so, subject to the following conditions:

  - The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software;
  - Visible credit is given to the original author;
  - The software is distributed in a non-profit way;

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
--]]

local function safePairs(t)
  local keys = {}
  for k,v in pairs(t) do
    keys[#keys+1] = k
  end
  local i = 0
  return function()
    i = i + 1
    return keys[i], t[keys[i]]
  end
end

local nextId
do
  local _NEXTID = 0
  nextId = function()
    local temp = _NEXTID
    _NEXTID = _NEXTID + 1
    return temp
  end
end

local _CURRENTROUTINEID = nil

local function resolveIdentifier(ident)
  if type(ident) == "number" then
    if _ROUTINES[ident] then
      return ident
    end
  elseif type(ident) == "string" then
    local id = _NAMETOID[ident]
    if id and _ROUTINES[id] then
      return id
    end
  elseif type(ident) == "nil" then
    return _CURRENTROUTINEID
  end
  error("Invalid identifier", 3)
end


local _ROUTINES = {}
local _NAMETOID = {}

local function resume(...)
  -- Code here...
end

function routineStatus(id)
  -- Code here...
end

function createRoutine(name,func)
  -- Code here...
end

function stopRoutine(id)
  -- Code here...
end

function killRoutine(id)
  -- Code here...
end

function pauseRoutine(id)
  -- Code here...
end

function resumeRoutine(id)
  -- Code here...
end

function run()
  -- Code here...
end