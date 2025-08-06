local akdo = {}
akdo.Setting = {
	Theme = {
		Transparency				= 0.06,
		BackgroundColor 		    = Color3.fromRGB(10, 10, 18),
		TextColor 				    = Color3.fromRGB(0, 235, 0),
		BorderColor 			    = Color3.fromRGB(0, 235, 0),
		AccentColor                 = Color3.fromRGB(30, 30, 30),
		ButtonColor 			    = Color3.fromRGB(16, 16, 16),
		ErrorColor                  = Color3.fromRGB(255, 50, 50),
		TextNeonColor				= Color3.fromRGB(0, 100, 0),
		ToggleOnColor 				= Color3.fromRGB(0, 255, 0),
		ToggleOffColor 				= Color3.fromRGB(180, 180, 180),
		NotificationsMainColor		= Color3.fromRGB(0, 255, 0),
		TabUnderLineColor			= Color3.fromRGB(0, 235, 0),
		confirmationFrame = {
			Transparency		= 0.06,
			BackgroundColor		= Color3.fromRGB(10, 10, 18),
			TextColor			= Color3.fromRGB(0, 255, 0),
			BorderColor			= Color3.fromRGB(0, 255, 0),
			ButtonColor			= Color3.fromRGB(25, 25, 25),
			ButtonBorderColor	= Color3.fromRGB(0, 255, 0),
			ButtonHoverColor    = Color3.fromRGB(30, 30, 30),
		},
	},

	Animation = {
		TweenInfo 		= TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
		FastTween       = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
	},

	Layout = {
		Padding 		= UDim.new(0, 10),
		ElementCorner 	= UDim.new(0.2, 0),
		WindowCorner    = UDim.new(0.03, 0),
		ButtonSize		= UDim2.new(0.95, 0, 0, 30),
	},

	Components = {
		Image = {
			ImageSize  	 = UDim2.new(0.1, 0, 1, 0),
			InfoImagePOS = UDim2.new(0.9, 0, 0, 0),
			InfoImageId  = "http://www.roblox.com/asset/?id=6026568210",
		},
		TextSize = {
			Full      = UDim2.new(1, 0, 1, 0),
			WithIcon  = UDim2.new(0.9, 0, 1, 0),
			WithTwoIcons = UDim2.new(0.8, 0, 1, 0),
		},
		Toggle = {
			Circle = {
				On  = "http://www.roblox.com/asset/?id=6031068426",
				Off = "http://www.roblox.com/asset/?id=6031068433",
			},
			Like = {
				On  = "http://www.roblox.com/asset/?id=6031229347",
				Off = "http://www.roblox.com/asset/?id=6031229342",
			},
			Dislike = {
				On  = "http://www.roblox.com/asset/?id=6031229336",
				Off = "http://www.roblox.com/asset/?id=6031229354",
			},
			Microfone = {
				On  = "http://www.roblox.com/asset/?id=6026660078",
				Off = "http://www.roblox.com/asset/?id=6026660066",
			},
			Cloud = {
				On  = "http://www.roblox.com/asset/?id=6031302918",
				Off = "http://www.roblox.com/asset/?id=6031302916",
			},
			Stare = {
				On  = "http://www.roblox.com/asset/?id=6031068423",
				Off = "http://www.roblox.com/asset/?id=6031068425",
			},
			[1] = {
				On  = "rbxassetid://6031068426",
				Off = "rbxassetid://6031068433",
			},
			[2] = {
				On  = "rbxassetid://6031229347",
				Off = "rbxassetid://6031229342",
			},
			[3] = {
				On  = "rbxassetid://6031229336",
				Off = "rbxassetid://6031229354",
			},
			[4] = {
				On  = "rbxassetid://6026660078",
				Off = "rbxassetid://6026660066",
			},
			[5] = {
				On  = "rbxassetid://6031302918",
				Off = "rbxassetid://6031302916",
			},
			[6] = {
				On  = "rbxassetid://6031068423",
				Off = "rbxassetid://6031068425",
			},
		},
	},
	Notifications = false,
	RowCellPadding = UDim2.new(0.05, 0, 0.05, 0),
	ButtonPOS = UDim2.new(0.05, 0, 0, 0),
}

