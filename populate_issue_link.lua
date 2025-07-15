-- populate_issue_link.lua
-- A Quarto Lua filter that populates the `other-links` href
-- with the current page title and URL

-- helper to URL-encode strings
local function urlencode(str)
  if (str) then
    str = str:gsub("\n", "\r\n")
    str = str:gsub("([^%w %-%_%.%~])", function(c)
      return string.format("%%%02X", string.byte(c))
    end)
    str = str:gsub(" ", "%%20")
  end
  return str
end

function Meta(meta)
  -- only run if we have other-links defined
  if meta.book and meta.book.other_links then
    -- find the Report an issue entry
    for _, link in ipairs(meta.book.other_links) do
      if link.text == "Report an issue" then
        -- build the absolute URL to this page
        local base = meta.website and meta.website["site-url"] or ""
        local path = (meta.book and meta.book.html and meta.book.html["page-url-path"]) or ""
        local full_url = base .. path
        -- set the href
        link.href =
          "https://github.com/3mmaRand/comp4biosci/issues/new"
          .. "?title=" .. urlencode(meta.title or "")
          .. "&body="  .. urlencode(full_url)
      end
    end
  end
  return meta
end
