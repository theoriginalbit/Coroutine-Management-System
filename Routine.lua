--[[
  Coroutine-Management-System (CMS) v2.0 [Updated: 09 Feb 2014]
  
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

local function safePairs( _t )
  local tKeys = {}
  for k,v in pairs( _t ) do
    table.insert(tKeys, k)
  end
  local nAt = 0
  return function()
    nAt = nAt + 1
    return tKeys[nAt], _t[tKeys[nAt]]
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

local function parseIdentifier( _ident )
  if type(_ident) == "number" then
    if _ROUTINES[_ident] then
      return _ident
    end
  elseif type(_ident) == "string" then
    local id = _NAMETOID[_ident]
    if _ROUTINES[id] then
      return id
    end
  end
  error("Invalid identifier", 3)
end

local _ROUTINES = {}
local _NAMETOID = {}
local _CURRENTROUTINE = nil