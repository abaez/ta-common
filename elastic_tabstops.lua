-- port of Elastic Tabstops scintilla code to Textadept
-- Joshua KrÃ¤mer, 2015-03-21

local M = {}


-- line start
local function line_start(pos)
	local line = buffer:line_from_position(pos)
	return buffer:position_from_line(line)
end

-- line end
local function line_end(pos)
	local line = buffer:line_from_position(pos)
	return buffer.line_end_position[line]
end

-- is position = line end?
local function is_line_end(pos)
	local line = buffer:line_from_position(pos)
	local end_pos = buffer.line_end_position[line]
	return (pos == end_pos)
end

-- table with grid, format: grid[line number][tabstop number]
-- keys: text_width_pix, block_first_line, ends_in_tab
-- block_first_line = number of first line in block, acts as index for the widest_widths table
local grid = {}

-- table with number of tabs per line
local num_tabs = {}

-- table with widest tabstop width of a block, format: widest_widths[first line number of block][tabstop number]
local widest_widths = {}

-- directions
local dir = {backwards = 0, forwards = 1}

-- start = position (starting from 0) of first character, stop = position after last character
local function get_text_width(start, stop)
	local text = buffer:text_range(start, stop)
	local style = buffer.style_at[start]
	return buffer:text_width(style, text)
end

local function calc_tab_width(text_width_in_tab)
	if (text_width_in_tab < tab_width_minimum) then
		text_width_in_tab = tab_width_minimum
	end
	return text_width_in_tab + tab_width_padding
end

local function change_line(location_param, which_dir)
	-- location must be modified globally

	-- Returns the line number of the line that contains position pos. Returns 0 if pos is less than 0 or buffer.line_count if pos is greater than buffer.length
	local line = buffer:line_from_position(location_param)
	if (which_dir == dir.forwards) then
		--This returns the document position that corresponds with the start of the line. If line is negative, the position of the line holding the start of the selection is returned. If line is greater than the lines in the document, the return value is -1. If line is equal to the number of lines in the document (i.e. 1 line past the last line), the return value is the end of the document.
		location = buffer:position_from_line(line + 1)
	else
		if (line <= 0) then
			return false
		end
		location = buffer:position_from_line(line - 1)
	end
	return (location >= 0)
end

local function get_block_boundary(location_param, which_dir)
	-- location must be modified globally
	local current_pos
	local max_tabs = 0
	local orig_line = true

	location = line_start(location_param)
	repeat
		local tabs_on_line = 0

		current_pos = location
		local current_char = buffer.char_at[current_pos]
		local current_char_ends_line = is_line_end(current_pos)

		while (current_char ~= 0 and current_char_ends_line == false) do -- 0 = \0
			if (current_char == 9) then -- 9 = \t
				tabs_on_line = tabs_on_line + 1
				if (tabs_on_line > max_tabs) then
					max_tabs = tabs_on_line
				end
			end
			current_pos = buffer:position_after(current_pos)
			current_char = buffer.char_at[current_pos]
			current_char_ends_line = is_line_end(current_pos)
		end
		if (tabs_on_line == 0 and orig_line == false) then
			return max_tabs
		end
		orig_line = false
	until (change_line(location, which_dir) == false)
	return max_tabs
end

local function get_nof_tabs_between(start, stop)
	local current_pos
	local max_tabs = 0

	location = line_start(start)
	repeat
		local tabs_on_line = 0

		current_pos = location
		local current_char = buffer.char_at[current_pos]
		local current_char_ends_line = is_line_end(current_pos)

		while (current_char ~= 0 and current_char_ends_line == false) do -- 0 = \0
			if (current_char == 9) then -- 9 = \t
				tabs_on_line = tabs_on_line + 1
				if (tabs_on_line > max_tabs) then
					max_tabs = tabs_on_line
				end
			end
			current_pos = buffer:position_after(current_pos)
			current_char = buffer.char_at[current_pos]
			current_char_ends_line = is_line_end(current_pos)
		end
	until (change_line(current_pos, dir.forwards) == false or (current_pos >= stop))
	return max_tabs
end


