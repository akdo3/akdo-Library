# akdo UI Library for Roblox

**akdo UI Library** is a versatile and easy-to-use UI framework that empowers Roblox developers to create advanced and dynamic user interfaces. With features like tabs, sliders, dropdowns, toggles, and multilingual support, it simplifies UI management and enhances the user experience.

## Features

- **Dynamic Tab Management**: Effortlessly create and organize multiple tabs for a well-structured interface.
- **Interactive Sliders and Toggles**: Modify game elements like speed, jump power, FOV, and gravity in real-time with responsive controls.
- **Customizable Dropdown Menus**: Easily implement interactive dropdowns with user-defined options.
- **Multilingual Support**: Offer your users a global experience by providing multilingual UI options.
- **Device-Specific Features**: Customize the UI based on the user's platform (Mobile or PC) for optimal performance.

## Usage

### Setting Up the UI Frame

Start by creating a frame to hold all your UI components.

```lua
local Frame = akdo.createFrame("akdo")
Adding Tabs
Organize your controls by adding multiple tabs to the frame.

```lua
Copy code
local Main = akdo:addTab(Frame, "Main")
local Player = akdo:addTab(Frame, "Player")
Adding Controls
Add interactive controls like sliders, dropdowns, and toggles to the tabs.

Sliders
Use sliders to modify player attributes such as speed.

lua
Copy code
akdo:addSliderAndTextBox(Player, "Speed", "Adjust the player's speed", "", 0, 500, function(value)
    Humanoid.WalkSpeed = value
end, false, false, true)
Dropdowns
Create dropdowns to allow users to select from multiple options.

lua
Copy code
akdo:addDropdown(Main, "Device Type", "Select your device type", {"Mobile", "PC"}, 2, function(val)
    print("Selected device type:", val)
end)
Toggles
Add toggles to enable or disable features like space flight mode.

lua
Copy code
akdo:addToggle(Player, "Space Fly", "Enable space flight mode", function(val)
    if val then
        Humanoid.WalkSpeed = 750
        Humanoid.JumpPower = 500
        game.Workspace.Gravity = 0.1
    else
        Humanoid.WalkSpeed = OldSpeed
        Humanoid.JumpPower = OldJumpPower
        game.Workspace.Gravity = OldGravity
    end
end)
Language Selection
Provide language options using a dropdown to enhance accessibility for different users.

lua
Copy code
local languages = { "English", "Arabic", "Spanish", ... }
akdo:addDropdown(Main, "Language", "Choose your preferred language", languages, 4, function(_, language)
    print("Selected language:", language)
end)
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
