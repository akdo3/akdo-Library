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
local LocalPlayer = game.Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

local Frame = akdo.createFrame( "akdo")
local Main = akdo:addTab(Frame, "Main")
local DeviceType

local Player = akdo:addTab(Frame, "Player")

akdo:addSection(Player, "This is Section")
akdo:addLabel(Player, "This is Label")

akdo:addSliderAndTextBox(Player, "Speed", "", "", 0, 500, function(value,value2) 
	Humanoid.WalkSpeed = value
	Humanoid.WalkSpeed = value2
end, false, false, true)

akdo:addSliderAndTextBox(Player, "Jump", "", "", 0, 500, function(value,value2) 
	Humanoid.JumpPower = value
	Humanoid.JumpHeight = value
	Humanoid.JumpPower = value2
	Humanoid.JumpHeight = value2
end, false, false, true)

akdo:addSliderAndTextBox(Player, "Fov", "", "", 0, 120, function(value,value2) 
	game.Workspace.CurrentCamera.FieldOfView = value
	game.Workspace.CurrentCamera.FieldOfView = value2
end, false, false, true)

akdo:addSliderAndTextBox(Player, "Gravity", "", "", 0, 500, function(value,value2) 
	game.Workspace.Gravity = value
	game.Workspace.Gravity = value2
end, false, false, true)

local OldGravity = game.Workspace.Gravity
local OldSpeed = Humanoid.WalkSpeed
local OldJumpPower  = Humanoid.JumpPower
local OldJumpHeight = Humanoid.JumpHeight

akdo:addDropdownAndToggle(Player, "Choose", {"Super Hero", "Hero", "Normal"}, 3, function(val1,val2)
	print(val2)
	if val1 then
		if val2 == "Super Hero" then
			Humanoid.WalkSpeed = 120
			Humanoid.JumpPower = 150
			Humanoid.JumpHeight = 50
		elseif val2 == "Hero" then
			Humanoid.WalkSpeed = 75
			Humanoid.JumpPower = 100
			Humanoid.JumpHeight = 25
		elseif val2 == "Normal" then
			Humanoid.WalkSpeed = 16
			Humanoid.JumpPower = 50
			Humanoid.JumpHeight = 7.5
		end
	else
		Humanoid.WalkSpeed = OldSpeed
		Humanoid.JumpPower = OldJumpPower
		Humanoid.JumpHeight = OldJumpHeight
	end
end)

akdo:addDropdownAndToggle(Player, "Choose", {"Super Speed & Jump", "Super Speed", "Super Jump"}, 3, function(val1,val2)
	if val1 then
		if val2 == "Super Speed & Jump" then
			Humanoid.WalkSpeed = 120
			Humanoid.JumpPower = 150
			Humanoid.JumpHeight = 50
		elseif val2 == "Super Speed" then
			Humanoid.WalkSpeed = 120
		elseif val2 == "Super Jump" then
			Humanoid.JumpPower = 50
			Humanoid.JumpHeight = 7.5
		end
	else
		if val2 == "Super Speed & Jump" then
			Humanoid.WalkSpeed = OldSpeed
			Humanoid.JumpPower = OldJumpPower
			Humanoid.JumpHeight = OldJumpHeight
		elseif val2 == "Super Speed" then
			Humanoid.WalkSpeed = OldSpeed
		elseif val2 == "Super Jump" then
			Humanoid.JumpPower = OldJumpPower
			Humanoid.JumpHeight = OldJumpHeight
		end
	end
end)

akdo:addSection(Player, "Toggle Section")

akdo:addToggle(Player, "Space Fly", "Jump and you will go up but can move in the X-axis,After long time you will go down.", function(val) 
	if val then
		Humanoid.WalkSpeed = 750
		Humanoid.JumpPower = 500
		Humanoid.JumpHeight = 500
		game.Workspace.Gravity = 0.1
	else
		Humanoid.WalkSpeed = OldSpeed
		Humanoid.JumpPower = OldJumpPower
		Humanoid.JumpHeight = OldJumpHeight
		game.Workspace.Gravity = OldGravity
	end
end)

local row = akdo:addRow(Player, 4)

akdo:addToggle(row, "Fly", "", function(val) 
	if val then
		
	else
		
	end
end)

akdo:addToggle(row, "NoClip", "", function(val) 
	if val then
		for _, part in ipairs(Character:GetDescendants()) do
			if part:IsA("BasePart") and part.CanCollide then
				part.CanCollide = false
			end
		end
	else
		for _, part in ipairs(Character:GetDescendants()) do
			if part:IsA("BasePart") and not part.CanCollide then
				part.CanCollide = true
			end
		end
	end
end)

akdo:addToggle(row, "Inf Jump", "", function(val) 
	if val then

	else

	end
end)

akdo:addToggle(Player, "Invisible", "", function(val) 
	if val then

	else

	end
end)

akdo:addToggle(Player, "Reset Characte", "", function(val) 
	if val then

	else

	end
end)

akdo:addButton(Player, "Refresh old stats", "When you disable any speed toggle, your stats will revert to the old ones, this makes your speed the old one.", function()
	OldGravity 		= game	  .Workspace.Gravity
	OldSpeed 		= Humanoid.WalkSpeed
	OldJumpPower  	= Humanoid.JumpPower
	OldJumpHeight 	= Humanoid.JumpHeight
end)


local languages = {
	"English", "Arabic", "Spanish", "French", "German", "Chinese", "Japanese", "Korean", 
	"Russian", "Portuguese", "Italian", "Dutch", "Hindi", "Bengali", "Turkish", 
	"Swedish", "Norwegian", "Finnish", "Danish", "Greek", "Hebrew", "Thai", "Vietnamese", 
	"Polish", "Czech", "Slovak", "Hungarian", "Romanian", "Ukrainian", "Indonesian", 
	"Malay", "Filipino", "Serbian", "Croatian", "Slovenian", "Bulgarian", "Lithuanian", 
	"Latvian", "Estonian", "Persian", "Urdu", "Tamil", "Telugu", "Kannada", "Malayalam", 
	"Gujarati", "Punjabi", "Marathi", "Swahili", "Zulu", "Afrikaans", "Amharic", "Yoruba",
	"Hausa", "Igbo", "Catalan", "Basque", "Galician", "Welsh", "Irish", "Scottish Gaelic",
	"Maltese", "Icelandic", "Esperanto"
}

akdo:addDropdown(Main, "Language", "", languages, 4, function(toggled, language)
	if not toggled then
		print("Selected language:", language)
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
