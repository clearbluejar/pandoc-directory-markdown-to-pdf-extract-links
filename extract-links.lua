
local stringify = (require 'pandoc.utils').stringify

-- creates a handout from an article, using its headings,
-- blockquotes, numbered examples, figures, and any
-- Divs with class "handout"
-- Character escaping
local function escape(s, in_attribute)
return s:gsub('[<>&"\']',
    function(x)
    if x == '<' then
        return '&lt;'
    elseif x == '>' then
        return '&gt;'
    elseif x == '&' then
        return '&amp;'
    elseif in_attribute and x == '"' then
        return '&quot;'
    elseif in_attribute and x == "'" then
        return '&#39;'
    else
        return x
    end
    end)
end
  
-- Helper function to convert an attributes table into
-- a string that can be put into HTML tags.
local function attributes(attr)
local attr_table = {}
for x,y in pairs(attr) do
    if y and y ~= '' then
    table.insert(attr_table, ' ' .. x .. '="' .. escape(y,true) .. '"')
    end
end
return table.concat(attr_table)
end

-- function Link(s, tgt, tit, attr)
--     print(s)
--     if s then
--         print('<a href="' .. escape(tgt,true) .. '" title="' ..
--                 escape(tit,true) .. '"' .. attributes(attr) .. '>' .. 1 .. '</a>')
--         return '<a href="' .. escape(tgt,true) .. '" title="' ..
--         escape(tit,true) .. '"' .. attributes(attr) .. '>' .. s .. '</a>'
--     else 
--         return ''
--     end
--   end

local links = pandoc.List{}
table.insert(links,PANDOC_STATE.input_files)
function Link(s, tgt, tit, attr)
    -- print(stringify(s))
    -- print(s)
    -- print(s.target)
    -- print(s.title)

    -- print(stringify(s.attr))
    -- print(stringify(s.content))
    -- print(stringify(s.target))
    -- print(stringify(s.title))
    -- --print(stringify(s.clone))
    -- --print(stringify(s.walk))

    -- print(s.attr)
    -- print(s.content)
    -- print(s.tag)
    -- print(s.target)
    -- print(s.title)
    -- print(s.clone)
    -- print(s.walk)
    ref = ' - [' .. stringify(s.content) .. '] - ' .. stringify(s.target)

    if string.find(ref, "http") then
        -- external link
        table.insert(links, ref)
        print(ref)
      else
        print( 'Skipping: ' .. ref)
      end
    
    

    -- for i,v in pairs(s) do print(i) end
  end


function Pandoc(doc)
-- --     local text = require 'text'
-- -- local links = pandoc.List{}
-- -- return {
-- --   {Link = function (l) links:insert(l) end},
-- --   {Str = function (s) return pandoc.Str(text.upper(s.text)) end},
-- --   {Link = function (_) return links:remove(1) end},
-- -- }
--     local hblocks = {}
    
--     for i,el in pairs(doc) do
--         print(el.t)
--         if (el.t == "Link") then
--            table.insert(hblocks, el)
--         end
--     end
    return pandoc.Pandoc(links, doc.meta)
end