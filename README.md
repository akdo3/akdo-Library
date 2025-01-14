# akdo UI Library

**akdo UI Library** is a customizable and efficient UI framework designed for Roblox developers. It simplifies the creation of user interfaces by providing a set of tools and functions to manage rows, toggles, and more within a grid layout.

## Features

- **Dynamic Row Management**: Easily add rows with customizable frames per row and line limits.
- **Toggle Elements**: Add toggle buttons with customizable states and callback functions.
- **Flexible Grid Layout**: Automatically adjusts layout based on the number of elements and available space.

lua
Copy code
local parent = -- (Reference to your parent container)
local framePerRow = 3 -- Number of frames per row
local lines = 2 -- Number of lines,If you wont you can remove this line 

local row = akdo:addRow(parent, 4, 2)
framePerRow: Number of frames per row (optional).
lines: Number of lines for the grid (optional).
Adding a Toggle
To add a toggle button:

lua
Copy code
local parent = -- (Reference to your parent container)
local name = "Toggle Example"
local info = "This is an example toggle."
local callback = function(toggled)
    print("Toggle state: " .. tostring(toggled))
end

local toggle = akdo:addToggle(parent, name, info, callback)
parent: Parent container for the toggle.
name: Name displayed on the toggle.
info: Additional info displayed when toggled (optional).
callback: Function called when the toggle state changes.

License
This project is licensed under the MIT License. See the LICENSE file for more details.

Contact
If you have any suggiton, please go to discord server [your email or support link].

Happy developing with akdo UI Library!

markdown
Copy code
