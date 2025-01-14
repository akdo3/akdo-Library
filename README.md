# akdo UI Library for Roblox

**akdo UI Library** is a versatile and easy-to-use UI framework that empowers Roblox developers to create advanced and dynamic user interfaces. With features like tabs, sliders, dropdowns, and toggles, it simplifies UI management and enhances the user experience.

## Features

- **Dynamic Tab Management**: Effortlessly create and organize multiple tabs for a well-structured interface.
- **Interactive Sliders and Toggles**: Modify game elements like speed, jump power, and FOV in real-time with responsive controls.
- **Customizable Dropdown Menus**: Easily implement interactive dropdowns with user-defined options.

## Load the Library

To load the library into your game, use the following code:

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/akdo3/akdo-Library/refs/heads/main/Main.lua"))()
```

### Setting Up the Frame
Start by creating a frame for your UI.

```lua
local Frame = akdo.createFrame("akdo")
```

`akdo` = Title of the frame.

### Adding Tabs
Organize your controls by adding multiple tabs to the frame.

```lua
local Main = akdo:addTab(Frame, "Main")
```

`Frame` = Parent of the tab.
`Main` = Name of the tab.

## Adding Controls
Add interactive controls like buttons, sliders, dropdowns, and toggles to the tabs.

### Buttons
```lua
akdo:addButton(Main, "Speed", "Change your speed", function()
    print("Clicked")
end)
```

`Main` = Tab where the button will be.
`Speed` = Name of the button.
`Change your speed` = Info about the button.

### Sliders
Use sliders to modify player attributes such as speed.

```lua
akdo:addSlider(Main, "Speed", "Adjust the player's speed", 0, 500, function(value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)
```

`Main` = Tab where the slider will be.
`Speed` = Name of the slider.
`Adjust the player's speed` = Info.
`0` = Min Slider Value.
`500` = Max Slider Value.

### Dropdowns
Create dropdowns to allow users to choose from multiple options.

```lua
local options = {
    "Option 1",
    "Option 2",
    "Option 3",
}
akdo:addDropdown(Main, "Choose option", "Choose the option you want", options, 2, function(option)
    print("Selected option:", option)
end)
```

`Main` = Tab where the dropdown will be.
`Choose` option = Name of the dropdown.
`Choose` the option you want = Info.
`options` = The list of options available in the dropdown.

### Toggles
Add toggles to enable or disable features.

```lua
akdo:addToggle(Main, "Fly", "You Will Fly", function(value)
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

## Example
```lua
local Frame = akdo.createFrame("akdo")
local Main = akdo:addTab(Frame, "Main")

akdo:addSection(Player, "Section")
akdo:addLabel(Player, "Label")

local button = akdo:addButton(Main, "Button", "Info, tutorial", function()
    print("Button Clicked")
end)

akdo:addSliderAndTextBox(Player, "Speed", "", "", 0, 500, function(value,value2) 
    Humanoid.WalkSpeed = value2
end, false, false, true)

local table = {
    "egg 1", "egg 2", 
}
akdo:addDropdownAndToggle(Player, "Auto Hatch", table, 1, function(val1, val2)
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

akdo:addToggle(Player, "Noclip", "Make you pass through anything", function(val) 
    if val then
        print("On")
    else
        print("Off")
    end
end)

local row = akdo:addRow(Player, 2)

akdo:addToggle(row, "Fly", "", function(val) 
    if val then
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

## Fast Code
```lua
local Frame = akdo.createFrame("akdo")
local Main = akdo:addTab(Frame, "Main")

akdo:addSection(Player, "Section")

local button = akdo:addButton(Main, "Button", "Info, tutorial", function()

end)

akdo:addSlider(Player, "Speed", "", "", 0, 500, function(value,value2)

end)

local table = {
    "",
    "", 
}

akdo:addDropdownAndToggle(Player, "", table, 1, function(val1, val2)
    if val1 then
        if val2 == "
" then

        elseif val2 == "egg 2" then

        end
    else

    end
end)

akdo:addToggle(Player, "", "", function(val) 
    if val then
        print("On")
    else
        print("Off")
    end
end)

local row = akdo:addRow(Player, 2)

akdo:addToggle(row, "Fly", "", function(val) 
    if val then
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
## Suggestions
We encourage suggestions to improve the akdo Library! If you have any suggestions, error reports, or feature requests, feel free to send them to this Discord Server.

Key Improvements:
Clearer Structure: Sections are organized for better readability.
Descriptive Functionality: Shortened and made descriptions more concise.
Code Block Organization: All code samples are neatly organized and explained.
Encouraged Contribution: Added a section to invite contributions in a friendly manner.
This version is more concise and user-friendly while keeping the information easy to navigate.

vbnet
Copy code

This version provides a well-structured `README.md` with clear sections, code samples, and explanations for the various features and functions of your `akdo` UI Library. Let me know if you'd like further modifications!