function akdo:createFrame(titletext)
	local UserInputService = game:GetService("UserInputService")
	local TweenService = game:GetService("TweenService")
	local RunService = game:GetService("RunService")
	local Players = game:GetService("Players")
	local LocalPlayer = Players.LocalPlayer

	local Theme 				= akdo.Setting.Theme
	local confirmationFrameSe	= Theme.confirmationFrame
	local Animation 			= akdo.Setting.Animation
	local Layout 				= akdo.Setting.Layout
	local Components 			= akdo.Setting.Components
	local Notifications 		= akdo.Setting.Notifications

	local MOTION_MAIN = TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	local MOTION_CONTENT_FADE = TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	local MOTION_CLICK = TweenInfo.new(0.12, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	local MOTION_UNDERLINE = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	local MOTION_RESPONSIVE = TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

	local windowState = "Restored"
	local originalSize, originalPosition
	local lastMinimizedPosition = nil

	local function addCorner(instance, radius)
		local corner = Instance.new("UICorner")
		corner.CornerRadius = radius
		corner.Parent = instance
		return corner
	end

	local function addStroke(instance, thickness, color, strokeType)
		local stroke = Instance.new("UIStroke")
		stroke.Color = color
		stroke.Thickness = thickness
		stroke.ApplyStrokeMode = strokeType or Enum.ApplyStrokeMode.Contextual
		stroke.Parent = instance
		return stroke
	end

	local function makeDraggable(element, target)
		target = target or element
		local dragging = false
		local dragInput
		local dragStart
		local startPos

		element.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				dragStart = input.Position
				startPos = target.Position

				local connection
				connection = input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragging = false
						connection:Disconnect()
					end
				end)
			end
		end)

		element.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				dragInput = input
			end
		end)

		UserInputService.InputChanged:Connect(function(input)
			if input == dragInput and dragging then
				local delta = input.Position - dragStart
				target.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			end
		end)
	end

	local function createHeaderButton(parent, symbol, positionScale, callback, color)
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(0.066, 0, 1, 0)
		btn.Position = UDim2.new(positionScale, 0, 0, 0)
		btn.BackgroundTransparency = 1
		btn.Text = symbol
		btn.Font = Enum.Font.GothamBold
		btn.TextScaled = true
		btn.TextColor3 = color or Theme.TextColor
		btn.AutoButtonColor = false
		btn.Parent = parent

		local originalBtnPos = btn.Position
		local originalBtnSize = btn.Size

		local underline = Instance.new("Frame")
		underline.AnchorPoint = Vector2.new(0.5, 0.5)
		underline.Size = UDim2.new(0, 0, 0, 2)
		underline.Position = UDim2.new(0.5, 0, 1, -2)
		underline.BackgroundColor3 = color or Theme.TextColor
		underline.BackgroundTransparency = 1
		underline.BorderSizePixel = 0
		underline.Parent = btn
		btn.MouseEnter:Connect(function() TweenService:Create(underline, MOTION_UNDERLINE, {Size = UDim2.new(0.8, 0, 0, 2), BackgroundTransparency = 0}):Play() end)
		btn.MouseLeave:Connect(function() TweenService:Create(underline, MOTION_UNDERLINE, {Size = UDim2.new(0, 0, 0, 2), BackgroundTransparency = 1}):Play() end)
		btn.MouseButton1Down:Connect(function()
			local newSize = UDim2.new(originalBtnSize.X.Scale * 0.95, 0, originalBtnSize.Y.Scale, 0)
			TweenService:Create(btn, MOTION_CLICK, {Position = originalBtnPos + UDim2.fromOffset(0, 1), Size = newSize}):Play()
		end)
		btn.MouseButton1Up:Connect(function() TweenService:Create(btn, MOTION_CLICK, {Position = originalBtnPos, Size = originalBtnSize}):Play() end)
		btn.MouseButton1Click:Connect(callback)
		return btn
	end

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
	ScreenGui.IgnoreGuiInset = true 

	local Frame = Instance.new("Frame")
	Frame.Position = UDim2.new(0.25, 0, 0.25, 0)
	Frame.Size = UDim2.new(0.45, 0, 0.5, 0)
	Frame.BackgroundColor3 = Theme.BackgroundColor
	Frame.Transparency = Theme.Transparency
	Frame.Parent = ScreenGui

	addStroke(Frame, 2, Theme.BackgroundColor)
	addCorner(Frame, Layout.WindowCorner)

	local DropShadowHolder = Instance.new("Frame")
	DropShadowHolder.Parent = Frame
	DropShadowHolder.BackgroundTransparency = 1
	DropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
	DropShadowHolder.ZIndex = 0

	local DropShadow = Instance.new("ImageLabel")
	DropShadow.Parent = DropShadowHolder
	DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
	DropShadow.BackgroundTransparency = 1
	DropShadow.BorderSizePixel = 0
	DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	DropShadow.Size = UDim2.new(1.08, 0, 1.2, 0)
	DropShadow.ZIndex = 0
	DropShadow.Image = "rbxassetid://6015897843"
	DropShadow.ImageColor3 = Theme.BackgroundColor
	DropShadow.ImageTransparency = 0.5
	DropShadow.ScaleType = Enum.ScaleType.Slice
	DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)

	local Header = Instance.new("Frame")
	Header.Size = UDim2.new(1, 0, 0.125, 0)
	Header.BackgroundColor3 = Theme.AccentColor
	Header.BackgroundTransparency = Theme.Transparency
	Header.Parent = Frame
	addCorner(Header, Layout.ElementCorner)

	makeDraggable(Header, Frame)

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(0.7, 0, 1, 0)
	title.Position = UDim2.new(0.02, 0, 0, 0)	
	title.Text = titletext or "akdo"
	title.TextColor3 = Theme.TextColor
	title.TextScaled = true
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.BackgroundTransparency = 1
	title.Parent = Header

	local minimizedButton = Instance.new("Frame")
	minimizedButton.Name = "MinimizedStub"
	minimizedButton.Size = UDim2.new(0.1, 0, 0.08, 0)
	minimizedButton.AnchorPoint = Vector2.new(0.5, 0.5)
	minimizedButton.Position = UDim2.new(0.5, 0, 0.5, 0)
	minimizedButton.BackgroundTransparency = 1
	minimizedButton.Visible = false
	minimizedButton.ZIndex = 1000
	minimizedButton.Parent = ScreenGui

	local titleButton = Instance.new("TextButton")
	titleButton.Name = "TitleButton"
	titleButton.Size = UDim2.fromScale(1, 1)
	titleButton.Position = UDim2.fromScale(0.5, 0.5)
	titleButton.AnchorPoint = Vector2.new(0.5, 0.5)
	titleButton.BackgroundColor3 = Color3.new(0, 0, 0)
	titleButton.BackgroundTransparency = 0.3
	titleButton.Font = Enum.Font.GothamBlack
	titleButton.Text = titletext or "akdo"
	titleButton.TextColor3 = Theme.TextColor
	titleButton.TextScaled = true
	titleButton.TextTransparency = 1
	titleButton.Parent = minimizedButton
	addStroke(titleButton, 1.5, Color3.new(0, 0, 0))
	addCorner(titleButton, UDim.new(0.2, 0))

	makeDraggable(titleButton, minimizedButton)

	function akdo:confirmationFrame(text, onAccept)
		if Frame:FindFirstChild("akdo_confirm") then return end
		local tweenInfo_Container = TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
		local tweenInfo_Content = TweenInfo.new(0.7, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
		local tweenInfo_Hover = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local tweenInfo_Exit = TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.In)

		local confirmationFrame = Instance.new("Frame")
		confirmationFrame.Name = "akdo_confirm"
		confirmationFrame.AnchorPoint = Vector2.new(0.5, 0.5)
		confirmationFrame.Position = UDim2.new(0.5, 0, 0.45, 0)
		confirmationFrame.Size = UDim2.new(0.55, 0, 0, 0)
		confirmationFrame.BackgroundColor3 = confirmationFrameSe.BackgroundColor
		confirmationFrame.BackgroundTransparency = 1
		confirmationFrame.ClipsDescendants = true
		confirmationFrame.ZIndex = 99
		confirmationFrame.Parent = Frame
		addCorner(confirmationFrame, akdo.Setting.Layout.WindowCorner)
		addStroke(confirmationFrame, 1.2, confirmationFrameSe.BorderColor)

		local contentHolder = Instance.new("Frame")
		contentHolder.Name = "ContentHolder"
		contentHolder.Size = UDim2.new(1, 0, 1, 0)
		contentHolder.Position = UDim2.new(0, 0, 1, 0)
		contentHolder.BackgroundTransparency = 1
		contentHolder.Parent = confirmationFrame

		local title = Instance.new("TextLabel")
		title.Size = UDim2.new(1, -40, 0.3, 0)
		title.Position = UDim2.new(0, 20, 0.05, 0)
		title.Text = text
		title.TextColor3 = confirmationFrameSe.TextColor
		title.TextScaled = true
		title.BackgroundTransparency = 1
		title.Font = Enum.Font.GothamBlack
		title.ZIndex = 100
		title.Parent = contentHolder

		local function closeDialog(andDestroyUI)
			if not confirmationFrame or not confirmationFrame.Parent then return end

			TweenService:Create(contentHolder, tweenInfo_Exit, {Position = UDim2.new(0, 0, 1, 0)}):Play()
			local exitTween = TweenService:Create(confirmationFrame, TweenInfo.new(tweenInfo_Exit.Time + 0.1, tweenInfo_Exit.EasingStyle, tweenInfo_Exit.EasingDirection), {BackgroundTransparency = 1, Size = UDim2.new(confirmationFrame.Size.X.Scale, 0, 0, 0)})
			exitTween:Play()

			exitTween.Completed:Connect(function() 
				if confirmationFrame and confirmationFrame.Parent then
					confirmationFrame:Destroy() 
				end
				if andDestroyUI and onAccept then
					onAccept()
				end
			end)
		end

		TweenService:Create(confirmationFrame, tweenInfo_Container, {Size = UDim2.new(0.55, 0, 0.36, 0), Position = UDim2.new(0.5, 0, 0.5, 0), BackgroundTransparency = confirmationFrameSe.Transparency}):Play()
		TweenService:Create(contentHolder, tweenInfo_Content, {Position = UDim2.new(0, 0, 0, 0)}):Play()

		local function themedButton(text, position, callback)
			local b = Instance.new("TextButton")
			b.Name = text .. "Button"
			b.Size = UDim2.new(0.42, 0, 0.25, 0)
			b.Position = position
			b.Text = text
			b.Font = Enum.Font.GothamBlack
			b.TextColor3 = confirmationFrameSe.TextColor
			b.TextScaled = true
			b.BackgroundColor3 = confirmationFrameSe.ButtonColor
			b.AutoButtonColor = false
			b.ZIndex = 100
			b.Parent = contentHolder
			addCorner(b, Layout.ElementCorner)
			local stroke = addStroke(b, 2, confirmationFrameSe.BorderColor, Enum.ApplyStrokeMode.Border)
			local originalBtnPosition = b.Position

			b.MouseEnter:Connect(function()
				TweenService:Create(b, tweenInfo_Hover, {BackgroundColor3 = confirmationFrameSe.ButtonHoverColor, Position = originalBtnPosition - UDim2.fromOffset(0, 3)}):Play()
				TweenService:Create(stroke, tweenInfo_Hover, {Thickness = 2.5}):Play()
			end)

			b.MouseLeave:Connect(function()
				TweenService:Create(b, tweenInfo_Hover, {BackgroundColor3 = confirmationFrameSe.ButtonColor, Position = originalBtnPosition}):Play()
				TweenService:Create(stroke, tweenInfo_Hover, {Thickness = 2}):Play()
			end)

			b.MouseButton1Click:Connect(callback)
			return b
		end

		themedButton("Yes", UDim2.new(0.53, 0, 0.6, 0), function() closeDialog(true) end)
		themedButton("No", UDim2.new(0.05, 0, 0.6, 0), function() closeDialog(false) end)

		local internalCloseBtn = Instance.new("TextButton")
		internalCloseBtn.Text = "X"
		internalCloseBtn.Font = Enum.Font.GothamBold
		internalCloseBtn.TextScaled = true
		internalCloseBtn.TextColor3 = Theme.ErrorColor
		internalCloseBtn.BackgroundTransparency = 1
		internalCloseBtn.Size = UDim2.new(0.1, 0, 0.2, 0)
		internalCloseBtn.Position = UDim2.new(0.9, 0, 0, 0)
		internalCloseBtn.ZIndex = 101
		internalCloseBtn.Parent = contentHolder
		internalCloseBtn.MouseButton1Click:Connect(function() closeDialog(false) end)

		return confirmationFrame
	end

	local buttonClose = createHeaderButton(Header, "X", 0.93, function()
		akdo:confirmationFrame("Are you sure you want to close?", function()
			local mainFrame = Frame
			if not mainFrame or not mainFrame.Parent then return end

			local shardContainer = Instance.new("Frame")
			shardContainer.Name = "ShardContainer"
			shardContainer.Parent = mainFrame.Parent
			shardContainer.Size = mainFrame.Size
			shardContainer.Position = mainFrame.Position
			shardContainer.BackgroundColor3 = mainFrame.BackgroundColor3
			shardContainer.BackgroundTransparency = 1 
			shardContainer.ClipsDescendants = true
			shardContainer.ZIndex = mainFrame.ZIndex + 10
			mainFrame.Visible = false

			local SHARD_COUNT = 60
			local DURATION = 1.5
			local SPREAD_FACTOR = 1.2

			local rng = Random.new()
			local center = shardContainer.AbsoluteSize / 2

			for i = 1, SHARD_COUNT do
				local shard = Instance.new("Frame")
				shard.Name = "Shard"
				shard.Parent = shardContainer
				shard.AnchorPoint = Vector2.new(0.5, 0.5)
				shard.BorderSizePixel = 0
				shard.BackgroundColor3 = mainFrame.BackgroundColor3

				local size = rng:NextNumber(25, 80)
				local x = rng:NextNumber(0, shardContainer.AbsoluteSize.X)
				local y = rng:NextNumber(0, shardContainer.AbsoluteSize.Y)
				shard.Position = UDim2.fromOffset(x, y)
				shard.Size = UDim2.fromOffset(size, size)
				shard.Rotation = rng:NextNumber(0, 360)

				local vectorFromCenter = (Vector2.new(x, y) - center).Unit
				local travelDistance = (Vector2.new(x, y) - center).Magnitude * SPREAD_FACTOR

				local delayTime = (center - Vector2.new(x,y)).Magnitude / center.Magnitude * (DURATION * 0.2)

				task.delay(delayTime, function()
					if not shard or not shard.Parent then return end

					local tweenInfo = TweenInfo.new(
						DURATION - delayTime,
						Enum.EasingStyle.Cubic,
						Enum.EasingDirection.Out
					)

					local goals = {
						Position = UDim2.fromOffset(x + vectorFromCenter.X * travelDistance, y + vectorFromCenter.Y * travelDistance),
						Rotation = shard.Rotation + rng:NextNumber(-90, 90),
						BackgroundTransparency = 1
					}

					TweenService:Create(shard, tweenInfo, goals):Play()
				end)
			end

			task.delay(DURATION + 0.1, function()
				if ScreenGui then
					ScreenGui:Destroy()
				end
			end)
		end)
	end, Theme.ErrorColor)

	local buttonMaximize = createHeaderButton(Header, "□", 0.865, function()
		task.wait(MOTION_CONTENT_FADE.Time)
		local goal
		if windowState == "Maximized" then
			windowState = "Restored"
			goal = {Size = originalSize, Position = originalPosition}
		else
			windowState = "Maximized"
			originalSize = Frame.Size
			originalPosition = Frame.Position
			goal = {Size = UDim2.new(1, 0, 1, 0), Position = UDim2.new(0, 0, 0, 0)}
		end
		local tween = TweenService:Create(Frame, MOTION_MAIN, goal)
		tween:Play()
	end)

	local buttonMinimize = createHeaderButton(Header, "–", 0.8, function()
		if windowState ~= "Restored" then return end
		windowState = "Animating"
		originalPosition = Frame.Position
		originalSize = Frame.Size
		local targetPosition = lastMinimizedPosition or UDim2.new(originalPosition.X.Scale + originalSize.X.Scale / 2, originalPosition.X.Offset + originalSize.X.Offset / 2, originalPosition.Y.Scale + originalSize.Y.Scale / 2, originalPosition.Y.Offset + originalSize.Y.Offset / 2)
		local tween = TweenService:Create(Frame, MOTION_RESPONSIVE, {Size = UDim2.fromOffset(0, 0), Position = targetPosition, BackgroundTransparency = 1})
		tween:Play()
		tween.Completed:Connect(function()
			Frame.Visible = false
			minimizedButton.Position = targetPosition
			minimizedButton.Visible = true
			TweenService:Create(titleButton, MOTION_RESPONSIVE, {TextTransparency = 0 }):Play()
			windowState = "Minimized"
		end)
	end)

	local function animateToRestore()
		if windowState ~= "Minimized" then return end
		windowState = "Animating"
		lastMinimizedPosition = minimizedButton.Position

		TweenService:Create(titleButton, MOTION_RESPONSIVE, {TextTransparency = 1}):Play()
		task.wait(MOTION_RESPONSIVE.Time + 0.1)
		Frame.Position = minimizedButton.Position
		Frame.Size = UDim2.fromOffset(0, 0)
		Frame.BackgroundTransparency = 1
		Frame.Visible = true
		minimizedButton.Visible = false
		local tween = TweenService:Create(Frame, MOTION_MAIN, {Size = originalSize, Position = originalPosition, BackgroundTransparency = Theme.Transparency})
		tween:Play()
		tween.Completed:Connect(function() windowState = "Restored" end)
	end

	titleButton.MouseButton1Click:Connect(animateToRestore)
	titleButton.TouchTap:Connect(animateToRestore)

	local MOTION_INFO_FRAME = TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
	local MOTION_INFO_CONTENT = TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	local MOTION_INFO_HOVER = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	local InfoFrame = Instance.new("Frame")
	InfoFrame.Parent = Frame
	InfoFrame.AnchorPoint = Vector2.new(0, 1)
	InfoFrame.BackgroundColor3 = Theme.ButtonColor
	InfoFrame.Position = UDim2.new(0.2639, 0, 1, 0)
	InfoFrame.Size = UDim2.new(0.7133, 0, 0.08, 0)
	InfoFrame.Visible = false
	InfoFrame.ClipsDescendants = true
	InfoFrame.ZIndex = 999
	addCorner(InfoFrame, Layout.ElementCorner)
	addStroke(InfoFrame, 1, Theme.TextColor)

	local TextInfo = Instance.new("TextLabel")
	TextInfo.Parent = InfoFrame
	TextInfo.BackgroundTransparency = 1
	TextInfo.Size = UDim2.new(0.88, 0, 1, 0)
	TextInfo.Position = UDim2.fromScale(0.02, 0)
	TextInfo.ZIndex = 2
	TextInfo.Font = Enum.Font.Gotham
	TextInfo.TextColor3 = Theme.TextColor
	TextInfo.TextScaled = true
	TextInfo.TextXAlignment = Enum.TextXAlignment.Left

	local closeInfoFrame = Instance.new("TextButton")
	closeInfoFrame.Parent = InfoFrame
	closeInfoFrame.BackgroundTransparency = 1
	closeInfoFrame.Position = UDim2.new(0.9, 0, 0, 0)
	closeInfoFrame.Size = UDim2.new(0.1, 0, 1, 0)
	closeInfoFrame.ZIndex = 2
	closeInfoFrame.Text = "X"
	closeInfoFrame.Font = Enum.Font.GothamBold
	closeInfoFrame.TextColor3 = Theme.ErrorColor
	closeInfoFrame.TextScaled = true
	closeInfoFrame.AutoButtonColor = false

	local function HideInfo()
		if not InfoFrame.Visible then return end

		TweenService:Create(TextInfo, MOTION_INFO_CONTENT, {TextTransparency = 1}):Play()
		local closeButtonFadeOut = TweenService:Create(closeInfoFrame, MOTION_INFO_CONTENT, {TextTransparency = 1})
		closeButtonFadeOut:Play()

		closeButtonFadeOut.Completed:Connect(function()
			local frameHide = TweenService:Create(InfoFrame, MOTION_INFO_FRAME, {
				Size = UDim2.new(InfoFrame.Size.X.Scale, 0, 0, 0),
				BackgroundTransparency = 1
			})
			frameHide:Play()

			frameHide.Completed:Connect(function()
				InfoFrame.Visible = false
			end)
		end)
	end

	local function ShowInfo(message)
		if InfoFrame.Visible then
			HideInfo()
			task.wait(MOTION_INFO_FRAME.Time)
		end

		TextInfo.Text = " " .. message
		InfoFrame.Visible = true
		InfoFrame.BackgroundTransparency = 1
		InfoFrame.Size = UDim2.new(InfoFrame.Size.X.Scale, 0, 0, 0)
		TextInfo.TextTransparency = 1
		closeInfoFrame.TextTransparency = 1

		local frameShow = TweenService:Create(InfoFrame, MOTION_INFO_FRAME, {
			Size = UDim2.new(0.7133, 0, 0.08, 0),
			BackgroundTransparency = 0
		})
		frameShow:Play()

		task.delay(MOTION_INFO_FRAME.Time * 0.3, function()
			TweenService:Create(TextInfo, MOTION_INFO_CONTENT, {TextTransparency = 0}):Play()
			TweenService:Create(closeInfoFrame, MOTION_INFO_CONTENT, {TextTransparency = 0}):Play()
		end)
	end

	closeInfoFrame.MouseEnter:Connect(function()
		TweenService:Create(closeInfoFrame, MOTION_INFO_HOVER, {TextColor3 = Color3.fromRGB(255, 80, 80)}):Play()
	end)

	closeInfoFrame.MouseLeave:Connect(function()
		TweenService:Create(closeInfoFrame, MOTION_INFO_HOVER, {TextColor3 = Theme.ErrorColor}):Play()
	end)

	closeInfoFrame.MouseButton1Click:Connect(HideInfo)

	local NotificationYOffset = 0
	local ActiveNotifications = {}

	function akdo:ShowNotification(text)
		local Notification = Instance.new("Frame")
		Notification.Name = "Notification"
		Notification.Parent = ScreenGui
		Notification.Position = UDim2.new(-0.2, 0, 0.9 - (NotificationYOffset * 0.06), 0)
		Notification.Size = UDim2.new(0.15, 0, 0.05, 0)
		Notification.BackgroundTransparency = Theme.Transparency
		Notification.BackgroundColor3 = Theme.BackgroundColor
		Notification.ClipsDescendants = true
		Notification.ZIndex = 10 + (#ActiveNotifications + 3)
		addCorner(Notification, UDim.new(0.15, 0))
		addStroke(Notification, 1, Theme.NotificationsMainColor)

		local Notification_Text = Instance.new("TextLabel")
		Notification_Text.Parent = Notification
		Notification_Text.BackgroundTransparency = 1
		Notification_Text.Position = UDim2.new(0.065, 0, 0, 0)
		Notification_Text.Size = UDim2.new(0.9, 0, 0.95, 0)
		Notification_Text.Text = text or "Notification"
		Notification_Text.TextColor3 = Theme.TextColor
		Notification_Text.TextScaled = true
		Notification_Text.TextXAlignment = Enum.TextXAlignment.Left
		Notification_Text.ZIndex = 12 + (#ActiveNotifications + 3)
		addStroke(Notification_Text, 1.3, Theme.BackgroundColor)

		local Line = Instance.new("Frame")
		Line.Parent = Notification
		Line.BackgroundColor3 = Theme.NotificationsMainColor
		Line.Size = UDim2.new(0.02, 0, 1, 0)
		Line.ZIndex = 11 + (#ActiveNotifications + 3)

		local Bar = Instance.new("Frame")
		Bar.Parent = Notification
		Bar.BackgroundColor3 = Theme.NotificationsMainColor
		Bar.Position = UDim2.new(0, 0, 1, 0)
		Bar.Size = UDim2.new(1, 0, -0.1, 0)
		Bar.ZIndex = 11 + (#ActiveNotifications + 3)

		table.insert(ActiveNotifications, Notification)

		local isFlag = Instance.new("BoolValue")
		isFlag.Name = "__isBeingRemoved"
		isFlag.Value = false
		isFlag.Parent = Notification

		local isBeingRemoved = false

		local slideIn = TweenService:Create(Notification, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Position = UDim2.new(0.01, 0, 0.9 - ((#ActiveNotifications - 1) * 0.06), 0),
			BackgroundTransparency = 0
		})
		slideIn:Play()

		local barTween = TweenService:Create(Bar, TweenInfo.new(4, Enum.EasingStyle.Linear), {
			Size = UDim2.new(0, 0, -0.1, 0)
		})
		barTween:Play()

		barTween.Completed:Connect(function()
			isBeingRemoved = true
			isFlag.Value = true

			local currentY = Notification.Position.Y.Scale
			local slideOut = TweenService:Create(Notification, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				Position = UDim2.new(-0.2, 0, currentY, 0),
				BackgroundTransparency = 1
			})
			slideOut:Play()

			slideOut.Completed:Connect(function()
				if Notification and Notification.Parent then
					Notification:Destroy()
				end

				local index = table.find(ActiveNotifications, Notification)
				if index then
					table.remove(ActiveNotifications, index)
					for i = index, #ActiveNotifications do
						local noti = ActiveNotifications[i]

						local notiScript = noti:FindFirstChild("__isBeingRemoved")
						if not notiScript or not notiScript.Value then
							local moveDown = TweenService:Create(noti, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
								Position = UDim2.new(0.01, 0, 0.9 - ((i - 1) * 0.06), 0)
							})
							moveDown:Play()
						end
					end
				end
			end)
		end)
	end

	local tabContainer = Instance.new("ScrollingFrame")
	tabContainer.Size = UDim2.new(0.2, 0, 0.815, 0)
	tabContainer.Position = UDim2.new(0, 0, 0.153, 0)
	tabContainer.Transparency = 1
	tabContainer.ScrollBarThickness = 3

	tabContainer.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left
	tabContainer.CanvasSize = UDim2.new(0, 0, 0, 100)
	tabContainer.Parent = Frame
	addCorner(tabContainer, UDim.new(0, 8))

	local tabLayout = Instance.new("UIListLayout")
	tabLayout.Parent = tabContainer
	tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
	tabLayout.Padding = UDim.new(0, 5)

	local tabs = {}
	local tabsButtons = {}
	local currentTab = nil
	local isAnimating = false

	tabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		tabContainer.CanvasSize = UDim2.new(0, 0, 0, tabLayout.AbsoluteContentSize.Y + 10)
	end)

	local tabContentScroll = Instance.new("ScrollingFrame")
	tabContentScroll.Size = UDim2.new(0.76, 0, 0.809, 0)
	tabContentScroll.Position = UDim2.new(0.2, 0, 0.153, 0)
	tabContentScroll.BackgroundColor3 = Theme.BackgroundColor
	tabContentScroll.BackgroundTransparency = 1
	tabContentScroll.ScrollBarThickness = 4
	tabContentScroll.ScrollingDirection = Enum.ScrollingDirection.Y
	tabContentScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
	tabContentScroll.Parent = Frame
	addCorner(tabContentScroll, UDim.new(0, 8))

	local function updateCanvasSize(contentParent)
		tabContentScroll.CanvasSize = UDim2.new(0, 0, 0, #contentParent:GetChildren() * 35)
	end

	--[[local TabsFrame = Instance.new("Frame")
	TabsFrame.Name = "TabsFrame"
	TabsFrame.Size = UDim2.new(#tabs, 0, 1, 0)
	TabsFrame.Position = UDim2.new(0, 0, 0, 0)
	TabsFrame.BackgroundTransparency = 1
	TabsFrame.Parent = tabContentScroll

	local layout = Instance.new("UIListLayout")
	layout.FillDirection = Enum.FillDirection.Horizontal
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Parent = TabsFrame ]]

	local TabsAndStyles = {}

	local MOTION_EXIT = TweenInfo.new(0.35, Enum.EasingStyle.Cubic, Enum.EasingDirection.In)
	local MOTION_ENTER = TweenInfo.new(0.6, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)

	local styles = {
		Sleek = {
			Header = { Parent = Frame, Size = UDim2.new(1, 0, 0.125, 0), Position = UDim2.fromScale(0, 0), AnchorPoint = Vector2.new(0, 0), BackgroundTransparency = Theme.Transparency },
			title = { Parent = Header, Size = UDim2.new(0.7, 0, 1, 0), Position = UDim2.fromScale(0.02, 0) },
			buttonMaximize = { Parent = Header, Size = UDim2.new(0.06, 0, 0.7, 0), Position = UDim2.new(0.8, 0, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5) },
			buttonClose = { Parent = Header, Size = UDim2.new(0.06, 0, 0.7, 0), Position = UDim2.new(0.92, 0, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5) },
			buttonMinimize = { Parent = Header, Size = UDim2.new(0.06, 0, 0.7, 0), Position = UDim2.new(0.73, 0, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5) }
		},
		Compact = {
			Header = { Parent = Frame, Size = UDim2.new(0.08, 0, 1, 0), Position = UDim2.fromScale(0, 0), AnchorPoint = Vector2.new(0, 0), BackgroundTransparency = Theme.Transparency },
			title = { Parent = Header, Size = UDim2.new(1, 0, 0.1, 0), Position = UDim2.new(0.5, 0, 0.05), AnchorPoint = Vector2.new(0.5, 0) },
			buttonMaximize = { Parent = Frame, Size = UDim2.new(0.07, 0, 0.05, 0), Position = UDim2.new(0.5, 0, 0.85, 0), AnchorPoint = Vector2.new(0.5, 0) },
			buttonClose = { Parent = Frame, Size = UDim2.new(0.07, 0, 0.05, 0), Position = UDim2.new(0.5, 0, 0.92, 0), AnchorPoint = Vector2.new(0.5, 0) },
			buttonMinimize = { Parent = Frame, Size = UDim2.new(0.07, 0, 0.05, 0), Position = UDim2.new(0.5, 0, 0.78, 0), AnchorPoint = Vector2.new(0.5, 0) }
		},
		Minimal = {
			Header = { Parent = Frame, Size = UDim2.fromScale(1, 1), Position = UDim2.fromScale(0, 0), BackgroundTransparency = 1 },
			title = { Parent = Frame, Size = UDim2.new(0.4, 0, 0.08, 0), Position = UDim2.new(0.02, 0, 0.02, 0) },
			buttonMaximize = { Parent = Frame, Size = UDim2.new(0.04, 0, 0.07, 0), Position = UDim2.new(0.9, 0, 0.02, 0), BackgroundTransparency = 1 },
			buttonClose = { Parent = Frame, Size = UDim2.new(0.04, 0, 0.07, 0), Position = UDim2.new(0.95, 0, 0.02, 0), BackgroundTransparency = 1 },
			buttonMinimize = { Parent = Frame, Size = UDim2.new(0.04, 0, 0.07, 0), Position = UDim2.new(0.85, 0, 0.02, 0), BackgroundTransparency = 1 }
		}
	}

	local elementMap = {
		Header = Header,
		title = title,
		buttonMaximize = buttonMaximize,
		buttonClose = buttonClose,
		buttonMinimize = buttonMinimize
	}

	local currentState = nil
	local isTransitioning = false

	local function getOrMakeScaler(element)
		local scaler = element:FindFirstChild("UIScale")
		if not scaler then
			scaler = Instance.new("UIScale")
			scaler.Name = "UIScale"
			scaler.Parent = element
		end
		return scaler
	end

	local function applyStyle(styleData)
		if isTransitioning then return end
		isTransitioning = true

		local exitTweensCompleted = 0
		local elementCount = 0
		for _ in pairs(elementMap) do elementCount += 1 end

		for _, element in pairs(elementMap) do
			local scaler = getOrMakeScaler(element)
			local exitPosition = element.Position + UDim2.fromOffset(0, 50)

			local exitProperties = { Position = exitPosition }
			if element:IsA("Frame") then
				exitProperties.BackgroundTransparency = 1
			else
				exitProperties.TextTransparency = 1
			end

			TweenService:Create(scaler, MOTION_EXIT, {Scale = 0}):Play()
			local exitTween = TweenService:Create(element, MOTION_EXIT, exitProperties)
			exitTween:Play()

			exitTween.Completed:Connect(function()
				exitTweensCompleted += 1

				if exitTweensCompleted == elementCount then
					for name, el in pairs(elementMap) do
						local style = styleData[name] or {}
						el.Parent = style.Parent or Frame
						el.Size = style.Size or el.Size
						el.Position = (style.Position or el.Position) + UDim2.fromOffset(0, -50)
						el.AnchorPoint = style.AnchorPoint or Vector2.new(0, 0)
						local s = getOrMakeScaler(el)
						s.Scale = 0
						if el:IsA("Frame") then el.BackgroundTransparency = 1 else el.TextTransparency = 1 end
					end

					for name, el in pairs(elementMap) do
						local style = styleData[name] or {}
						local scaler = getOrMakeScaler(el)
						local finalProperties = { Position = style.Position or el.Position }

						if el:IsA("Frame") then
							finalProperties.BackgroundTransparency = style.BackgroundTransparency or Theme.Transparency
						else
							finalProperties.TextTransparency = style.TextTransparency or 0
						end

						TweenService:Create(scaler, MOTION_ENTER, {Scale = 1}):Play()
						TweenService:Create(el, MOTION_ENTER, finalProperties):Play()
					end

					task.delay(MOTION_ENTER.Time, function()
						isTransitioning = false
					end)
				end
			end)
		end
	end

	function TabsAndStyles:FrameStyle(option)
		local styleKey
		if type(option) == "number" then
			if option == 1 then styleKey = "Sleek"
			elseif option == 2 then styleKey = "Compact"
			elseif option == 3 then styleKey = "Minimal" end
		elseif type(option) == "string" then
			local lowerOption = option:lower()
			if lowerOption == "sleek" or lowerOption == "one" then styleKey = "Sleek"
			elseif lowerOption == "compact" or lowerOption == "two" then styleKey = "Compact"
			elseif lowerOption == "minimal" or lowerOption == "three" or lowerOption == "there" then styleKey = "Minimal" end
		end

		local selectedStyle = styles[styleKey]
		if selectedStyle and selectedStyle ~= currentState then
			currentState = selectedStyle
			applyStyle(selectedStyle)
		end
	end

	function TabsAndStyles:addTab(name)
		local tabButton = Instance.new("TextButton")
		tabButton.BackgroundColor3 = Theme.ButtonColor
		tabButton.BorderSizePixel = 0
		tabButton.AutoButtonColor = false
		tabButton.Size = UDim2.new(0.8, 0, 0, 35)
		tabButton.Text = name or "Tab"
		tabButton.TextColor3 = Theme.TextColor
		tabButton.TextScaled = true
		tabButton.Parent =  tabContainer
		addCorner(tabButton, Layout.ElementCorner)

		local tabContent = Instance.new("Frame")
		tabContent.Size = UDim2.new(1, 0, 1, 0)
		tabContent.Position = UDim2.new(0, 0, 0, 0)
		tabContent.BackgroundColor3 = Theme.BackgroundColor
		tabContent.BackgroundTransparency = 1
		tabContent.Visible = false
		tabContent.Parent = tabContentScroll
		addCorner(tabContent, UDim.new(0, 8))

		local contentLayout = Instance.new("UIListLayout")
		contentLayout.Parent = tabContent
		contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
		contentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		contentLayout.Padding = UDim.new(0, 5)

		tabs[#tabs + 1] = tabContent
		tabsButtons[#tabsButtons + 1] = tabButton

		if #tabs == 1 then
			tabContent.Visible = true
			currentTab = tabContent
			tabContent.ChildAdded:Connect(function() updateCanvasSize(tabContent) end)
		end

		local underline = Instance.new("Frame")
		underline.Size = UDim2.new(0, 0, 0, 2)
		underline.Position = UDim2.new(0.5, 0, 1, 0)
		underline.AnchorPoint = Vector2.new(0.5, 0)
		underline.BackgroundColor3 = Theme.TabUnderLineColor
		underline.BorderSizePixel = 0
		underline.Parent = tabButton

		tabButton.MouseEnter:Connect(function()
			TweenService:Create(underline, TweenInfo.new(0.2), {Size = UDim2.new(0.8, 0, 0, 2)}):Play()
		end)

		tabButton.MouseLeave:Connect(function()
			TweenService:Create(underline, TweenInfo.new(0.2), {Size = UDim2.new(0, 0, 0, 2)}):Play()
		end)

		tabButton.MouseButton1Click:Connect(function()
			if isAnimating or currentTab == tabContent then return end
			isAnimating = true

			local previous = currentTab
			currentTab = tabContent

			local activeColor = Color3.fromRGB(45, 45, 58)
			local passiveColor = Theme.ButtonColor

			for _, button in ipairs(tabsButtons) do
				local isActive = (button == tabButton)
				TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
					BackgroundColor3 = isActive and activeColor or passiveColor
				}):Play()
			end

			local fromIndex, toIndex
			for i = 1, #tabs do
				if tabs[i] == previous then fromIndex = i end
				if tabs[i] == currentTab then toIndex = i end
			end

			if previous and fromIndex and toIndex and fromIndex ~= toIndex then
				local direction = (toIndex > fromIndex) and 1 or -1
				local offsetStart = UDim2.new(direction, 0, 0, 0)
				local offsetEnd = UDim2.new(-direction, 0, 0, 0)
				local neutral = UDim2.new(0, 0, 0, 0)
				local baseZ = previous.ZIndex

				currentTab.ZIndex = baseZ + (#tabs)
				currentTab.Position = offsetStart
				currentTab.Visible = true

				updateCanvasSize(tabContent)

				TweenService:Create(previous, TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = offsetEnd}):Play()

				local slideIn = TweenService:Create(currentTab, TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = neutral})
				slideIn:Play()

				local middleTabs = {}
				local step = 0

				for i = fromIndex + direction, toIndex - direction, direction do
					local midTab = tabs[i]
					if midTab then
						step += 1
						midTab.Position = offsetStart
						midTab.ZIndex = baseZ + step
						midTab.Visible = true

						task.delay(step * 0.05, function()
							TweenService:Create(midTab, TweenInfo.new(0.35, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {Position = offsetEnd}):Play()
						end)
						table.insert(middleTabs, midTab)
					end
				end

				slideIn.Completed:Connect(function()
					for _, tab in pairs(tabs) do
						if tab ~= currentTab then
							tab.Visible = false
						end
					end
					previous.Visible = false
					previous.Position = neutral
					previous.ZIndex = baseZ
					currentTab.ZIndex = baseZ

					for _, mid in ipairs(middleTabs) do
						mid.Visible = false
						mid.Position = neutral
						mid.ZIndex = baseZ
					end

					isAnimating = false
				end)
			else
				currentTab.Visible = true
				isAnimating = false
			end
		end)

		local MOTION_SLIDE = TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut)
		local MOTION_FOCUS = TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
		local MOTION_EXPAND = TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
		local MOTION_HOVER = TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
		local MOTION_PRESS = TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)

		local function CreateBaseComponent(parent)
			local BaseFrame = Instance.new("Frame")
			BaseFrame.Parent = parent
			BaseFrame.Size = Layout.ButtonSize
			BaseFrame.BackgroundColor3 = Theme.ButtonColor
			BaseFrame.ClipsDescendants = true
			addCorner(BaseFrame, Layout.ElementCorner)

			return BaseFrame
		end

		local function ApplyHoverEffects(hittable, frame)
			hittable.MouseEnter:Connect(function()
				TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), { BackgroundColor3 = Theme.AccentColor }):Play()
			end)
			hittable.MouseLeave:Connect(function()
				TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), { BackgroundColor3 = Theme.ButtonColor }):Play()
			end)
		end

		local function ManageInfoIcon(parentFrame, infoText)
			local handler = {}
			local connection = nil

			local Icon = Instance.new("ImageButton")
			Icon.Name = "InfoIcon"
			Icon.Parent = parentFrame
			Icon.BackgroundTransparency = 1
			Icon.Position = Components.Image.InfoImagePOS
			Icon.Size = Components.Image.ImageSize
			Icon.Image = "http://www.roblox.com/asset/?id=6026568210"
			Icon.ImageColor3 = Theme.TextColor
			Icon.Visible = false
			Icon.AutoButtonColor = false
			Icon.ZIndex = 4

			local hasInfo = infoText and infoText ~= ""
			Icon.Visible = hasInfo

			if hasInfo then
				connection = Icon.MouseButton1Click:Connect(function()
					ShowInfo(infoText)
				end)
			end

			function handler:Update(infoText)
				if connection then
					connection:Disconnect()
					connection = nil
				end

				local hasInfo = typeof(infoText) == "string" and infoText ~= ""
				Icon.Visible = hasInfo

				if hasInfo then
					connection = Icon.MouseButton1Click:Connect(function()
						ShowInfo(infoText)
					end)
				end
				return hasInfo
			end

			function handler:Destroy()
				if connection then connection:Disconnect() end
				Icon:Destroy()
			end

			handler.Instance = Icon
			return handler
		end

		local function CreateStyledButton(parent, name, Info, callback)
			local ButtonAPI = {}
			local Info = Info or ""
			local callback = callback or function() end

			local ButtonFrame = CreateBaseComponent(parent)

			local TextLabel = Instance.new("TextLabel")
			TextLabel.Name = "ButtonText"
			TextLabel.Parent = ButtonFrame
			TextLabel.BackgroundTransparency = 1
			TextLabel.Size = UDim2.new(1, 0, 1, 0)
			TextLabel.Text = name or "Button"
			TextLabel.TextColor3 = Theme.TextColor
			TextLabel.TextScaled = true
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel.ZIndex = 2

			local infoHandler = ManageInfoIcon(ButtonFrame, Info)
			local Hitbox = Instance.new("TextButton")
			Hitbox.Name = "Hitbox"
			Hitbox.Parent = ButtonFrame
			Hitbox.Size = UDim2.fromScale(1, 1)
			Hitbox.BackgroundTransparency = 1
			Hitbox.Text = ""
			Hitbox.ZIndex = 3

			if Info and Info ~= "" then
				TextLabel.Size = Components.TextSize.WithIcon
			end

			local mainConnection

			function ButtonAPI:updatename(newname)
				TextLabel.Text = newname or TextLabel.Text
			end

			function ButtonAPI:updateinfo(newinfo)
				infoHandler:Update(newinfo or Info)
			end

			function ButtonAPI:updatecallback(newCallback)
				if mainConnection then mainConnection:Disconnect() end
				callback = newCallback or callback
				mainConnection = Hitbox.MouseButton1Click:Connect(function()
					if Notifications then akdo:ShowNotification("Button Clicked!") end
					if callback then callback() end
				end)
			end

			function ButtonAPI:update(newName, newInfo, newCallback)
				TextLabel.Text = newName or TextLabel.Text
				infoHandler:Update(newInfo)
				ButtonAPI:updatecallback(newCallback)
			end

			function ButtonAPI:destroy()
				if mainConnection then mainConnection:Disconnect() end
				infoHandler:Destroy()
				ButtonFrame:Destroy()
			end

			ApplyHoverEffects(Hitbox, ButtonFrame)

			ButtonAPI:update(name, Info, callback)
			return ButtonAPI
		end

		local function addAllMatrials(table, parent)
			function table:addButton(name, Info, callback)
				CreateStyledButton(parent, name, Info, callback)
			end

			function table:addToggle(name, Info, callback, Icon, style)
				local ToggleAPI = {}
				local toggled = false

				local currentName = name or "Toggle"
				local currentInfo = Info or ""
				local currentCallback = callback or function() end
				local currentIcon = Icon or false
				local currentStyle = style

				local ToggleFrame = CreateBaseComponent(parent)
				local ToggleTextButton = Instance.new("TextButton")
				local infoHandler = ManageInfoIcon(ToggleFrame, currentInfo)

				local ToggleContainerFrame = Instance.new("Frame")
				local RoundedFrameToggle = Instance.new("Frame")
				local HitBox = Instance.new("TextButton")
				local stroke = addStroke(ToggleContainerFrame, 1.5, Color3.fromRGB(0, 255, 0))

				local ToggleButtonImageButton = Instance.new("ImageButton")

				ToggleTextButton.Parent = ToggleFrame
				ToggleTextButton.BackgroundTransparency = 1
				ToggleTextButton.Size = Components.TextSize.WithTwoIcons
				ToggleTextButton.Text = currentName
				ToggleTextButton.TextColor3 = Theme.TextColor
				ToggleTextButton.TextScaled = true
				ToggleTextButton.TextXAlignment = Enum.TextXAlignment.Left

				local function updateVisuals()
					if currentIcon and typeof(currentIcon) == "string" or typeof(currentIcon) == "number" then
						ToggleContainerFrame.Visible = false
						ToggleButtonImageButton.Visible = true
						if Components.Toggle[currentIcon] then
							ToggleButtonImageButton.Image = toggled and Components.Toggle[currentIcon].On or Components.Toggle[currentIcon].Off
						end

						if currentInfo and currentInfo ~= "" then
							ToggleFrame.Size = UDim2.new(0.7, 0, 1, 0)
							ToggleButtonImageButton.Position = UDim2.new(0.7, 0, 0, 0)
						else
							ToggleFrame.Size = Components.TextSize.WithTwoIcons
						end
					else
						ToggleContainerFrame.Visible = true
						ToggleButtonImageButton.Visible = false

						local targetPosition = toggled and UDim2.new(0.5, 0, 0.1, 0) or UDim2.new(0.055, 0, 0.1, 0)
						local targetContainerColor = toggled and Theme.ToggleOnColor or Theme.AccentColor
						local targetStrokeColor = toggled and Color3.fromRGB(0, 121, 0) or Color3.fromRGB(0, 255, 0)

						RoundedFrameToggle:TweenPosition(targetPosition, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.25, true)
						TweenService:Create(ToggleContainerFrame, TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), { BackgroundColor3 = targetContainerColor }):Play()
						TweenService:Create(stroke, TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), { Color = targetStrokeColor }):Play()
					end
				end

				local function handleToggle()
					toggled = not toggled
					if currentCallback then
						currentCallback(toggled)
					end
					updateVisuals()
				end

				function ToggleAPI:NewName(newName)
					currentName = newName or currentName
					ToggleTextButton.Text = currentName
				end

				function ToggleAPI:newInfo(newInfo)
					currentInfo = newInfo or ""
					infoHandler:Update(currentInfo)
					updateVisuals()
				end

				function ToggleAPI:newcallback(newCallback)
					currentCallback = newCallback or function() end
				end

				function ToggleAPI:newIcon(newIcon)
					currentIcon = newIcon
					updateVisuals()
				end

				function ToggleAPI:newStyle(newStyle)
					currentStyle = newStyle
					local cornerRadius = (currentStyle and UDim.new(0.3, 0)) or UDim.new(1, 0)
					if ToggleContainerFrame.Parent and RoundedFrameToggle.Parent then
						addCorner(ToggleContainerFrame, cornerRadius)
						addCorner(RoundedFrameToggle, cornerRadius)
					end
				end

				function ToggleAPI:update(newName, newInfo, newCallback, newIcon, newStyle)
					ToggleAPI:NewName(newName)
					ToggleAPI:newInfo(newInfo)
					ToggleAPI:newcallback(newCallback)
					ToggleAPI:newIcon(newIcon)
					ToggleAPI:newStyle(newStyle)
				end

				function ToggleAPI:destroy()
					infoHandler:Destroy()
					ToggleFrame:Destroy()
				end

				ToggleContainerFrame.Parent = ToggleFrame
				ToggleContainerFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				ToggleContainerFrame.Position = UDim2.new(0.83, 0, 0.1, 0)
				ToggleContainerFrame.Size = UDim2.new(0.15, 0, 0.8, 0)

				RoundedFrameToggle.Parent = ToggleContainerFrame
				RoundedFrameToggle.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
				RoundedFrameToggle.Position = UDim2.new(0.055, 0, 0.1, 0)
				RoundedFrameToggle.Size = UDim2.new(0.4, 0, 0.8, 0)

				HitBox.Parent = ToggleContainerFrame
				HitBox.BackgroundTransparency = 1
				HitBox.Size = UDim2.new(1, 0, 1, 0)
				HitBox.Text = ""
				HitBox.ZIndex = 2

				ToggleButtonImageButton.Name = "imageButton"
				ToggleButtonImageButton.Parent = ToggleFrame
				ToggleButtonImageButton.BackgroundTransparency = 1
				ToggleButtonImageButton.Position = UDim2.new(0.8, 0, 0, 0)
				ToggleButtonImageButton.Size = UDim2.new(0.2, 0, 1, 0)
				ToggleButtonImageButton.ImageColor3 = Theme.TextColor

				ToggleTextButton.MouseButton1Click:Connect(handleToggle)
				HitBox.MouseButton1Click:Connect(handleToggle)
				ToggleButtonImageButton.MouseButton1Click:Connect(handleToggle)

				ApplyHoverEffects(ToggleTextButton, ToggleFrame)

				ToggleAPI:update(currentName, currentInfo, currentCallback, currentIcon, currentStyle)

				return ToggleAPI
			end

			function table:addDropdown(name, Info, items, itemsPerRow, callback)
				local DropdownAPI = {}
				local UserInputService = game:GetService("UserInputService")
				local TweenService = game:GetService("TweenService")

				local selectedItem = nil
				local isExpanded = false

				items = (type(items) == "table" and items) or {}
				itemsPerRow = (type(itemsPerRow) == "number" and itemsPerRow > 0) and itemsPerRow or 1
				callback = callback or function() end

				local MOTION_HOVER = TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
				local MOTION_PRESS = TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
				local MOTION_EXPAND_OPEN = TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
				local MOTION_EXPAND_CLOSE = TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)

				local DropdownFrame = Instance.new("Frame")
				local DropdownButton = Instance.new("TextButton")
				local DropdownImageButton = Instance.new("ImageButton")
				local DropdownList = Instance.new("ScrollingFrame")
				local UIGridLayout = Instance.new("UIGridLayout")

				DropdownFrame.Parent = parent
				DropdownFrame.BackgroundColor3 = Theme.ButtonColor
				DropdownFrame.Size = Layout.ButtonSize
				addCorner(DropdownFrame, Layout.ElementCorner)

				DropdownButton.Parent = DropdownFrame
				DropdownButton.BackgroundTransparency = 1
				DropdownButton.Size = Components.TextSize.WithIcon
				DropdownButton.Text = name or "Dropdown"
				DropdownButton.TextColor3 = Theme.TextColor
				DropdownButton.TextScaled = true
				DropdownButton.TextXAlignment = Enum.TextXAlignment.Left

				DropdownImageButton.Parent = DropdownFrame
				DropdownImageButton.BackgroundTransparency = 1
				DropdownImageButton.Position = UDim2.new(0.9, 0, 0, 0)
				DropdownImageButton.Size = UDim2.new(0.1, 0, 1, 0)
				DropdownImageButton.Image = "http://www.roblox.com/asset/?id=6031090994"
				DropdownImageButton.ImageColor3 = Theme.TextColor

				DropdownList.Parent = parent
				DropdownList.BackgroundColor3 = Theme.BackgroundColor
				DropdownList.Position = UDim2.new(0, 0, 1, 0)
				DropdownList.Size = UDim2.new(0.95, 0, 0, 0)
				DropdownList.ScrollingDirection = Enum.ScrollingDirection.Y
				DropdownList.Visible = false
				DropdownList.ScrollBarThickness = 3
				addCorner(DropdownList, Layout.ElementCorner)

				UIGridLayout.Parent = DropdownList
				UIGridLayout.CellSize = UDim2.new(1 / itemsPerRow, -10, 0, 30)
				UIGridLayout.CellPadding = UDim2.new(0, 5, 0, 5)
				UIGridLayout.FillDirection = Enum.FillDirection.Horizontal

				local function updateButtonText()
					if selectedItem then
						DropdownButton.Text = name .. ": " .. tostring(selectedItem)
					else
						DropdownButton.Text = name
					end
				end

				local function createItems()
					for _, child in ipairs(DropdownList:GetChildren()) do
						if child:IsA("TextButton") then child:Destroy() end
					end

					for _, itemText in pairs(items) do
						local ItemButton = Instance.new("TextButton")
						ItemButton.Parent = DropdownList
						ItemButton.BackgroundColor3 = Theme.ButtonColor
						ItemButton.Text = tostring(itemText)
						ItemButton.Size = UDim2.new(1, 0, 0, 30)
						ItemButton.TextColor3 = Theme.TextColor
						ItemButton.TextScaled = true
						ItemButton.BackgroundTransparency = 1
						ItemButton.TextTransparency = 1
						addCorner(ItemButton, Layout.ElementCorner)

						ItemButton.MouseButton1Click:Connect(function()
							selectedItem = itemText
							updateButtonText()
							callback(itemText)
							DropdownAPI.ToggleDropdown(false)
						end)
					end
				end

				function DropdownAPI:ToggleDropdown(forceState)
					local shouldBeVisible = if forceState ~= nil then forceState else not isExpanded
					if shouldBeVisible == isExpanded then return end

					isExpanded = shouldBeVisible

					if isExpanded then
						local numRows = math.ceil(#items / itemsPerRow)
						local itemHeight = 35
						local newHeight = numRows * itemHeight
						local maxHeight = 100
						local finalHeight = math.min(newHeight, maxHeight)
						DropdownList.CanvasSize = UDim2.new(1, 0, 0, newHeight)
						DropdownList.Visible = true
						TweenService:Create(DropdownImageButton, MOTION_EXPAND_OPEN, {Rotation = 90}):Play()
						TweenService:Create(DropdownList, MOTION_EXPAND_OPEN, {Size = UDim2.new(DropdownFrame.Size.X.Scale, 0, 0, finalHeight)}):Play()

						for i, child in ipairs(DropdownList:GetChildren()) do
							if child:IsA("TextButton") then
								task.delay(0.1 + (i * 0.03), function()
									if isExpanded then
										TweenService:Create(child, MOTION_HOVER, {BackgroundTransparency = 0.8, TextTransparency = 0}):Play()
									end
								end)
							end
						end
					else
						TweenService:Create(DropdownImageButton, MOTION_EXPAND_CLOSE, {Rotation = 0}):Play()
						for _, child in ipairs(DropdownList:GetChildren()) do
							if child:IsA("TextButton") then
								TweenService:Create(child, MOTION_PRESS, {BackgroundTransparency = 1, TextTransparency = 1}):Play()
							end
						end
						local closeTween = TweenService:Create(DropdownList, MOTION_EXPAND_CLOSE, {Size = UDim2.new(DropdownFrame.Size.X.Scale, 0, 0, 0)})
						closeTween.Completed:Connect(function()
							if not isExpanded then
								DropdownList.Visible = false
							end
						end)
						closeTween:Play()
					end
				end

				DropdownImageButton.MouseButton1Click:Connect(function() DropdownAPI.ToggleDropdown() end)
				DropdownButton.MouseButton1Click:Connect(function() DropdownAPI.ToggleDropdown() end)

				if Info and Info ~= "" then
					DropdownImageButton.Position = UDim2.new(0.8, 0, 0, 0)
					DropdownButton.Size = Components.TextSize.WithTwoIcons

					local InfoImage = Instance.new("ImageButton")
					InfoImage.Parent = DropdownFrame
					InfoImage.BackgroundTransparency = 1
					InfoImage.Position = Components.Image.InfoImagePOS
					InfoImage.Size = Components.Image.ImageSize
					InfoImage.Image = "http://www.roblox.com/asset/?id=6026568210"
					InfoImage.ImageColor3 = Theme.TextColor
					InfoImage.ZIndex = 2
					InfoImage.MouseButton1Click:Connect(function()
						TextInfo.Text = Info
						if InfoFrame.Size.Y.Scale ~= 0.148 then
							InfoFrame.Visible = true
							local tweenSize = TweenService:Create(InfoFrame, MOTION_EXPAND_OPEN, {Size = UDim2.new(0.7133, 0, 0.148, 0)})
							tweenSize:Play()
						end
					end)
				end

				function DropdownAPI:newName(newName)
					name = newName or name
					updateButtonText()
				end

				function DropdownAPI:addItem(itemToAdd)
					if itemToAdd == nil then return end
					table.insert(items, itemToAdd)
					createItems()
				end

				function DropdownAPI:removeItem(itemToRemove)
					if itemToRemove == nil then return end
					local index = table.find(items, itemToRemove)
					if index then
						table.remove(items, index)
						if selectedItem == itemToRemove then
							selectedItem = nil
							updateButtonText()
						end
						createItems()
					end
				end

				function DropdownAPI:setItems(newItems)
					if type(newItems) == "table" then
						items = newItems
						if selectedItem and not table.find(items, selectedItem) then
							selectedItem = nil
							updateButtonText()
						end
						createItems()
					end
				end

				function DropdownAPI:newCallback(newCallback)
					callback = newCallback or function() end
				end

				function DropdownAPI:update(newName, newItems, newCallback)
					self:newName(newName)
					self:setItems(newItems)
					self:newCallback(newCallback)
				end

				function DropdownAPI:updateDropdown(newName, newInfo, newItems, newItemsPerRow, newCallback)
					self:update(newName, newInfo, newItems, newCallback)
					if type(newItemsPerRow) == "number" and newItemsPerRow > 0 then 
						itemsPerRow = newItemsPerRow
						UIGridLayout.CellSize = UDim2.new(1 / itemsPerRow, -10, 0, 30)
					end
					createItems()
				end

				function DropdownAPI:getSelected() return selectedItem end

				function DropdownAPI:setSelected(itemToSelect, silent)
					if table.find(items, itemToSelect) then
						selectedItem = itemToSelect
						updateButtonText()
						if not silent then callback(itemToSelect) end
					end
				end

				local clickOutsideConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
					if gameProcessed or not isExpanded then return end
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						local mouseLocation = UserInputService:GetMouseLocation()
						local clickedOnSelf = false
						if not clickedOnSelf then
							DropdownAPI.ToggleDropdown(false)
						end
					end
				end)

				function DropdownAPI:destroy()
					if clickOutsideConnection then
						clickOutsideConnection:Disconnect()
						clickOutsideConnection = nil
					end
					DropdownFrame:Destroy()
					DropdownList:Destroy()
				end

				updateButtonText()
				createItems()

				return DropdownAPI
			end

			function table:addSlider(name, Info, BeginValue, Min, Max, callback, GetMode, TextBoxDisable)
				local SliderAPI = {}
				callback = callback or function() end
				BeginValue = type(BeginValue) == "number" and BeginValue or 100
				Min = type(Min) == "number" and Min or 0
				Max = type(Max) == "number" and Max or 200
				if Max <= Min then Max = Min + 1 end
				local currentValue = BeginValue
				local MOTION_SLIDE = TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)

				local STFrame = CreateBaseComponent(parent)

				local TextLabel = Instance.new("TextLabel")
				TextLabel.Name = "Text"
				TextLabel.Parent = STFrame
				TextLabel.BackgroundTransparency = 1
				TextLabel.Font = Enum.Font.Gotham
				TextLabel.Text = name or "Slider"
				TextLabel.TextColor3 = Theme.TextColor
				TextLabel.TextScaled = true
				TextLabel.TextXAlignment = Enum.TextXAlignment.Left
				TextLabel.ZIndex = 2

				local TextBox = Instance.new("TextBox")
				TextBox.Name = "Input"
				TextBox.Parent = STFrame
				TextBox.BackgroundTransparency = 1
				TextBox.PlaceholderColor3 = Theme.TextColor
				TextBox.Text = tostring(math.floor(BeginValue))
				TextBox.TextColor3 = Theme.TextColor
				TextBox.Font = Enum.Font.Gotham
				TextBox.TextScaled = true
				TextBox.ZIndex = 2
				addCorner(TextBox, UDim.new(0.15, 0))

				local SliderTrack = Instance.new("Frame")
				SliderTrack.Name = "SliderTrack"
				SliderTrack.Parent = STFrame
				SliderTrack.BackgroundColor3 = Theme.BackgroundColor
				addCorner(SliderTrack, UDim.new(0.5, 0))

				local FillSlider = Instance.new("Frame")
				FillSlider.Parent = SliderTrack
				FillSlider.BackgroundColor3 = Theme.TextColor
				addCorner(FillSlider, UDim.new(1,0))

				local Trigger = Instance.new("TextButton")
				Trigger.Name = "Trigger"
				Trigger.Parent = SliderTrack
				Trigger.BackgroundTransparency = 1
				Trigger.Size = UDim2.fromScale(1, 1)
				Trigger.Text = ""
				Trigger.ZIndex = 3

				local infoHandler = ManageInfoIcon(STFrame)
				local function updateSliderVisuals(value)
					local output = math.clamp((value - Min) / (Max - Min), 0, 1)
					TweenService:Create(FillSlider, MOTION_SLIDE, {Size = UDim2.new(output, 0, 1, 0)}):Play()
					if tostring(math.floor(value)) ~= TextBox.Text then
						TextBox.Text = tostring(math.floor(value))
					end
					currentValue = value
				end
				function SliderAPI:setValue(newValue, silent)
					local numValue = math.clamp(newValue, Min, Max)
					updateSliderVisuals(numValue)
					if not silent then callback(numValue) end
				end
				function SliderAPI:getValue() return currentValue end
				function SliderAPI:update(newName, newInfo, newMin, newMax, newCallback)
					name = newName or name
					Min = newMin or Min
					Max = newMax or Max
					callback = newCallback or callback
					TextLabel.Text = name
					if Max <= Min then Max = Min + 1 end
					infoHandler:Update(newInfo, ShowInfo)
					SliderAPI:setValue(SliderAPI:getValue(), true)
				end
				function SliderAPI:destroy()
					infoHandler:Destroy()
					STFrame:Destroy()
				end
				local isDragging = false
				Trigger.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						isDragging = true
						task.spawn(function()
							while isDragging do
								local sliderPosX = Trigger.AbsolutePosition.X
								local sliderSizeX = Trigger.AbsoluteSize.X
								local output = math.clamp((UserInputService:GetMouseLocation().X - sliderPosX) / sliderSizeX, 0, 1)
								local value = output * (Max - Min) + Min
								updateSliderVisuals(value)
								callback(value)
								task.wait()
							end
						end)
					end
				end)
				UserInputService.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						isDragging = false
					end
				end)
				local function processTextInput()
					local sanitizedText = TextBox.Text:gsub("%D", "")
					local numValue = tonumber(sanitizedText) or Min
					SliderAPI:setValue(numValue, false)
				end
				if GetMode then
					TextBox:GetPropertyChangedSignal("Text"):Connect(function()
						if not TextBox:IsFocused() then return end
						local sanitizedText = TextBox.Text:gsub("%D", "")
						if sanitizedText ~= TextBox.Text then TextBox.Text = sanitizedText end
						local numValue = tonumber(sanitizedText) or Min
						local clampedValue = math.clamp(numValue, Min, Max)
						updateSliderVisuals(clampedValue)
						callback(clampedValue)
					end)
				else
					TextBox.FocusLost:Connect(processTextInput)
				end
				local function updateLayout(hasInfo)
					if hasInfo then
						TextLabel.Size = UDim2.new(0.5, 0, 1, 0)
						TextBox.Position = UDim2.new(0.875, 0, 0.5, 0)
						TextBox.Size = UDim2.new(0.125, 0, 0.7, 0)
						TextBox.AnchorPoint = Vector2.new(0.5, 0.5)
						SliderTrack.Position = UDim2.new(0.5, 0, 0.5, 0)
						SliderTrack.Size = UDim2.new(0.3, 0, 0.45, 0)
						SliderTrack.AnchorPoint = Vector2.new(1, 0.5)
					else
						TextLabel.Size = UDim2.new(0.4, 0, 1, 0)
						TextBox.Position = UDim2.new(0.42, 0, 0.5, 0)
						TextBox.Size = UDim2.new(0.125, 0, 0.7, 0)
						TextBox.AnchorPoint = Vector2.new(0, 0.5)
						SliderTrack.Position = UDim2.new(0.55, 0, 0.5, 0)
						SliderTrack.Size = UDim2.new(0.42, 0, 0.45, 0)
						SliderTrack.AnchorPoint = Vector2.new(0, 0.5)
					end
				end
				local hasInfo = infoHandler:Update(Info, ShowInfo)
				updateLayout(hasInfo)
				updateSliderVisuals(BeginValue)
				return SliderAPI
			end

			function table:addTextBox(name, Info, placeholderText, callback, stat, onlyNumbers, onlyLetters)
				local TextBoxAPI = {}
				name = name or "TextBox"
				Info = Info or ""
				placeholderText = typeof(placeholderText) == "string" and placeholderText or ""
				callback = callback or function() end
				stat = stat or false

				local TextBoxFrame = CreateBaseComponent(parent)

				local FloatingLabel = Instance.new("TextLabel")
				FloatingLabel.Parent = TextBoxFrame
				FloatingLabel.BackgroundTransparency = 1
				FloatingLabel.Size = UDim2.new(0.813, 0, 1, 0)
				FloatingLabel.Text = name
				FloatingLabel.TextColor3 = Theme.TextColor
				FloatingLabel.TextScaled = true
				FloatingLabel.TextXAlignment = Enum.TextXAlignment.Left
				FloatingLabel.ZIndex = 3

				local TextBox = Instance.new("TextBox")
				TextBox.Name = "Input"
				TextBox.Parent = TextBoxFrame
				TextBox.BackgroundColor3 = Theme.AccentColor
				TextBox.Size = UDim2.new(0.15, 0, 0.8, 0)
				TextBox.Position = UDim2.new(0.83, 0, 0.1, 0)
				TextBox.PlaceholderText = placeholderText
				TextBox.PlaceholderColor3 = Theme.TextColor
				TextBox.Text = ""
				TextBox.TextColor3 = Theme.TextColor
				TextBox.Font = Enum.Font.Gotham
				TextBox.TextScaled = true
				TextBox.ClearTextOnFocus = false
				TextBox.ZIndex = 2
				addCorner(TextBox, UDim.new(0.15,0))
				local Stroke = addStroke(TextBox, 1.5, Theme.BackgroundColor)

				local infoHandler = ManageInfoIcon(TextBoxFrame, Info)

				if stat then
					TextBox:GetPropertyChangedSignal("Text"):Connect(function()
						if onlyLetters and TextBox.Text:match("%d") then
							TextBox.Text = ""
						elseif onlyNumbers and TextBox.Text:match("%D") then
							TextBox.Text = ""
						else
							callback(TextBox.Text)
						end
					end)
				else
					TextBox.FocusLost:Connect(function()
						if onlyLetters and TextBox.Text:match("%d") then
							TextBox.Text = ""
						elseif onlyNumbers and TextBox.Text:match("%D") then
							TextBox.Text = ""
						else
							callback(TextBox.Text)
						end
					end)
				end

				if Info and Info ~= "" then
					FloatingLabel.Size = UDim2.new(0.713, 0, 1, 0)
					TextBox.Position = UDim2.new(0.73, 0, 0.1, 0)
				end

				function TextBoxAPI:setText(text, silent)
					TextBox.Text = text or ""
					callback(TextBox.Text)
				end

				function TextBoxAPI:destroy()
					TextBoxFrame:Destroy()
				end

				return TextBoxAPI
			end

			function table:addSB(name, buttonText, beginValue, min, max, sliderCallback, buttonCallback, getMode, textBoxDisable)
				local SliderButtonAPI = {}
				local updateSliderVisuals, processTextInput
				local isDragging = false
				local currentValue
				local MOTION_SLIDE = TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)

				name = name or "SliderButton"
				sliderCallback = sliderCallback or function() end
				buttonCallback = buttonCallback or function() end
				buttonText = buttonText or "Action"
				beginValue = type(beginValue) == "number" and beginValue or 100
				min = type(min) == "number" and min or 0
				max = type(max) == "number" and max or 200
				if max <= min then max = min + 1 end
				currentValue = beginValue

				local STFrame = CreateBaseComponent(parent)

				local TextLabel = Instance.new("TextLabel")
				TextLabel.Name = "Text"
				TextLabel.Parent = STFrame
				TextLabel.BackgroundTransparency = 1
				TextLabel.Font = Enum.Font.Gotham
				TextLabel.Text = name
				TextLabel.TextColor3 = Theme.TextColor
				TextLabel.TextScaled = true
				TextLabel.TextXAlignment = Enum.TextXAlignment.Left
				TextLabel.ZIndex = 2
				TextLabel.Size = UDim2.new(0.3, 0, 1, 0)
				TextLabel.Position = UDim2.new(0, 0, 0, 0)

				local SliderTrack = Instance.new("Frame")
				SliderTrack.Name = "SliderTrack"
				SliderTrack.Parent = STFrame
				SliderTrack.BackgroundColor3 = Theme.AccentColor
				SliderTrack.Size = UDim2.new(0.3, 0, 0.35, 0)
				SliderTrack.Position = UDim2.new(0.42, 0, 0.225, 0)
				addCorner(SliderTrack, UDim.new(0.5, 0))

				local FillSlider = Instance.new("Frame")
				FillSlider.Parent = SliderTrack
				FillSlider.BackgroundColor3 = Theme.TextColor
				addCorner(FillSlider, UDim.new(1,0))

				local Trigger = Instance.new("TextButton")
				Trigger.Name = "Trigger"
				Trigger.Parent = SliderTrack
				Trigger.BackgroundTransparency = 1
				Trigger.Size = UDim2.fromScale(1, 1)
				Trigger.Text = ""
				Trigger.ZIndex = 3

				local TextBox = Instance.new("TextBox")
				TextBox.Name = "Input"
				TextBox.Parent = STFrame
				TextBox.BackgroundTransparency = 1
				TextBox.PlaceholderColor3 = Theme.TextColor
				TextBox.Text = tostring(math.floor(beginValue))
				TextBox.TextColor3 = Theme.TextColor
				TextBox.Font = Enum.Font.Gotham
				TextBox.TextScaled = true
				TextBox.ZIndex = 2
				TextBox.ClearTextOnFocus = false
				TextBox.Size = UDim2.new(0.125, 0, 0.8, 0)
				TextBox.Position = UDim2.new(0.3, 0, 0.1, 0)
				addCorner(TextBox, UDim.new(0.15, 0))

				local ActionButton = Instance.new("TextButton")
				ActionButton.Name = "ActionButton"
				ActionButton.Parent = STFrame
				ActionButton.BackgroundColor3 = Theme.AccentColor
				ActionButton.TextColor3 = Theme.TextColor
				ActionButton.Text = buttonText
				ActionButton.Font = Enum.Font.Gotham
				ActionButton.TextScaled = true
				ActionButton.ZIndex = 2
				ActionButton.Size = UDim2.new(0.15, 0, 0.8, 0)
				ActionButton.Position = UDim2.new(0.8, 0, 0.1, 0)
				addCorner(ActionButton, UDim.new(0.15, 0))

				updateSliderVisuals = function(value)
					local output = math.clamp((value - min) / (max - min), 0, 1)
					TweenService:Create(FillSlider, MOTION_SLIDE, {Size = UDim2.new(output, 0, 1, 0)}):Play()
					if tostring(math.floor(value)) ~= TextBox.Text then
						TextBox.Text = tostring(math.floor(value))
					end
					currentValue = value
				end

				processTextInput = function()
					local sanitizedText = TextBox.Text:gsub("%D", "")
					local numValue = tonumber(sanitizedText) or min
					SliderButtonAPI:setValue(numValue, false)
				end

				function SliderButtonAPI:setValue(newValue, silent)
					local numValue = math.clamp(newValue, min, max)
					updateSliderVisuals(numValue)
					if not silent then sliderCallback(numValue) end
				end
				function SliderButtonAPI:getValue() return currentValue end
				function SliderButtonAPI:update(newOptions)
					newOptions = newOptions or {}
					name = newOptions.name or name
					min = newOptions.min or min
					max = newOptions.max or max
					buttonText = newOptions.buttonText or buttonText
					TextLabel.Text = name
					ActionButton.Text = buttonText
					if max <= min then max = min + 1 end
					SliderButtonAPI:setValue(SliderButtonAPI:getValue(), true)
				end
				function SliderButtonAPI:destroy()
					STFrame:Destroy()
				end

				Trigger.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						isDragging = true
						task.spawn(function()
							while isDragging do
								local sliderPosX = Trigger.AbsolutePosition.X
								local sliderSizeX = Trigger.AbsoluteSize.X
								local output = math.clamp((UserInputService:GetMouseLocation().X - sliderPosX) / sliderSizeX, 0, 1)
								local value = output * (max - min) + min
								updateSliderVisuals(value)
								sliderCallback(value)
								task.wait()
							end
						end)
					end
				end)
				UserInputService.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						isDragging = false
					end
				end)

				if getMode then
					TextBox:GetPropertyChangedSignal("Text"):Connect(function()
						if not TextBox:IsFocused() then return end
						local sanitizedText = TextBox.Text:gsub("%D", "")
						if sanitizedText ~= TextBox.Text then TextBox.Text = sanitizedText end
						local numValue = tonumber(sanitizedText) or min
						local clampedValue = math.clamp(numValue, min, max)
						updateSliderVisuals(clampedValue)
						sliderCallback(clampedValue)
					end)
				else
					TextBox.FocusLost:Connect(processTextInput)
				end

				ActionButton.MouseButton1Click:Connect(buttonCallback)

				updateSliderVisuals(beginValue)

				return SliderButtonAPI
			end

			function table:addDT(name, items, itemsPerRow, callback)
				local DropdownAPI = {}
				name = name or "Dropdown"
				items = items or {}
				itemsPerRow = itemsPerRow or 1
				callback = callback or function() end
				local toggled = false
				local selectedItem = nil
				local listVisible = false

				local DTFrame = CreateBaseComponent(parent)
				local Stroke = DTFrame:FindFirstChildOfClass("UIStroke")
				local ScaleController = Instance.new("UIScale")
				ScaleController.Parent = DTFrame

				local DropdownButton = Instance.new("TextButton")
				DropdownButton.Parent = DTFrame
				DropdownButton.BackgroundTransparency = 1
				DropdownButton.Size = Components.TextSize.WithTwoIcons
				DropdownButton.Text = name
				DropdownButton.TextColor3 = Theme.TextColor
				DropdownButton.Font = Enum.Font.Gotham
				DropdownButton.TextScaled = true
				DropdownButton.TextXAlignment = Enum.TextXAlignment.Left
				DropdownButton.ZIndex = 2

				local DropdownImage = Instance.new("ImageButton")
				DropdownImage.Parent = DTFrame
				DropdownImage.BackgroundTransparency = 1
				DropdownImage.Position = UDim2.new(0.9, 0, 0, 0)
				DropdownImage.Size = UDim2.new(0.1, 0, 1, 0)
				DropdownImage.Image = "http://www.roblox.com/asset/?id=6031090994"
				DropdownImage.ImageColor3 = Theme.TextColor
				DropdownImage.ZIndex = 2

				local ToggleButton = Instance.new("ImageButton")
				ToggleButton.Parent = DTFrame
				ToggleButton.BackgroundTransparency = 1
				ToggleButton.Position = UDim2.new(0.8, 0, 0, 0)
				ToggleButton.Size = UDim2.new(0.1, 0, 1, 0)
				ToggleButton.Image = "http://www.roblox.com/asset/?id=6031068433"
				ToggleButton.ImageColor3 = Theme.TextColor
				ToggleButton.ZIndex = 2

				local DropdownList = Instance.new("ScrollingFrame")
				DropdownList.Parent = DTFrame.Parent
				DropdownList.BackgroundColor3 = Theme.BackgroundColor
				DropdownList.BorderSizePixel = 0
				DropdownList.Size = UDim2.new(DTFrame.Size.X.Scale, 0, 0, 0)
				DropdownList.Visible = false
				DropdownList.ScrollingDirection = Enum.ScrollingDirection.Y
				DropdownList.ScrollBarThickness = 4
				DropdownList.ZIndex = 10
				addCorner(DropdownList, Layout.ElementCorner)
				addStroke(DropdownList, 1.5, Theme.AccentColor)

				DTFrame:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
					DropdownList.Position = UDim2.fromOffset(DTFrame.AbsolutePosition.X, DTFrame.AbsolutePosition.Y + DTFrame.AbsoluteSize.Y + 5)
				end)
				local UIGridLayout = Instance.new("UIGridLayout")
				UIGridLayout.FillDirection = Enum.FillDirection.Horizontal
				UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIGridLayout.Parent = DropdownList
				local function toggleListVisibility(forceState)
					local shouldBeVisible = forceState ~= nil and forceState or not listVisible
					if shouldBeVisible == listVisible then return end
					listVisible = shouldBeVisible
					if listVisible then
						local numRows = math.ceil(#items / itemsPerRow)
						local newHeight = (numRows * 35) + ((numRows - 1) * 5)
						local finalHeight = math.min(newHeight, 140)
						DropdownList.CanvasSize = UDim2.new(0, 0, 0, newHeight)
						DropdownList.Visible = true
						TweenService:Create(DropdownImage, MOTION_EXPAND, {Rotation = 90}):Play()
						TweenService:Create(DropdownList, MOTION_EXPAND, {Size = UDim2.new(DTFrame.Size.X.Scale, 0, 0, finalHeight)}):Play()
					else
						TweenService:Create(DropdownImage, MOTION_EXPAND, {Rotation = 0}):Play()
						local closeTween = TweenService:Create(DropdownList, MOTION_EXPAND, {Size = UDim2.new(DTFrame.Size.X.Scale, 0, 0, 0)})
						closeTween:Play()
						closeTween.Completed:Wait()
						if not listVisible then DropdownList.Visible = false end
					end
				end

				local function createItems()
					for _, child in ipairs(DropdownList:GetChildren()) do
						if child:IsA("TextButton") then child:Destroy() end
					end
					UIGridLayout.CellSize = UDim2.new(1 / itemsPerRow, -5, 0, 30)
					UIGridLayout.CellPadding = UDim2.new(0, 5, 0, 5)
					for _, itemText in ipairs(items) do
						local ItemButton = Instance.new("TextButton")
						ItemButton.Parent = DropdownList
						ItemButton.BackgroundColor3 = Theme.ButtonColor
						ItemButton.Text = itemText
						ItemButton.TextColor3 = Theme.TextColor
						ItemButton.TextScaled = true
						addCorner(ItemButton, Layout.ElementCorner)
						ItemButton.MouseButton1Click:Connect(function()
							DropdownAPI:setSelected(itemText)
						end)
					end
				end

				function DropdownAPI:newCallback(newCallback) callback = newCallback or function() end end

				function DropdownAPI:setItems(newItems)
					items = newItems or {}
					createItems()
				end

				function DropdownAPI:getSelected() return selectedItem end
				function DropdownAPI:setSelected(itemToSelect, silent)
					if table.find(items, itemToSelect) then
						selectedItem = itemToSelect
						DropdownButton.Text = name .. ": " .. itemToSelect
						toggleListVisibility(false)
						if not silent then callback(toggled, selectedItem) end
					end
				end

				function DropdownAPI:getToggled() return toggled end
				function DropdownAPI:setToggled(newState, silent)
					toggled = newState
					ToggleButton.Image = if toggled then "http://www.roblox.com/asset/?id=6031068426" else "http://www.roblox.com/asset/?id=6031068433"
					if not silent then callback(toggled, selectedItem) end
				end

				function DropdownAPI:newName(newName)
					name = newName or name
					DropdownButton.Text = name .. ": " .. (selectedItem or "")
				end

				function DropdownAPI:updateDropdown(newName, newItems, newitemsPerRow, newCallback)
					self:newName(newName)
					self:setItems(newItems)
					self:newCallback(newCallback)

					local numRows = math.ceil(#newItems / newitemsPerRow)
					DropdownList.CanvasSize = UDim2.new(0, 0, 0, numRows * 35) + ((numRows - 1) * 5)
					DropdownList.Visible = true
					TweenService:Create(DropdownImage, MOTION_EXPAND, {Rotation = 90}):Play()
					TweenService:Create(DropdownList, MOTION_EXPAND, {Size = UDim2.new(DTFrame.Size.X.Scale, 0, 0, math.min(numRows * 35 + ((numRows - 1) * 5), 140))}):Play()

				end

				function DropdownAPI:destroy()
					DTFrame:Destroy()
					DropdownList:Destroy()
				end

				ToggleButton.MouseButton1Click:Connect(function() DropdownAPI:setToggled(not toggled) end)
				DropdownButton.MouseButton1Click:Connect(function() toggleListVisibility() end)
				DropdownImage.MouseButton1Click:Connect(function() toggleListVisibility() end)

				ApplyHoverEffects(DTFrame, DTFrame)
				createItems()
				return DropdownAPI
			end

			function table:addLabel(text)
				local labelAPI = {}
				local labelFrame = CreateBaseComponent(parent)
				labelFrame.BackgroundTransparency = 1

				local label = Instance.new("TextLabel")
				label.Size = UDim2.fromScale(1, 1)
				label.Text = text or "Label"
				label.TextColor3 = Theme.TextColor
				label.TextScaled = true
				label.BackgroundTransparency = 1
				label.Parent = labelFrame

				function labelAPI:updateLabel(newText) label.Text = newText or label.Text end
				function labelAPI:getInstance() return labelFrame end
				function labelAPI:destroy() labelFrame:Destroy() end
				return labelAPI
			end

			function table:addSection(text)
				local sectionAPI = {}

				local Section = Instance.new("TextLabel")
				Section.Size = Layout.ButtonSize
				Section.BackgroundColor3 = Theme.ButtonColor
				Section.Text = text or "Section"
				Section.TextColor3 = Theme.TextColor
				Section.TextScaled = true
				Section.Parent = parent
				addCorner(Section, Layout.ElementCorner)

				function sectionAPI:updateSection(newText) Section.Text = "  " .. (newText or Section.Text) end
				function sectionAPI:getInstance() return Section end
				function sectionAPI:destroy() Section:Destroy() end
				return sectionAPI
			end

			function table:addSeparator()
				local separatorFrame = Instance.new("Frame")
				separatorFrame.Name = "Separator"
				separatorFrame.Parent = parent
				separatorFrame.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
				separatorFrame.BorderSizePixel = 0
				separatorFrame.Size = UDim2.new(0.95, 0, 0, 0.1) 
				return separatorFrame
			end

		end

		local EI = {}

		addAllMatrials(EI, tabContent)

		local CreateLogicFrameButton, CreateActualRow

		CreateLogicFrameButton = function(name, Info, parent, frame)
			local FBE = {}
			local name = name or "ButtonFrame"

			local ButtonContent = Instance.new("Frame")
			ButtonContent.Size = UDim2.new(1, 0, 1, 0)
			ButtonContent.Position = UDim2.new(0, 0, 0, 0)
			ButtonContent.BackgroundColor3 = Theme.BackgroundColor
			ButtonContent.BackgroundTransparency = 1
			ButtonContent.Visible = false
			ButtonContent.Parent = tabContentScroll
			addCorner(ButtonContent, UDim.new(0, 8))
			tabs[#tabs + 1] = ButtonContent

			local ButtonContentLayout = Instance.new("UIListLayout")
			ButtonContentLayout.Parent = ButtonContent
			ButtonContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
			ButtonContentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			ButtonContentLayout.Padding = UDim.new(0, 5)

			local ButtonFrame = Instance.new("Frame")
			ButtonFrame.Parent = parent
			ButtonFrame.BackgroundColor3 = Theme.ButtonColor
			ButtonFrame.Size = Layout.ButtonSize
			addCorner(ButtonFrame, Layout.ElementCorner)

			local Button = Instance.new("TextButton")
			Button.BackgroundTransparency = 1
			Button.Position = UDim2.new(0.05, 0, 0, 0)
			Button.Size = Components.TextSize.WithIcon
			Button.Text = name
			Button.TextColor3 = Theme.TextColor
			Button.TextScaled = true
			Button.TextXAlignment = Enum.TextXAlignment.Left
			Button.Parent = ButtonFrame
			Button.MouseButton1Click:Connect(function() 
				for _, tab in pairs(tabs) do
					tab.Visible = false
				end

				updateCanvasSize(ButtonContent)
				ButtonContent.Visible = true
			end)

			local arrow = Instance.new("TextLabel")
			arrow.BackgroundTransparency = 1
			arrow.Position = UDim2.new(0.9, 0, 0, 0)
			arrow.Size = UDim2.new(0.1, 0, 1, 0)
			arrow.Text = "→"
			arrow.TextColor3 = Theme.TextColor
			arrow.TextScaled = true
			arrow.Parent = ButtonFrame


			local Image = Instance.new("ImageButton")
			Image.Parent = ButtonFrame
			Image.BackgroundTransparency = 1
			Image.Position = Components.Image.InfoImagePOS
			Image.Size = Components.Image.ImageSize
			Image.Image = "http://www.roblox.com/asset/?id=6026568210"
			Image.ImageColor3 = Theme.TextColor

			if Info and Info ~= "" then
				Image.MouseButton1Click:Connect(function()
					TextInfo.Text = Info
					if not InfoFrame.Visible then
						InfoFrame.Visible = true
						local tweenSize = TweenService:Create(InfoFrame, Animation.TweenInfo, {Size = UDim2.new(0.7133, 0,0.148, 0)})
						tweenSize:Play()
					end
				end)
			else
				Button.Size = Components.TextSize.Full
				Image:Destroy()
			end


			CreateStyledButton(ButtonContent, "← Back", "", function()
				for _, tab in pairs(tabs) do
					tab.Visible = false
				end
				frame.Visible = true
				updateCanvasSize(parent)
			end)

			function FBE:updateFrameButton(newname, newInfo)
				newname = newname or name

				Button.Text = newname

				if newInfo and newInfo ~= "" then
					if Image then
						Image.MouseButton1Click:Connect(function()
							TextInfo.Text = Info
						end)
					else
						local Image = Instance.new("ImageButton")
						Image.BackgroundTransparency = 1
						Image.Position = Components.Image.InfoImagePOS
						Image.Size = Components.Image.ImageSize
						Image.Image = "http://www.roblox.com/asset/?id=6026568210"
						Image.ImageColor3 = Theme.TextColor
						Image.MouseButton1Click:Connect(function()
							TextInfo.Text = newInfo
							if InfoFrame.Size.Y ~= {0.148, 0} then
								InfoFrame.Visible = true
								local tweenSize = TweenService:Create(InfoFrame, Animation.TweenInfo, {Size = UDim2.new(0.7133, 0,0.148, 0)})
								tweenSize:Play()
							end
						end)
					end
				end
			end

			function FBE:openFrame()
				for _, tab in pairs(tabs) do
					tab.Visible = false
				end
				ButtonContent.Visible = true
				updateCanvasSize(ButtonContent)
			end

			function FBE:destroy()
				ButtonContent:Destroy()
				ButtonFrame:Destroy()
			end

			function FBE:addRow(FramePerRow, lines)
				return CreateActualRow(ButtonContent, FramePerRow, lines)
			end

			function FBE:addFrameButton(name, Info)
				return CreateLogicFrameButton(name, Info, ButtonContent, ButtonContent)
			end

			addAllMatrials(FBE, ButtonContent)

			return FBE
		end

		CreateActualRow = function(parent, FramePerRow, lines)
			local row = Instance.new("Frame")
			row.Name = "RFrame"
			row.Size = UDim2.new(0.95, 0, 0, 30)
			row.BackgroundTransparency = 1
			row.Parent = parent

			local GridLayout = Instance.new("UIGridLayout")
			GridLayout.CellPadding = UDim2.new(0.02, 0, 0.02, 0)
			GridLayout.FillDirection = Enum.FillDirection.Horizontal
			GridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			GridLayout.VerticalAlignment = Enum.VerticalAlignment.Top
			GridLayout.SortOrder = Enum.SortOrder.LayoutOrder
			GridLayout.Parent = row

			local function update()
				local visibleChildren = {}
				for _, child in ipairs(row:GetChildren()) do
					if child:IsA("GuiObject") and child.Visible then
						table.insert(visibleChildren, child)
					end
				end
				local buttonCount = #visibleChildren

				if buttonCount == 0 then return end

				local actualFramePerRow = FramePerRow and math.min(buttonCount, FramePerRow) or buttonCount
				local totalPaddingScale = (actualFramePerRow - 1) * GridLayout.CellPadding.X.Scale
				local availableWidthScale = 1 - totalPaddingScale
				local cellWidthScale = availableWidthScale / actualFramePerRow

				local rowHeight
				if lines and lines > 0 then
					rowHeight = 1 / lines
				else
					local rowsNeeded = math.ceil(buttonCount / (FramePerRow or buttonCount))
					rowHeight = 1 / rowsNeeded
				end

				GridLayout.CellSize = UDim2.new(cellWidthScale, 0, rowHeight, 0)
			end

			row.ChildAdded:Connect(update)
			row.ChildRemoved:Connect(update)
			update()

			local REI = {}

			function REI:addButton(name, Info, callback)
				return CreateStyledButton(row, name, Info, callback)
			end

			function REI:addFrameButton(name, Info)
				return CreateLogicFrameButton(name, Info, row)
			end

			function REI:addRow(newFramePerRow, newLines)
				return CreateActualRow(row, newFramePerRow, newLines)
			end

			addAllMatrials(REI, row)

			return REI
		end

		function EI:addFrameButton(name, Info)
			return CreateLogicFrameButton(name, Info, tabContent)
		end

		function EI:addRow(FramePerRow, lines)
			return CreateActualRow(tabContent, FramePerRow, lines)
		end

		return EI
	end

	function TabsAndStyles:addSettingsTab()
		local tabSettingsButton = Instance.new("TextButton")
		tabSettingsButton.BackgroundColor3 = Theme.ButtonColor
		tabSettingsButton.BorderSizePixel = 0
		tabSettingsButton.AutoButtonColor = false
		tabSettingsButton.Size = UDim2.new(0.8, 0, 0, 35)
		tabSettingsButton.Text = "Settings"
		tabSettingsButton.TextColor3 = Theme.TextColor
		tabSettingsButton.TextScaled = true
		tabSettingsButton.Parent =  tabContainer
		addCorner(tabSettingsButton, Layout.ElementCorner)

		local tabContent = Instance.new("Frame")
		tabContent.Size = UDim2.new(1, 0, 1, 0)
		tabContent.Position = UDim2.new(0, 0, 0, 0)
		tabContent.BackgroundColor3 = Theme.BackgroundColor
		tabContent.BackgroundTransparency = 1
		tabContent.Visible = false
		tabContent.Parent = tabContentScroll
		addCorner(tabContent, UDim.new(0, 8))

		local contentLayout = Instance.new("UIListLayout")
		contentLayout.Parent = tabContent
		contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
		contentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		contentLayout.Padding = UDim.new(0, 5)

		tabs[#tabs + 1] = tabContent
		tabsButtons[#tabsButtons + 1] = tabSettingsButton

		local underline = Instance.new("Frame")
		underline.Size = UDim2.new(0, 0, 0, 2)
		underline.Position = UDim2.new(0.5, 0, 1, 0)
		underline.AnchorPoint = Vector2.new(0.5, 0)
		underline.BackgroundColor3 = Theme.TabUnderLineColor
		underline.BorderSizePixel = 0
		underline.Parent = tabSettingsButton

		tabSettingsButton.MouseEnter:Connect(function()
			TweenService:Create(underline, TweenInfo.new(0.2), {Size = UDim2.new(0.8, 0, 0, 2)}):Play()
		end)

		tabSettingsButton.MouseLeave:Connect(function()
			TweenService:Create(underline, TweenInfo.new(0.2), {Size = UDim2.new(0, 0, 0, 2)}):Play()
		end)

		tabSettingsButton.MouseButton1Click:Connect(function()
			local tween = TweenService:Create(tabSettingsButton, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(1, 0, 0, 40)})
			tween:Play()
			for _, tab in pairs(tabs) do
				tab.Visible = false
			end
			for _, tabsButton in pairs(tabsButtons) do
				tabsButton.BackgroundColor3 = Theme.ButtonColor
			end
			updateCanvasSize(tabContent)
			tabSettingsButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			tabContent.Visible = true
			tween.Completed:Wait()
			local tween = TweenService:Create(tabSettingsButton, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0.95, 0, 0, 35)})
			tween:Play()
		end)



	end

	return TabsAndStyles
end	
return akdo
