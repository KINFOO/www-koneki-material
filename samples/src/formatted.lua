-- Formatting indexes
local content = io
  .open('/dev/sample','r')
  :read('*a')

-- Function call on several lines
log(
  '/tmp/verylongfilename',
  'Warning'
)

-- Formating endless conditions
local function list(self)
  repeat
    local item = self.primary(lx)
    table.insert (x, item) -- read one element
  until
    -- Don't go on after an error
    type(item)=='table' and item.tag=='Error' or
    -- There's a separator list specified, and next token isn't in it.
    -- Otherwise, consume it with [lx:next()]
    self.separators and not(peek_is_in (self.separators) and lx:next()) or
    -- Terminator token ahead
    peek_is_in (self.terminators) or
    -- Last reason: end of file reached
    lx:peek().tag=="Eof"
end