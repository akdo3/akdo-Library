# akdo UI Library for Roblox

**akdo UI Library** is a versatile and easy-to-use UI framework that empowers Roblox developers to create advanced and dynamic user interfaces. With features like tabs, sliders, dropdowns, and toggles, it simplifies UI management and enhances the user experience.

## Load the Library

To load the library into your game, use the following code:

```lua
local akdo = loadstring(game:HttpGet("https://raw.githubusercontent.com/akdo3/akdo-Library/refs/heads/main/Main.lua"))()
```

### Setting Up the Frame
Start by creating a frame for your UI.

```lua
local Frame = akdo:createFrame("akdo")
```

`akdo` = Title of the frame.

### Adding Tab
Organize your controls by adding multiple tabs to the frame.

```lua
local Main = Frame:addTab("Main")
```

`Frame` = Parent of the tab.

`Main` = Name of the tab.

## Adding Controls
Add interactive controls like buttons, sliders, dropdowns, and toggles to the tabs.

### Button
```lua
local Button = Main:addButton("Speed", "Change your speed", function()
    print("Clicked")
end)
```

`Main` = Tab where the button will be.

`Speed` = Name of the button.

`Change your speed` = Info about the button.

### Slider
Use sliders to modify player attributes such as speed.

```lua
local Slider = Main:addSlider("Speed", "Adjust the player's speed", 16, 0, 500, function(value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)
```

`Main` = Tab where the slider will be.

`Speed` = Name of the slider.

`Adjust the player's speed` = Info.

`16` = Start Number.

`0` = Min Slider Value.

`500` = Max Slider Value.

### Dropdown
Create dropdowns to allow users to choose from multiple options.

```lua
local options = {
    "Option 1",
    "Option 2",
    "Option 3",
}
local Dropdown = Main:addDropdown("Choose option", "Choose the option you want", options, function(option)
    print("Selected option:", option)
end, 2)
```

`Main` = Tab where the dropdown will be.

`Choose option` = Name of the dropdown.

`Choose the option you want` = Info.

`options` = The list of options available in the dropdown.

`2` = Items Per Row

### Toggle
Add toggles to enable or disable features.

```lua
local Main:addToggle("Fly", "You Will Fly", function(value)
    if value then
        print("On")
    else
        print("Off")
    end
end)
```

`Main` = Tab where the toggle will be.

`Fly` = Name of the toggle.

`You Will Fly` = Info about the toggle.

## Function
#### TextBox
```lua
local TextBox = akdo:addTextBox(name, Info, placeholderText, callback, parent, stat, onlyNumbers, onlyLetters)
```

#### DropdownAndToggle
```lua
local DropdownAndToggle = akdo:addDT(name, items, callback, itemsPerRow)
```

#### FrameStyles
```lua
Frame:FrameStyle(1)
```
```lua
Frame:FrameStyle(2)
```
```lua
Frame:FrameStyle(3)
```

## Example
```lua
local Frame = akdo:createFrame("akdo")
local Main = Frame:addTab("Main")

local Main:addSection("Section")
local Main:addLabel("Label")

local button = Main:addButton("Button", "Info, tutorial", function()
    print("Button Clicked")
end)

local SliderAndTextBox = Main:addSlider("Speed", "", 16, 0, 500, function(value,value2) 
    Humanoid.WalkSpeed = value2
end, false, false, true)

local table = {
    "egg 1", "egg 2", 
}
Main:addDT(Player, "Auto Hatch", table, 1, function(val1, val2)
    print(val2)
    if val1 then
        if val2 == "egg 1" then
            print("Hatch egg 1")
        elseif val2 == "egg 2" then
            print("Hatch egg 2")
        end
    else
        print("Off")
    end
end)

akdo:addSection(Player, "Toggle Section")

Main:addToggle(Player, "Noclip", "Make you pass through anything", function(val) 
    if val then
        print("On")
    else
        print("Off")
    end
end)

local row = akdo:addRow(Player, 2)

Main:addToggle(row, "Fly", "", function(val) 
    if val then
        print("On")
    else
        print("Off")
    end
end)

Main:addButton("Button", "", function(val) 
    print("Clicked")
end)

Main:addDropdown(Main, "Auto Hatch", "", {"egg 1", "egg 2","egg 3"}, 3, function(toggled, egg)
    if toggled then
        print("Selected egg:", egg)
    else
        print("Off")
    end
end)
```

## Fast Code
```lua
local akdo = loadstring(game:HttpGet("https://raw.githubusercontent.com/akdo3/akdo-Library/refs/heads/main/Main.lua"))()
local Frame = akdo:createFrame("akdo")
local Main = Frame:addTab("Main")

local Section = Main:addSection("Section")

local Button = Main:addButton("Button", "Info, tutorial", function()

end)

local Slider = Main:addSlider("Speed", "", 16, 0, 500, function(value,value2)

end)

local table = {
	"",
	"", 
}

local DropdownAndToggle = Main:addDT("", table, function(val1, val2)
	if val1 then
		if val2 == "" then

		elseif val2 == "" then

		end
	else

	end
end)

local Toggle = Main:addToggle("", "", function(val) 
	if val then
		print("On")
	else
		print("Off")
	end
end)

local row = Main:addRow(2)

local Toggle = Main:addToggle("Fly", "", function(val) 
	if val then
		print("On")
	else
		print("Off")
	end
end, row)

local Button = Main:addButton("Button", "", function(val) 
	print("Clicked")
end, row)

local Dropdown = Main:addDropdown("Auto Hatch", "", {"egg 1", "egg 2","egg 3"}, function(toggled, egg)
	if toggled then
		print("Selected egg:", egg)
	else
		print("Off")
	end
end, 3)
```
## Suggestions
We encourage suggestions to improve akdo Library! If you have any suggestions, error reports, or feature , feel free to send them to this [Discord](https://discord.gg/xgvddUgwJT) Server.

Key Improvements:
Clearer Structure: Sections are organized for better readability.

Descriptive Functionality: Shortened and made descriptions more concise.

Code Block Organization: All code samples are neatly organized and explained.

Encouraged Contribution: Added a section to invite contributions in a friendly manner.
This version is more concise and user-friendly while keeping the information easy to navigate.

This version provides a well-structured `README.md` with clear sections, code samples, and explanations for the various features and functions of your `akdo` UI Library. Let me know if you'd like further modifications!