local function stretch_tabstops(block_start_linenum, block_nof_lines, max_tabs)
	-- get width of text in cells
	local l = 0
	while (l < block_nof_lines) do -- for each line
		local text_width_in_tab = 0
		local current_line_num = block_start_linenum + l
		local current_tab_num = 0
		local cell_empty = true

		local current_pos = buffer:position_from_line(current_line_num)
		local cell_start = current_pos
		local current_char = buffer.char_at[current_pos]
		current_char_ends_line = is_line_end(current_pos)
		-- maybe change this to search forwards for tabs/newlines

		grid[l] = {}
		local ti = 0
		-- initialize 1 additional tabstop for: if (current_char_ends_line) then grid[l][current_tab_num].ends_in_tab = false
		while (ti <= max_tabs) do
			grid[l][ti] = {}
			ti = ti + 1
		end
		num_tabs[l] = 0

		while (current_char ~= 0) do -- 0 = \0
			if (current_char_ends_line) then
				grid[l][current_tab_num].ends_in_tab = false
				text_width_in_tab = 0
				break
			elseif (current_char == 9) then -- 9 = \t
				if (cell_empty == false) then
					text_width_in_tab = get_text_width(cell_start, current_pos)
				end
				grid[l][current_tab_num].ends_in_tab = true
				grid[l][current_tab_num].text_width_pix = calc_tab_width(text_width_in_tab)
				current_tab_num = current_tab_num + 1
				num_tabs[l] = num_tabs[l] + 1
				text_width_in_tab = 0
				cell_empty = true
			else
				if (cell_empty) then
					cell_start = current_pos
					cell_empty = false
				end
			end
			current_pos = buffer:position_after(current_pos)
			current_char = buffer.char_at[current_pos]
			current_char_ends_line = is_line_end(current_pos)
		end
		l = l + 1
	end

	-- find columns blocks and stretch to fit the widest cell
	local t = 0
	while (t < max_tabs) do -- for each column
		local starting_new_block = true
		local first_line_in_block = 0
		local max_width = 0

		l = 0
		while (l < block_nof_lines) do -- for each line
			if (starting_new_block) then
				starting_new_block = false
				first_line_in_block = l
				max_width = 0

				if (widest_widths[first_line_in_block] == nil) then
					widest_widths[first_line_in_block] = {}
				end
			end
			if (grid[l][t].ends_in_tab) then
				grid[l][t].block_first_line = first_line_in_block
				if (grid[l][t].text_width_pix > max_width) then
					max_width = grid[l][t].text_width_pix
					widest_widths[first_line_in_block][t] = max_width
				end
			else -- end column block
				starting_new_block = true
			end
			l = l + 1
		end
		t = t + 1
	end

	-- set tabstops
	l = 0
	while (l < block_nof_lines) do -- for each line
		current_line_num = block_start_linenum + l
		local acc_tabstop = 0

		buffer:clear_tab_stops(current_line_num)

		t = 0
		while (t < num_tabs[l]) do
			if (grid[l][t].block_first_line ~= nil) then
				acc_tabstop = acc_tabstop + widest_widths[grid[l][t].block_first_line][t]
				buffer:add_tab_stop(current_line_num, acc_tabstop)
			else
				break
			end
			t = t + 1
		end
		l = l + 1
	end
end

function reset(start, stop)
	-- default tabstops width and padding
	tab_width_minimum = buffer:text_width(32, 'nn')
	tab_width_padding = buffer:text_width(32, 'nn')

	local max_tabs_between = get_nof_tabs_between(start, stop)
	local max_tabs_backwards = get_block_boundary(start, dir.backwards)
	local max_tabs_forwards = get_block_boundary(stop, dir.forwards)
	local max_tabs = math.max(max_tabs_between, max_tabs_backwards, max_tabs_forwards)

	-- Todo: use boundaries from get_block_boundary function
	local block_start_linenum = buffer:line_from_position(start)
	local block_end_linenum = buffer:line_from_position(stop)
	local block_nof_lines = (block_end_linenum - block_start_linenum) + 1

	stretch_tabstops(block_start_linenum, block_nof_lines, max_tabs)
end

function M.reset_visible(updated)
	if ((updated ~= nil) and (updated ~= 2) and (buffer._textredux == nil)) then
		local first = buffer:position_from_line(buffer.first_visible_line)
		local last = buffer:position_from_line(math.min(buffer.line_count-1, buffer.first_visible_line+buffer.lines_on_screen))
		reset(first, last)
	end
end

return M
