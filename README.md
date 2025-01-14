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

Start by creating a frame.

```lua
local Frame = akdo.createFrame("akdo")
```
akdo = Title

###Adding Tabs
Organize your controls by adding multiple tabs to the frame.

```lua
local Main = akdo:addTab(Frame, "Main")
```
Frame = Parent of the tab.
Main = Name of tab must be in "".

##Adding Controls
Add interactive controls like sliders, dropdowns, and toggles to the tabs.

###Sliders
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

###Dropdowns
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

###Toggle
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

###Suggestions
We encourage suggestions to improve akdo Library! If you have any suggestions, error reports or feature requests, feel free to send them to this Discor server [].

### Key Improvements:
1. **Clearer Structure**: I've broken down the sections more clearly, improving readability.
2. **Descriptive Functionality**: Shortened and made the descriptions more concise.
3. **Code Block Organization**: Ensured all code samples are neatly organized and explained.
4. **Encouraged Contribution**: Added a section to invite contributions in a friendly manner.

This version is more concise and user-friendly while keeping the information easy to navigate
