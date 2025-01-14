# akdo UI Library for Roblox

**akdo UI Library** is a versatile and easy-to-use UI framework that empowers Roblox developers to create advanced and dynamic user interfaces. With features like tabs, sliders, dropdowns, and toggles, it simplifies UI management and enhances the user experience.

## Features

- **Dynamic Tab Management**: Effortlessly create and organize multiple tabs for a well-structured interface.
- **Interactive Sliders and Toggles**: Modify game elements like speed, jump power, and FOV in real-time with responsive controls.
- **Customizable Dropdown Menus**: Easily implement interactive dropdowns with user-defined options.

## Load the library

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/akdo3/akdo-Library/refs/heads/main/Main.lua"))()
```

### Setting Up the Frame

Start by creating a `frame`.

```lua
local Frame = akdo.createFrame("akdo")
```
akdo = **Title**

### Adding Tabs
Organize your controls by adding multiple tabs to the frame.

```lua
local Main = akdo:addTab(Frame, "Main")
```
Frame = Parent of the tab.
Main = Name of the tab.

## Adding Controls
Add interactive controls like buttons, sliders, dropdowns, and toggles to the tabs.

### Buttons
```lua
akdo:addButton(Main, "Speed", "Change yor speed", function()
	print("Clicked")
end)
```
Main = Which Tab the Button will be.
Speed = The **name** of the Button.
Change yor speed = This is the **Info**.

### Sliders
Use sliders to modify player attributes such as speed.

```lua
akdo:addSlider(Main, "Speed", "Adjust the player's speed", 0, 500, function(value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)
```
Main = Which Tab the slider will be.
Speed = Name of the Slider must be in "".
Adjust the player's speed = This is the Info, Must be in "", If you dont need it make only this "".
0 = Min Slider Value.
500 = Max Slider Value.

### Dropdowns
Create dropdowns to allow users to Chosse from multiple options.

```lua
local options = {
    "Option 1",
    "Option 2",
    "Option 3",
}
akdo:addDropdown(Main, "Chosse option", "Chosse the option you wont", options, 2, function(option)
    print("Selected option:", option)
end)
```
Main = Which Tab the slider will be.
Select option = Name of the Dropdown, Must be in "".
Select the option you want = This is the Info, Must be in "", If you dont need it make only this "".
0 = Min Slider Value.
500 = Max Slider Value.

### Toggle
Add toggle to enable or disable features.

```lua
akdo:addToggle(Main, "Fly", "You Will Fly", function(value)
    if value then
        print("On")
    else
        print("Off")
    end
end)
```
Main = Which Tab the slider will be.
Fly = Name of the Toggle, Must be in "".
You Will Fly = This is the Info, Must be in "", If you dont need it make only this "".

## Examples

```lua
local Frame = akdo.createFrame( "akdo")
local Main = akdo:addTab(Frame, "Main")

akdo:addSection(Player, "Section")
akdo:addLabel(Player, "Label")

local button = akdo:addButton(Main, "Button", "Info , tut", function()
	print("Button Clicked")
end)

akdo:addSliderAndTextBox(Player, "Speed", "", "", 0, 500, function(value,value2) 
	Humanoid.WalkSpeed = value2
end, false, false, true)

local table = {
	"egg 1", "egg 2", 
}
akdo:addDropdownAndToggle(Player, "Auto Hatch", table, 1, function(val1,val2)
	print(val2)
	if val1 then
		if val2 == "egg 1" then
			print("hatch egg 1")
		elseif val2 == "egg 2" then
			print("hatch egg 2")
		end
	else
		print("off")
	end
end)

akdo:addSection(Player, "Toggle Section")

akdo:addToggle(Player, "Noclip", "Make you Pass through anything", function(val) 
    if val then
        print("On")
    else
        print("Off")
    end
end)

local row = akdo:addRow(Player, 2)

akdo:addToggle(row, "Fly", "", function(val) 
    if value then
        print("On")
    else
        print("Off")
    end
end)

akdo:addButton(row, "Button", "", function(val) 
	print("Clicked")
end)

akdo:addButton(row, "Button", "one...?", function()
	print("Clicked")
end)

akdo:addDropdown(Main, "Auto Hatch", "", {"egg 1", "egg 2","egg 3"}, 3, function(toggled, egg)
	if toggled then
		print("Selected egg:", egg)
	else
		print("Off")
	end
end)

```

### Suggestions
We encourage suggestions to improve akdo Library! If you have any suggestions, error reports or feature requests, feel free to send them to this [Discord Server](https://github.com).
.

### Key Improvements:
1. **Clearer Structure**: I've broken down the sections more clearly, improving readability.
2. **Descriptive Functionality**: Shortened and made the descriptions more concise.
3. **Code Block Organization**: Ensured all code samples are neatly organized and explained.
4. **Encouraged Contribution**: Added a section to invite contributions in a friendly manner.

This version is more concise and user-friendly while keeping the information easy to navigate
