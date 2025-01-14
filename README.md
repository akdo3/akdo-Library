# akdo UI Library for Roblox

**akdo UI Library** is a versatile and easy-to-use UI framework that empowers Roblox developers to create advanced and dynamic user interfaces. With features like tabs, sliders, dropdowns, and toggles, it simplifies UI management and enhances the user experience.

## Features

- **Dynamic Tab Management**: Effortlessly create and organize multiple tabs for a well-structured interface.
- **Interactive Sliders and Toggles**: Modify game elements like speed, jump power, and FOV in real-time with responsive controls.
- **Customizable Dropdown Menus**: Easily implement interactive dropdowns with user-defined options.

### Setting Up the UI Frame

Start by creating a frame to hold all your UI components.

```lua
local Frame = akdo.createFrame("akdo")
```
akdo = Title

Adding Tabs
Organize your controls by adding multiple tabs to the frame.

```lua
local Main = akdo:addTab(Frame, "Main")
```
Frame = Parent of the tab
Main = Name of tab

Adding Controls
Add interactive controls like sliders, dropdowns, and toggles to the tabs.

Sliders
Use sliders to modify player attributes such as speed.

```lua
akdo:addSlider(Player, "Speed", "Adjust the player's speed", 0, 500, function(value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)
```
Player = Which Tab the slider will be
Speed = Name of the Slider
Adjust the player's speed = This is the Info
0 = Min Slider Value
500 = Max Slider Value

Dropdowns
Create dropdowns to allow users to select from multiple options.

```lua
akdo:addDropdown(Main, "Device Type", "Select your device type", {"Mobile", "PC"}, 2, function(val)
    print("Selected device type:", val)
end)
```
Toggles
Add toggles to enable or disable features like space flight mode.

```lua
akdo:addToggle(Player, "name", "Info", function(value)
    if value then

    else

    end
end)
```
Language Selection
Provide language options using a dropdown to enhance accessibility for different users.

```lua
local languages = { "English", "Arabic", "Spanish", ... }
akdo:addDropdown(Main, "Language", "Choose your preferred language", languages, 4, function(_, language)
    print("Selected language:", language)
end)
```
Contribution
We encourage contributions to improve the akdo UI Library! If you have any suggestions, bug reports, or feature requests, feel free to submit a pull request or open an issue.

License
This project is licensed under the MIT License. See the LICENSE file for more details.

markdown
Copy code

### Key Improvements:
1. **Clearer Structure**: I've broken down the sections more clearly, improving readability.
2. **Descriptive Functionality**: Shortened and made the descriptions more concise.
3. **Code Block Organization**: Ensured all code samples are neatly organized and explained.
4. **Encouraged Contribution**: Added a section to invite contributions in a friendly manner.

This version is more concise and user-friendly while keeping the information easy to navigate
