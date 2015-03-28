--- the folding functions.
-- See @{README.md} for details on usage.
-- @author Alejandro Baez <alejan.baez@gmail.com>
-- @copyright 2015
-- @license MIT (see LICENSE)
-- @module folding

--- collapse folding for a line or current buffer line.
-- @param line the line to fold.
local function collapse_fold(line)
  local line = line or buffer:line_from_position(buffer.current_pos)
    if buffer.fold_expanded[line] and buffer.line_visible[line] then
      buffer:toggle_fold(line)      -- colapse fold
      if not buffer.line_visible[line] then
        buffer:goto_line(buffer.fold_parent[line]) --set caret on parent fold line
      end
    end
end

---  expand folding for a line or current buffer line.
-- @param line see @{collapse_fold|line}.
local function expand_fold(line)
  local line = line or buffer:line_from_position(buffer.current_pos)
  if not buffer.fold_expanded[line] and buffer.line_visible[line] then
    buffer:toggle_fold(line)
    buffer:goto_line(line+1) --set caret on the first child line of the fold
  end
end

--- collapse all folds.
local function collapse_folds()
  for i = 0, buffer.line_count - 1 do
    collapse_fold(i)
  end
end

--- expands all folds.
local function expand_folds()
  for i = 0, buffer.line_count - 1 do
    expand_fold(i)
  end
end

return {
  expand_fold    = expand_fold,
  collapse_fold  = collapse_fold,
  expand_folds   = expand_folds,
  collapse_folds = collapse_folds
}
