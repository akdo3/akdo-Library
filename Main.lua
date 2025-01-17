local akdo = {}
akdo.Setting = {
	Properties = {
		Background_Border_Color = Color3.fromRGB(0, 0, 0)	,
		BackgroundColor 		= Color3.fromRGB(10, 10, 18),
		TextColor 				= Color3.fromRGB(0, 255, 0) ,
		ButtonColor 			= Color3.fromRGB(10, 10, 18),
		ButtonSize				= UDim2.new(0.95, 0, 0, 30)	,
	},
	TweenInfo 		= TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
	Padding 		= 10,
	ElementCorner 	= UDim.new(0.2, 0),
	Image 	= {
		ImageSize  	 = UDim2.new(0.1, 0, 1, 0),
		InfoImagePOS = UDim2.new(0.9, 0,0, 0) ,
	},
	TextSize = {
		Text = UDim2.new(1, 0, 1, 0),
		Text1 = UDim2.new(0.9, 0, 1, 0),
		Text2 = UDim2.new(0.8, 0, 1, 0),
		Text3 = UDim2.new(0.7, 0, 1, 0),
	},
	Toggle = {
		Stare = "",
		Circl = "",
		Normal = "",
		Square = "",
	},
	Slider = {

	},
}

function akdo:createFrame(titleText)
	local UserInputService = game:GetService("UserInputService")
	local TweenService = game:GetService("TweenService")

	local function addCorner(instance, radius1)
		local corner = Instance.new("UICorner")
		corner.CornerRadius = radius1
		corner.Parent = instance
	end

	local function addStroke(instance, Thickness, color, StrockType)
		local Stroke = Instance.new("UIStroke")
		Stroke.Color = color
		Stroke.Thickness = Thickness
		Stroke.Parent = instance
		Stroke.ApplyStrokeMode = StrockType or Enum.ApplyStrokeMode.Contextual
	end

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

	local Frame = Instance.new("Frame")
	Frame.Position = UDim2.new(0.25, 0, 0.25, 0)
	Frame.Size = UDim2.new(0.5, 0, 0.5, 0)
	Frame.BackgroundColor3 = akdo.Setting.Properties.Background_Border_Color
	Frame.Parent = ScreenGui
	addCorner(Frame, UDim.new(0.03, 0))

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
	DropShadow.Size = UDim2.new(1.1025306, 0, 1.19389439, 0)
	DropShadow.ZIndex = 0
	DropShadow.Image = "rbxassetid://6015897843"
	DropShadow.ImageColor3 = akdo.Setting.Properties.Background_Border_Color
	DropShadow.ImageTransparency = 0.5
	DropShadow.ScaleType = Enum.ScaleType.Slice
	DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)

	local dragging
	local dragInput
	local dragStart
	local startPos

	local function update(input)
		local delta = input.Position - dragStart
		Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end

	Frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = Frame.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	Frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)

	local Header = Instance.new("Frame")
	Header.Size = UDim2.new(1, 0, 0.125, 0)
	Header.BackgroundColor3 = akdo.Setting.Properties.BackgroundColor
	Header.Parent = Frame
	addCorner(Header, UDim.new(0.3, 0))

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(0.727, 0,1, 0)
	title.Text = titleText or "akdo"
	title.TextColor3 = akdo.Setting.Properties.TextColor
	title.TextScaled = true
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.BackgroundTransparency = 1
	title.Parent = Header

	local originalSize = Frame.Size
	local originalPosition = Frame.Position
	local contentContainer = Frame:FindFirstChild("TabContentContainer")
	local minimizeState = false
	local akdoLabel = nil

	local smallButton
	local minimizeState = false
	local originalSize = Frame.Size
	local originalPosition = Frame.Position

	local buttonMaximize = Instance.new("TextButton")
	buttonMaximize.Position = UDim2.new(0.8340, 0, 0, 0)
	buttonMaximize.Size = UDim2.new(0.07860, 0, 1, 0)
	buttonMaximize.Text = "□"
	buttonMaximize.BackgroundTransparency = 1
	buttonMaximize.TextColor3 = Color3.fromRGB(255, 255, 255)
	buttonMaximize.TextScaled = true
	buttonMaximize.Parent = Header
	local isMaximized = false
	buttonMaximize.MouseButton1Click:Connect(function()
		local maxSize = UDim2.new(1, 0, 1, 0)
		local maxPosition = UDim2.new(0, 0, 0, 0)

		if isMaximized then
			local tweenSize = TweenService:Create(Frame, akdo.Setting.TweenInfo, {Size = originalSize, Position = originalPosition})
			tweenSize:Play()

			tweenSize.Completed:Connect(function()
				isMaximized = false
			end)
		else
			local tweenSize = TweenService:Create(Frame, akdo.Setting.TweenInfo, {Size = maxSize, Position = maxPosition})
			tweenSize:Play()

			tweenSize.Completed:Connect(function()
				isMaximized = true
			end)
		end
	end)

	local buttonClose = Instance.new("TextButton")
	buttonClose.Size = UDim2.new(0.1, 0, 1, 0)
	buttonClose.Position = UDim2.new(0.9, 0, 0, 0)
	buttonClose.Text = "X"
	buttonClose.BackgroundTransparency = 1
	buttonClose.TextColor3 = Color3.fromRGB(255, 0, 0)
	buttonClose.TextScaled = true
	buttonClose.Parent = Header
	buttonClose.MouseButton1Click:Connect(function()
		local confirmationFrame = Instance.new("Frame")
		confirmationFrame.AnchorPoint = Vector2.new(0.5, 0.5)
		confirmationFrame.Size = UDim2.new(0.5, 0, 0.5, 0)
		confirmationFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
		confirmationFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		confirmationFrame.Parent = Frame
		addCorner(confirmationFrame, UDim.new(0, 8))
		addStroke(confirmationFrame, 1, akdo.Setting.Properties.TextColor)

		local confirmLabel = Instance.new("TextLabel")
		confirmLabel.Size = UDim2.new(0.998036623, 0, 0.391914189, 0)
		confirmLabel.Text = "Are you sure you want to close?"
		confirmLabel.TextColor3 = akdo.Setting.Properties.TextColor
		confirmLabel.TextScaled = true
		confirmLabel.BackgroundTransparency = 1
		confirmLabel.Parent = confirmationFrame

		local confirmButton = Instance.new("TextButton")
		confirmButton.Position = UDim2.new(0.545375228, 0, 0.536303639, 0)
		confirmButton.Size = UDim2.new(0.409031421, 0, 0.391914189, 0)
		confirmButton.Text = "Yes"
		confirmButton.BackgroundColor3 = akdo.Setting.Properties.ButtonColor
		confirmButton.TextColor3 = akdo.Setting.Properties.TextColor
		confirmButton.TextScaled = true
		confirmButton.Parent = confirmationFrame
		addCorner(confirmButton, UDim.new(0.09, 0))
		addStroke(confirmButton, 2, akdo.Setting.Properties.Background_Border_Color)
		confirmButton.MouseButton1Click:Connect(function()
			if isMaximized then
				local tween = TweenService:Create(confirmationFrame ,TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out) , {Size = UDim2.new(0, 0, 0, 0)})
				local tween2 = TweenService:Create(Frame ,TweenInfo.new(2.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out) , {Position = UDim2.new(0.25, 0, 1.25, 0), Size = UDim2.new(0.5, 0, 0.5, 0)})
				tween:Play()
				tween.Completed:Wait()
				confirmationFrame:Destroy()
				tween2:Play()
				tween2.Completed:Wait()
				ScreenGui:Destroy()
			else
				local tween = TweenService:Create(confirmationFrame ,TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out) , {Size = UDim2.new(0, 0, 0, 0)})
				local tween2 = TweenService:Create(Frame ,TweenInfo.new(2.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out) , {Position = UDim2.new(0.25, 0, 1.25, 0)})
				tween:Play()
				tween.Completed:Wait()
				confirmationFrame:Destroy()
				tween2:Play()
				tween2.Completed:Wait()
				ScreenGui:Destroy()
			end
		end)

		local cancelButton = Instance.new("TextButton")
		cancelButton.Position = UDim2.new(0.0436300188, 0, 0.536303639, 0)
		cancelButton.Size = UDim2.new(0.409031421, 0, 0.391914189, 0)
		cancelButton.Text = "No"
		cancelButton.BackgroundColor3 = akdo.Setting.Properties.ButtonColor
		cancelButton.TextColor3 = akdo.Setting.Properties.TextColor
		cancelButton.TextScaled = true
		cancelButton.Parent = confirmationFrame
		addCorner(cancelButton, UDim.new(0.09, 0))
		addStroke(cancelButton, 2, akdo.Setting.Properties.Background_Border_Color)
		cancelButton.MouseButton1Click:Connect(function()
			local tween = TweenService:Create(confirmationFrame ,TweenInfo.new(1.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out) , {Position = UDim2.new(2, 0, 0.5, 0)})
			tween:Play()
			tween.Completed:Wait()
			confirmationFrame:Destroy()
		end)
	end)

	local buttonMinimize = Instance.new("TextButton")
	buttonMinimize.Position = UDim2.new(0.77, 0,-1.08, 0)
	buttonMinimize.Size = UDim2.new(0.05, 0,1.767, 0)
	buttonMinimize.Text = "_"
	buttonMinimize.TextColor3 = Color3.fromRGB(255, 255, 255)
	buttonMinimize.BackgroundTransparency = 1
	buttonMinimize.TextScaled = true
	buttonMinimize.Parent = Header
	buttonMinimize.MouseButton1Click:Connect(function()
		if not minimizeState then
			local tween = TweenService:Create(Frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0.05, 0,0.05, 0), Position = UDim2.new(0.5, 0, 0.5, 0)})
			tween:Play()
			tween.Completed:Wait()
			Frame.Visible = false

			local MinimizedButton = Instance.new("TextButton")
			MinimizedButton.Text = titleText or "akdo"
			MinimizedButton.Size = UDim2.new(0.05, 0,0.05, 0)
			MinimizedButton.Position = UDim2.new(0.5, 0, 0.5, 0)
			MinimizedButton.BackgroundColor3 = akdo.Setting.Properties.Background_Border_Color
			MinimizedButton.BorderColor3 = akdo.Setting.Properties.TextColor
			MinimizedButton.TextColor3 = akdo.Setting.Properties.TextColor
			MinimizedButton.TextScaled = true
			MinimizedButton.Parent = ScreenGui
			addCorner(MinimizedButton, UDim.new(0.18, 0))
			addStroke(MinimizedButton, 1, akdo.Setting.Properties.TextColor, Enum.ApplyStrokeMode.Border)

			local dragging
			local dragInput
			local dragStart
			local startPos

			local function update(input)
				local delta = input.Position - dragStart
				MinimizedButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			end

			MinimizedButton.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging = true
					dragStart = input.Position
					startPos = MinimizedButton.Position

					input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End then
							dragging = false
						end
					end)
				end
			end)

			MinimizedButton.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
					dragInput = input
				end
			end)

			UserInputService.InputChanged:Connect(function(input)
				if input == dragInput and dragging then
					update(input)
				end
			end)

			MinimizedButton.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging = true
					dragStart = input.Position
					startPos = MinimizedButton.Position
				end
			end)

			MinimizedButton.InputChanged:Connect(function(input)
				if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
					local delta = input.Position - dragStart
					MinimizedButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
				end
			end)

			MinimizedButton.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging = false
				end
			end)

			MinimizedButton.MouseButton1Click:Connect(function()
				MinimizedButton:Destroy()
				Frame.Visible = true
				local goalRestore = {Size = originalSize, Position = originalPosition}
				local tweenRestoreAnim = TweenService:Create(Frame, akdo.Setting.TweenInfo, goalRestore)
				tweenRestoreAnim:Play()
				tweenRestoreAnim.Completed:Wait()

				minimizeState = false
			end)

			minimizeState = true
		end
	end)

	local InfoFrame = Instance.new("Frame")
	InfoFrame.Parent = Frame
	InfoFrame.AnchorPoint = Vector2.new(0, 1)
	InfoFrame.BackgroundColor3 = akdo.Setting.Properties.ButtonColor
	InfoFrame.Position = UDim2.new(0.2639, 0, 1, 0)
	InfoFrame.Size = UDim2.new(0.7133, 0, 0, 0)
	InfoFrame.Visible = false
	InfoFrame.ZIndex = 2
	addCorner(InfoFrame, akdo.Setting.ElementCorner)
	addStroke(InfoFrame, 1, akdo.Setting.Properties.TextColor)

	local TextInfo = Instance.new("TextLabel")
	TextInfo.Parent = InfoFrame
	TextInfo.BackgroundTransparency = 1
	TextInfo.Size = UDim2.new(0.88996762, 0,1, 0)
	TextInfo.ZIndex = 2
	TextInfo.TextColor3 = akdo.Setting.Properties.TextColor
	TextInfo.TextScaled = true

	local closeInfoFrame = Instance.new("TextButton")
	closeInfoFrame.Parent = InfoFrame
	closeInfoFrame.Active = true
	closeInfoFrame.BackgroundTransparency = 1
	closeInfoFrame.Position = UDim2.new(0.88996762, 0,0, 0)
	closeInfoFrame.Size = UDim2.new(0.113268606, 0,1, 0)
	closeInfoFrame.ZIndex = 2
	closeInfoFrame.Text = "X"
	closeInfoFrame.TextColor3 = Color3.fromRGB(255,0,0)
	closeInfoFrame.TextScaled = true
	closeInfoFrame.MouseButton1Click:Connect(function()
		local tween = TweenService:Create(InfoFrame, akdo.Setting.TweenInfo, {Size = UDim2.new(0.7133, 0,0, 0)})
		tween:Play()
		wait(0.19)
		InfoFrame.Visible = false
	end)

	local tabContainer = Instance.new("ScrollingFrame")
	tabContainer.Size = UDim2.new(0.2, 0, 0.815, 0)
	tabContainer.Position = UDim2.new(0, 0, 0.153, 0)
	tabContainer.BackgroundTransparency = 1
	tabContainer.ScrollBarThickness = 2

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

	local function updateTabContainerCanvasSize()
		local contentHeight = tabLayout.AbsoluteContentSize.Y
		tabContainer.CanvasSize = UDim2.new(0, 0, 0, contentHeight + 10)
	end

	tabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateTabContainerCanvasSize)
	updateTabContainerCanvasSize()

	local tabContentContainer = Instance.new("Frame")
	tabContentContainer.Size = UDim2.new(0.76, 0, 0.809, 0)
	tabContentContainer.Position = UDim2.new(0.217, 0, 0.153, 0)
	tabContentContainer.BackgroundColor3 = akdo.Setting.Properties.Background_Border_Color
	tabContentContainer.Parent = Frame
	addCorner(tabContentContainer, UDim.new(0, 8))

	local tabContentScroll = Instance.new("ScrollingFrame")
	tabContentScroll.Size = UDim2.new(1, 0, 1, 0)
	tabContentScroll.Position = UDim2.new(0, 0, 0, 0)
	tabContentScroll.BackgroundColor3 = akdo.Setting.Properties.Background_Border_Color
	tabContentScroll.ScrollBarThickness = 4
	tabContentScroll.ScrollingDirection = Enum.ScrollingDirection.Y
	tabContentScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
	tabContentScroll.Parent = tabContentContainer
	addCorner(tabContentScroll, UDim.new(0, 8))

	local contentLayout = Instance.new("UIListLayout")
	contentLayout.Parent = tabContentScroll
	contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
	contentLayout.Padding = UDim.new(0, 5)

	local TabsAndStyles = {}
	function TabsAndStyles:FrameStyle(option)
		if option == "One" or option == 1 then
			Header.Size = UDim2.new(1, 0, 0.125, 0)
			title.Size = UDim2.new(0.727, 0,1, 0)

			buttonMaximize.Position = UDim2.new(0.8340, 0, 0, 0)
			buttonMaximize.Size = UDim2.new(0.07860, 0, 1, 0)
			buttonMaximize.Parent = Header

			buttonClose.Size = UDim2.new(0.1, 0, 1, 0)
			buttonClose.Position = UDim2.new(0.9, 0, 0, 0)
			buttonClose.Parent = Header

			buttonMinimize.Position = UDim2.new(0.77, 0,-1.08, 0)
			buttonMinimize.Size = UDim2.new(0.05, 0,1.767, 0)
			buttonMinimize.Parent = Header

			tabContentContainer.Size = UDim2.new(0.76, 0, 0.809, 0)
			tabContentContainer.Position = UDim2.new(0.217, 0, 0.153, 0)
		elseif option == "Two" or option == 2 then
			local HeaderUICorner = Header:FindFirstChild("UICorner")
			Header.Size = UDim2.new(0.215, 0, 0.97, 0)
			HeaderUICorner.CornerRadius = UDim.new(0.05, 0)
			title.Size = UDim2.new(1, 0, 0.13, 0)

			buttonMaximize.Position = UDim2.new(0.868, 0, 0, 0)
			buttonMaximize.Size = UDim2.new(0.064, 0, 0.123, 0)
			buttonMaximize.Parent = Frame

			buttonClose.Size = UDim2.new(0.064, 0, 0.123, 0)
			buttonClose.Position = UDim2.new(0.934, 0, 0, 0)
			buttonClose.Parent = Frame

			buttonMinimize.Position = UDim2.new(0.8, 0,-0.131, 0)
			buttonMinimize.Size = UDim2.new(0.056, 0, 0.217, 0)
			buttonMinimize.Parent = Frame

			tabContentContainer.Size = UDim2.new(0.742, 0, 0.836, 0)
			tabContentContainer.Position = UDim2.new(0.235, 0, 0.126, 0)
		end
	end

	function TabsAndStyles:addTab(name)
		local tabButton = Instance.new("TextButton")
		tabButton.Size = UDim2.new(0.8, 0, 0, 35)
		tabButton.Text = name or "Tab"
		tabButton.BackgroundTransparency = 1
		tabButton.TextColor3 = akdo.Setting.Properties.TextColor
		tabButton.TextScaled = true
		tabButton.Parent =  tabContainer
		addCorner(tabButton, akdo.Setting.ElementCorner)

		local tabContent = Instance.new("Frame")
		tabContent.Size = UDim2.new(1, 0, 1, 0)
		tabContent.Position = UDim2.new(0, 0, 0, 0)
		tabContent.BackgroundColor3 = akdo.Setting.Properties.Background_Border_Color
		tabContent.Visible = false
		tabContent.Parent = tabContentScroll
		addCorner(tabContent, UDim.new(0, 8))

		local contentLayout = Instance.new("UIListLayout")
		contentLayout.Parent = tabContent
		contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
		contentLayout.Padding = UDim.new(0, 5)

		tabs[#tabs + 1] = tabContent
		tabsButtons[#tabsButtons + 1] = tabButton

		tabButton.MouseEnter:Connect(function()
			local tween = TweenService:Create(tabButton, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0.95, 0, 0, 35)})
			tween:Play()
		end)

		tabButton.MouseLeave:Connect(function()
			local tween = TweenService:Create(tabButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0.8, 0, 0, 35)})
			tween:Play()
		end)

		tabButton.MouseButton1Click:Connect(function()
			local tween = TweenService:Create(tabButton, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(1, 0, 0, 38)})
			tween:Play()
			for _, tab in pairs(tabs) do
				tab.Visible = false
			end
			for _, tabsButton in pairs(tabsButtons) do
				tabsButton.BackgroundColor3 = akdo.Setting.Properties.ButtonColor
			end
			tabContentScroll.CanvasSize = UDim2.new(1, 0, 0, (#tabContent:GetChildren() * 35) - (2 * 35) + 10)
			tabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			tabContent.Visible = true
			tween.Completed:Wait()
			local tween = TweenService:Create(tabButton, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0.95, 0, 0, 35)})
			tween:Play()
		end)

		local EI = {}

		function EI:addButton(name, Info, callback, parent)
			local BF = {}
			local callback = callback or function() end
			local ButtonFrame = Instance.new("Frame")
			ButtonFrame.Parent = parent or tabContent
			ButtonFrame.BackgroundColor3 = akdo.Setting.Properties.ButtonColor
			ButtonFrame.Size = akdo.Setting.Properties.ButtonSize
			addCorner(ButtonFrame, akdo.Setting.ElementCorner)

			local Button = Instance.new("TextButton")
			Button.BackgroundTransparency = 1
			Button.Size = akdo.Setting.TextSize.Text1
			Button.Text = name or "Button"
			Button.TextColor3 = akdo.Setting.Properties.TextColor
			Button.TextScaled = true
			Button.TextXAlignment = Enum.TextXAlignment.Left
			Button.Parent = ButtonFrame
			Button.MouseButton1Click:Connect(callback)

			local Image = Instance.new("ImageButton")
			Image.Parent = ButtonFrame
			Image.BackgroundTransparency = 1
			Image.Position = akdo.Setting.Image.InfoImagePOS
			Image.Size = akdo.Setting.Image.ImageSize
			Image.Image = "http://www.roblox.com/asset/?id=6026568210"
			Image.ImageColor3 = akdo.Setting.Properties.TextColor

			if Info then
				if Info == "" then
					Button.Size = akdo.Setting.TextSize.Text
					Image:Destroy()
				else
					Image.MouseButton1Click:Connect(function()
						TextInfo.Text = Info
						if InfoFrame.Size.Y ~= {0.148, 0} then
							InfoFrame.Visible = true
							local tweenSize = TweenService:Create(InfoFrame, akdo.Setting.TweenInfo, {Size = UDim2.new(0.7133, 0,0.148, 0)})
							tweenSize:Play()
						end
					end)
				end
			else
				Button.Size = akdo.Setting.TextSize.Text
				Image:Destroy()
			end
			function BF:updateButton(newparent, name, Info, callback)
				local callback = callback or function() end

				if name and name ~= "" then
					Button.Text = name
				end

				if callback and callback ~= "" then
					Button.MouseButton1Click:Connect(callback)
				end

				if Info and Info ~= "" then
					if Image then
						Image.MouseButton1Click:Connect(function()
							TextInfo.Text = Info
						end)
					else
						local Image = Instance.new("ImageButton")
						Image.Parent = parent
						Image.BackgroundTransparency = 1
						Image.Position = akdo.Setting.Image.InfoImagePOS
						Image.Size = akdo.Setting.Image.ImageSize
						Image.Image = "http://www.roblox.com/asset/?id=6026568210"
						Image.ImageColor3 = akdo.Setting.Properties.TextColor
						Image.MouseButton1Click:Connect(function()
							TextInfo.Text = Info
							if InfoFrame.Size.Y ~= {0.148, 0} then
								InfoFrame.Visible = true
								local tweenSize = TweenService:Create(InfoFrame, akdo.Setting.TweenInfo, {Size = UDim2.new(0.7133, 0,0.148, 0)})
								tweenSize:Play()
							end
						end)
					end
				end
			end
			return BF
		end

		function EI:addToggle(name, Info, callback, parent)
			local TF = {}
			local callback = callback or function() end
			local ToggleFrame = Instance.new("Frame")
			local TextButton = Instance.new("TextButton")
			local toggleButton = Instance.new("ImageButton")

			ToggleFrame.Name = "TFrame"
			ToggleFrame.Parent = parent or tabContent
			ToggleFrame.BackgroundColor3 = akdo.Setting.Properties.ButtonColor
			ToggleFrame.Size = akdo.Setting.Properties.ButtonSize
			addCorner(ToggleFrame, akdo.Setting.ElementCorner)

			TextButton.Parent = ToggleFrame
			TextButton.BackgroundTransparency = 1
			TextButton.Size = akdo.Setting.TextSize.Text3
			TextButton.Text = name or "Toggle"
			TextButton.TextColor3 = akdo.Setting.Properties.TextColor
			TextButton.TextScaled = true
			TextButton.TextXAlignment = Enum.TextXAlignment.Left

			toggleButton.Name = "imageButton"
			toggleButton.Parent = ToggleFrame
			toggleButton.BackgroundTransparency = 1
			toggleButton.Position = UDim2.new(0.8, 0, 0, 0)
			toggleButton.Size = UDim2.new(0.1, 0, 1, 0)
			toggleButton.Image = "http://www.roblox.com/asset/?id=6031068433"
			toggleButton.ImageColor3 = akdo.Setting.Properties.TextColor

			local function adjustToggleSize()
				local row = ToggleFrame.Parent
				if row and row:IsA("Frame") and row.Name == "RFrame" then
					local childCount = 0
					for _, child in ipairs(row:GetChildren()) do
						if child:IsA("Frame") then
							childCount = childCount + 1
						end
					end

					if childCount > 0 then
						local additionalSize = 0.1 * childCount
						toggleButton.Size = UDim2.new(0 + additionalSize, 0, 1, 0)
						toggleButton.Position = UDim2.new(1 - additionalSize, 0, 0, 0)
						TextButton.Size = UDim2.new(1 - additionalSize, 0, 1, 0)
					end
				end
			end

			if parent and parent ~= tabContent and parent.Name == "RFrame" then
				parent.ChildAdded:Connect(adjustToggleSize)
				parent.ChildRemoved:Connect(adjustToggleSize)
			end
			adjustToggleSize()

			local toggled = false
			local function toggleState()
				toggled = not toggled
				toggleButton.Image = toggled and "http://www.roblox.com/asset/?id=6031068426" or "http://www.roblox.com/asset/?id=6031068433"
				callback(toggled)
			end

			TextButton.MouseButton1Click:Connect(toggleState)
			toggleButton.MouseButton1Click:Connect(toggleState)

			local Image = Instance.new("ImageButton")
			Image.Parent = ToggleFrame
			Image.BackgroundTransparency = 1
			Image.Position = akdo.Setting.Image.InfoImagePOS
			Image.Size = akdo.Setting.Image.ImageSize
			Image.Image = "http://www.roblox.com/asset/?id=6026568210"
			Image.ImageColor3 = akdo.Setting.Properties.TextColor

			if Info then
				if Info == "" then
					toggleButton.Position = UDim2.new(0.9, 0, 0, 0)
					TextButton.Size = akdo.Setting.TextSize.Text2
					Image:Destroy()
				else
					Image.MouseButton1Click:Connect(function()
						TextInfo.Text = Info
						if InfoFrame.Size.Y ~= {0.148, 0} then
							InfoFrame.Visible = true
							local tweenSize = TweenService:Create(InfoFrame, akdo.Setting.TweenInfo, {Size = UDim2.new(0.7133, 0,0.148, 0)})
							tweenSize:Play()
						end
					end)
				end
			else
				toggleButton.Position = UDim2.new(0.9, 0, 0, 0)
				TextButton.Size = akdo.Setting.TextSize.Text2
				Image:Destroy()
			end

			function TF:updateToggle(name, Info, callback, parent)
				local callback = callback or function() end

				if name and name ~= "" then
					TextButton.Text = name
				end

				if Info and Info ~= "" then
					if Image then
						Image.MouseButton1Click:Connect(function()
							TextInfo.Text = Info
						end)
					else
						local Image = Instance.new("ImageButton")
						Image.Parent = parent
						Image.BackgroundTransparency = 1
						Image.Position = akdo.Setting.Image.InfoImagePOS
						Image.Size = akdo.Setting.Image.ImageSize
						Image.Image = "http://www.roblox.com/asset/?id=6026568210"
						Image.ImageColor3 = akdo.Setting.Properties.TextColor
						Image.MouseButton1Click:Connect(function()
							TextInfo.Text = Info
							if InfoFrame.Size.Y ~= {0.148, 0} then
								InfoFrame.Visible = true
								local tweenSize = TweenService:Create(InfoFrame, akdo.Setting.TweenInfo, {Size = UDim2.new(0.7133, 0,0.148, 0)})
								tweenSize:Play()
							end
						end)
					end
				end

				if callback then
					local toggled = false
					TextButton.MouseButton1Click:Connect(function()
						if toggled then
							toggled = not toggled
							toggleButton.Image = "http://www.roblox.com/asset/?id=6031068433"
							callback(toggled)
						else
							toggled = not toggled
							toggleButton.Image = "http://www.roblox.com/asset/?id=6031068426"
							callback(toggled)
						end
					end)
					toggleButton.MouseButton1Click:Connect(function() 
						if toggled then
							toggled = not toggled
							toggleButton.Image = "http://www.roblox.com/asset/?id=6031068433"
							callback(toggled)
						else
							toggled = not toggled
							toggleButton.Image = "http://www.roblox.com/asset/?id=6031068426"
							callback(toggled)
						end
					end)
				end
			end

			return TF
		end

		function EI:addDropdown(name, Info, items, itemsPerRow, callback, parent)
			local DF = {}
			callback = callback or function() end

			local DropdownFrame = Instance.new("Frame")
			local DropdownButton = Instance.new("TextButton")
			local DropdownImageButton = Instance.new("ImageButton")
			local DropdownList = Instance.new("ScrollingFrame")
			local UIGridLayout = Instance.new("UIGridLayout")

			DropdownFrame.Parent = parent or tabContent
			DropdownFrame.BackgroundColor3 = akdo.Setting.Properties.ButtonColor
			DropdownFrame.Size = akdo.Setting.Properties.ButtonSize
			addCorner(DropdownFrame, akdo.Setting.ElementCorner)

			DropdownButton.Parent = DropdownFrame
			DropdownButton.BackgroundTransparency = 1
			DropdownButton.Size = akdo.Setting.TextSize.Text1
			DropdownButton.Text = name or "Dropdown"
			DropdownButton.TextColor3 = akdo.Setting.Properties.TextColor
			DropdownButton.TextScaled = true
			DropdownButton.TextXAlignment = Enum.TextXAlignment.Left

			DropdownImageButton.Parent = DropdownFrame
			DropdownImageButton.BackgroundTransparency = 1
			DropdownImageButton.Position = UDim2.new(0.9, 0,0, 0)
			DropdownImageButton.Size = UDim2.new(0.1, 0,1, 0)
			DropdownImageButton.Image = "http://www.roblox.com/asset/?id=6031090994"
			DropdownImageButton.ImageColor3 = akdo.Setting.Properties.TextColor

			DropdownList.Parent = parent or tabContent
			DropdownList.BackgroundColor3 = akdo.Setting.Properties.BackgroundColor
			DropdownList.Position = UDim2.new(0, 0, 1, 0)
			DropdownList.Size = UDim2.new(0.95, 0,0, 0)
			DropdownList.ScrollingDirection = Enum.ScrollingDirection.Y
			DropdownList.Visible = false
			DropdownList.ScrollBarThickness = 3
			addCorner(DropdownList, akdo.Setting.ElementCorner)

			UIGridLayout.Parent = DropdownList
			UIGridLayout.CellSize = UDim2.new(1 / itemsPerRow, -10, 0, 30)
			UIGridLayout.CellPadding = UDim2.new(0, 5, 0, 5)
			UIGridLayout.FillDirection = Enum.FillDirection.Horizontal

			for _, item in pairs(items) do
				local ItemButton = Instance.new("TextButton")
				ItemButton.Parent = DropdownList
				ItemButton.BackgroundColor3 = akdo.Setting.Properties.ButtonColor
				ItemButton.Text = item
				ItemButton.Size = UDim2.new(1, 0, 0, 30)
				ItemButton.TextColor3 = akdo.Setting.Properties.TextColor
				ItemButton.TextScaled = true
				ItemButton.MouseButton1Click:Connect(function()
					DropdownButton.Text = name..": "..item
					TweenService:Create(DropdownImageButton, akdo.Setting.TweenInfo, {Rotation = DropdownImageButton.Rotation - 90}):Play()
					TweenService:Create(DropdownList, akdo.Setting.TweenInfo, {Size = UDim2.new(0.95, 0, 0, 0)}):Play()
					wait(0.2)
					DropdownList.Visible = false
					callback(item)
				end)
				addCorner(ItemButton, akdo.Setting.ElementCorner)
			end

			DropdownImageButton.MouseButton1Click:Connect(function() 
				if DropdownList.Visible then
					TweenService:Create(DropdownImageButton, akdo.Setting.TweenInfo, {Rotation = DropdownImageButton.Rotation - 90}):Play()
					TweenService:Create(DropdownList, akdo.Setting.TweenInfo, {Size = UDim2.new(0.95, 0, 0, 0)}):Play()
					wait(0.2)
					DropdownList.Visible = false
				else
					local numRows = math.ceil(#items / itemsPerRow)
					local itemHeight = 35
					local newHeight = numRows * itemHeight
					local maxHeight = 100
					local finalHeight = math.min(newHeight, maxHeight)
					DropdownList.CanvasSize = UDim2.new(1, 0, 0, newHeight)
					DropdownList.Visible = true
					TweenService:Create(DropdownImageButton, akdo.Setting.TweenInfo, {Rotation = DropdownImageButton.Rotation + 90}):Play()
					TweenService:Create(DropdownList, akdo.Setting.TweenInfo, {Size = UDim2.new(0.95, 0, 0, finalHeight)}):Play()
				end
			end)

			DropdownButton.MouseButton1Click:Connect(function()
				if DropdownList.Visible then
					TweenService:Create(DropdownImageButton, akdo.Setting.TweenInfo, {Rotation = DropdownImageButton.Rotation - 90}):Play()
					TweenService:Create(DropdownList, akdo.Setting.TweenInfo, {Size = UDim2.new(0.95, 0, 0, 0)}):Play()
					wait(0.2)
					DropdownList.Visible = false
				else
					local numRows = math.ceil(#items / itemsPerRow)
					local itemHeight = 35
					local newHeight = numRows * itemHeight
					local maxHeight = 100
					local finalHeight = math.min(newHeight, maxHeight)
					DropdownList.CanvasSize = UDim2.new(1, 0, 0, newHeight)
					DropdownList.Visible = true
					TweenService:Create(DropdownImageButton, akdo.Setting.TweenInfo, {Rotation = DropdownImageButton.Rotation + 90}):Play()
					TweenService:Create(DropdownList, akdo.Setting.TweenInfo, {Size = UDim2.new(0.95, 0, 0, finalHeight)}):Play()
				end
			end)

			if Info and Info ~= "" then
				DropdownImageButton.Position = UDim2.new(0.8, 0, 0, 0)
				DropdownButton.Size = akdo.Setting.TextSize.Text2

				local Image = Instance.new("ImageButton")
				Image.Parent = DropdownFrame
				Image.BackgroundTransparency = 1
				Image.Position = akdo.Setting.Image.InfoImagePOS
				Image.Size = akdo.Setting.Image.ImageSize
				Image.Image = "http://www.roblox.com/asset/?id=6026568210"
				Image.ImageColor3 = akdo.Setting.Properties.TextColor
				Image.MouseButton1Click:Connect(function()
					TextInfo.Text = Info
					if InfoFrame.Size.Y ~= {0.148, 0} then
						InfoFrame.Visible = true
						local tweenSize = TweenService:Create(InfoFrame, akdo.Setting.TweenInfo, {Size = UDim2.new(0.7133, 0,0.148, 0)})
						tweenSize:Play()
					end
				end)
			end
			function DF:updateDropdown(name, items, itemsPerRow, callback, parent)
				local callback = callback or function() end
				local DropdownButton = parent:FindFirstChild("TextButton")
				local DropdownList = parent:FindFirstChild("ScrollingFrame")
				local DropdownImage = parent:FindFirstChild("ImageButton")

				DropdownButton.Text = name or DropdownButton.Text

				DropdownButton.MouseButton1Click:Connect(function()
					if DropdownList.Visible then
						TweenService:Create(DropdownImage, akdo.Setting.TweenInfo, {Rotation = DropdownImage.Rotation - 90}):Play()
						TweenService:Create(DropdownList, akdo.Setting.TweenInfo, {Size = UDim2.new(0.95, 0, 0, 0)}):Play()
						wait(0.2)
						DropdownList.Visible = false
					else
						local numRows = math.ceil(#items / itemsPerRow)
						local itemHeight = 35
						local newHeight = numRows * itemHeight
						local maxHeight = 100
						local finalHeight = math.min(newHeight, maxHeight)
						DropdownList.CanvasSize = UDim2.new(1, 0, 0, newHeight)
						DropdownList.Visible = true
						TweenService:Create(DropdownImage, akdo.Setting.TweenInfo, {Rotation = DropdownImage.Rotation + 90}):Play()
						TweenService:Create(DropdownList, akdo.Setting.TweenInfo, {Size = UDim2.new(0.95, 0, 0, finalHeight)}):Play()
					end
				end)

				local Item
				for _, item in pairs(items) do
					local ItemButton = Instance.new("TextButton")
					ItemButton.Parent = DropdownList
					ItemButton.BackgroundColor3 = akdo.Setting.Properties.ButtonColor
					ItemButton.Text = item
					ItemButton.Size = UDim2.new(1, 0, 0, 30)
					ItemButton.TextColor3 = akdo.Setting.Properties.TextColor
					ItemButton.TextScaled = true

					ItemButton.MouseButton1Click:Connect(function()
						DropdownButton.Text = name..": "..item
						TweenService:Create(DropdownImage, akdo.Setting.TweenInfo, {Rotation = DropdownImage.Rotation - 90}):Play()
						TweenService:Create(DropdownList, akdo.Setting.TweenInfo, {Size = UDim2.new(0.95, 0, 0, 0)}):Play()
						wait(0.2)
						DropdownList.Visible = false
						Item = item
						callback(item)
					end)
					addCorner(ItemButton, akdo.Setting.ElementCorner)
				end
			end
		end

		function EI:addSlider(name, Info, Min, Max, callback, parent)
			local SF = {}
			callback = callback or function() end

			local SliderFrame = Instance.new("Frame")
			local SliderText = Instance.new("TextLabel")
			local CanvasGroup = Instance.new("CanvasGroup")
			local FillSlider = Instance.new("Frame")
			local Trigger = Instance.new("TextButton")
			local SliderValue = Instance.new("TextLabel")

			SliderFrame.Parent = parent or tabContent
			SliderFrame.BackgroundColor3 = akdo.Setting.Properties.ButtonColor
			SliderFrame.Size = akdo.Setting.Properties.ButtonSize
			SliderFrame.ClipsDescendants = true
			addCorner(SliderFrame, akdo.Setting.ElementCorner)

			CanvasGroup.Parent = SliderFrame
			CanvasGroup.BackgroundColor3 = akdo.Setting.Properties.BackgroundColor
			CanvasGroup.Position = UDim2.new(0.317, 0, 0.267, 0)
			CanvasGroup.Size = UDim2.new(0.561, 0, 0.452, 0)
			addCorner(CanvasGroup, UDim.new(0.5, 0))
			addStroke(CanvasGroup, 1, akdo.Setting.Properties.Background_Border_Color)

			FillSlider.Parent = CanvasGroup
			FillSlider.BackgroundColor3 = akdo.Setting.Properties.TextColor
			FillSlider.Size = UDim2.new(0, 0, 1, 0)
			addCorner(FillSlider, UDim.new(0.5, 0))

			Trigger.Parent = CanvasGroup
			Trigger.BackgroundTransparency = 1
			Trigger.Size = UDim2.new(1, 0, 1, 0)
			Trigger.TextTransparency = 1

			SliderValue.Parent = CanvasGroup
			SliderValue.BackgroundTransparency = 1
			SliderValue.Position = UDim2.new(0, 0, 0.06, 0)
			SliderValue.Size = UDim2.new(1, 0, 1, 0)
			SliderValue.Text = "0"
			SliderValue.TextColor3 = akdo.Setting.Properties.TextColor
			SliderValue.TextScaled = true
			addStroke(SliderValue, 1.5, akdo.Setting.Properties.Background_Border_Color)

			SliderText.BackgroundTransparency = 1
			SliderText.Parent = SliderFrame
			SliderText.Size = UDim2.new(0.293, 0, 1, 0)
			SliderText.Text = name or "Slider"
			SliderText.TextColor3 = akdo.Setting.Properties.TextColor
			SliderText.TextScaled = true
			SliderText.TextXAlignment = Enum.TextXAlignment.Left

			local Image = Instance.new("ImageButton")
			Image.Parent = SliderFrame
			Image.BackgroundTransparency = 1
			Image.Position = akdo.Setting.Image.InfoImagePOS
			Image.Size = akdo.Setting.Image.ImageSize
			Image.Image = "http://www.roblox.com/asset/?id=6026568210"
			Image.ImageColor3 = akdo.Setting.Properties.TextColor

			if Info then
				if Info == "" then
					SliderText.Size = UDim2.new(0.3, 0, 1, 0)
					CanvasGroup.Size = UDim2.new(0.642, 0, 0.4519, 0)
					Image:Destroy()
				else
					Image.MouseButton1Click:Connect(function()
						TextInfo.Text = Info
						if InfoFrame.Size.Y ~= UDim2.new(0, 0, 0.148, 0) then
							InfoFrame.Visible = true
							local tweenSize = TweenService:Create(InfoFrame, akdo.Setting.TweenInfo, {Size = UDim2.new(0.7133, 0, 0.148, 0)})
							tweenSize:Play()
						end
					end)
				end
			else
				SliderText.Size = UDim2.new(0.3, 0, 1, 0)
				CanvasGroup.Size = UDim2.new(0.642, 0, 0.4519, 0)
				Image:Destroy()
			end

			local function UpdateSlider(mouseX)
				local sliderPosX = Trigger.AbsolutePosition.X
				local sliderSizeX = Trigger.AbsoluteSize.X
				local output = math.clamp((mouseX - sliderPosX) / sliderSizeX, 0, 1)

				local MaxV = Max or 500
				local MinV = Min or 0

				local Value = output * (MaxV - MinV) + MinV

				local tween = TweenService:Create(FillSlider, akdo.Setting.TweenInfo, {Size = UDim2.new(output, 0, 1, 0)})
				tween:Play()

				SliderValue.Text = tostring(math.floor(Value))
				callback(Value)
			end

			local isDragging = false

			local function startDrag(input)
				isDragging = true
				UpdateSlider(input.Position.X)
			end

			local function stopDrag(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					isDragging = false
				end
			end

			Trigger.MouseButton1Down:Connect(startDrag)
			Trigger.TouchTap:Connect(startDrag)

			UserInputService.InputChanged:Connect(function(input)
				if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
					UpdateSlider(input.Position.X)
				end
			end)

			UserInputService.InputEnded:Connect(stopDrag)

			return SF
		end

		function EI:addTextBox(name, Info, placeholderText, callback, parent, stat, onlyNumbers, onlyLetters)
			local callback = callback or function() end
			local TextBoxFrame = Instance.new("Frame")
			local TextBox = Instance.new("TextBox")
			local Text = Instance.new("TextLabel")

			if parent then
				if parent == "" then
					TextBoxFrame.Parent = tabContent
				else
					TextBoxFrame.Parent = parent
				end	
			else
				TextBoxFrame.Parent = tabContent
			end
			TextBoxFrame.BackgroundColor3 = Color3.fromRGB(10,10,10)
			TextBoxFrame.Size = akdo.Setting.Properties.ButtonSize
			addCorner(TextBoxFrame, akdo.Setting.ElementCorner)

			TextBox.Parent = TextBoxFrame
			TextBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			TextBox.Position = UDim2.new(0.693, 0,0, 0)
			TextBox.Size = UDim2.new(0.293, 0,0.989, 0)
			TextBox.PlaceholderColor3 = akdo.Setting.Properties.TextColor
			TextBox.PlaceholderText = placeholderText or ""
			TextBox.TextColor3 = akdo.Setting.Properties.TextColor
			TextBox.TextScaled = true
			addCorner(TextBox, UDim.new(0.15,0))

			Text.Parent = TextBoxFrame
			Text.BackgroundTransparency = 1
			Text.Size = UDim2.new(0.662, 0, 1, 0)
			Text.Font = Enum.Font.SourceSans
			Text.Text = name or "TextBox"
			Text.TextColor3 = akdo.Setting.Properties.TextColor
			Text.TextScaled = true
			Text.TextXAlignment = Enum.TextXAlignment.Left

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
				TextBox.Position = UDim2.new(0.584, 0,0, 0)
				Text.Size = UDim2.new(0.584, 0,1, 0)

				local Image = Instance.new("ImageButton")
				Image.Parent = TextBoxFrame
				Image.BackgroundTransparency = 1
				Image.Position = akdo.Setting.Image.InfoImagePOS
				Image.Size = akdo.Setting.Image.ImageSize
				Image.Image = "http://www.roblox.com/asset/?id=6026568210"
				Image.ImageColor3 = akdo.Setting.Properties.TextColor
				Image.MouseButton1Click:Connect(function()
					TextInfo.Text = Info
					if InfoFrame.Size.Y ~= {0.148, 0} then
						InfoFrame.Visible = true
						local tweenSize = TweenService:Create(InfoFrame, akdo.Setting.TweenInfo, {Size = UDim2.new(0.7133, 0,0.148, 0)})
						tweenSize:Play()
					end
				end)
			end
		end

		function EI:addDropdownAndToggle(name, items, itemsPerRow, callback, parent)
			callback = callback or function() end

			local DTFrame = Instance.new("Frame")
			local DropdownButton = Instance.new("TextButton")
			local DropdownImage = Instance.new("ImageButton")
			local toggleButton = Instance.new("ImageButton")
			local DropdownList = Instance.new("ScrollingFrame")
			local UIGridLayout = Instance.new("UIGridLayout")

			DTFrame.Parent = parent or tabContent
			DTFrame.BackgroundColor3 = akdo.Setting.Properties.ButtonColor
			DTFrame.Size = akdo.Setting.Properties.ButtonSize
			addCorner(DTFrame, akdo.Setting.ElementCorner)

			DropdownButton.Parent = DTFrame
			DropdownButton.BackgroundTransparency = 1
			DropdownButton.Size = akdo.Setting.TextSize.Text2
			DropdownButton.Text = name or "Dropdown"
			DropdownButton.TextColor3 = akdo.Setting.Properties.TextColor
			DropdownButton.TextScaled = true
			DropdownButton.TextXAlignment = Enum.TextXAlignment.Left

			DropdownImage.Name = "DImageButton"
			DropdownImage.Parent = DTFrame
			DropdownImage.BackgroundTransparency = 1
			DropdownImage.Position = UDim2.new(0.9, 0,0, 0)
			DropdownImage.Size = UDim2.new(0.1, 0,1, 0)
			DropdownImage.Image = "http://www.roblox.com/asset/?id=6031090994"
			DropdownImage.ImageColor3 = akdo.Setting.Properties.TextColor

			toggleButton.Parent = DTFrame
			toggleButton.BackgroundTransparency = 1
			toggleButton.Position = UDim2.new(0.8, 0, 0, 0)
			toggleButton.Size = UDim2.new(0.1, 0, 1, 0)
			toggleButton.Image = "http://www.roblox.com/asset/?id=6031068433"
			toggleButton.ImageColor3 = akdo.Setting.Properties.TextColor 


			DropdownList.Parent = parent or tabContent
			DropdownList.BackgroundColor3 = akdo.Setting.Properties.BackgroundColor
			DropdownList.Position = UDim2.new(0, 0, 1, 0)
			DropdownList.Size = UDim2.new(1, 0, 0, 0)
			DropdownList.Visible = false
			DropdownList.ScrollBarThickness = 4
			DropdownList.ScrollingDirection = Enum.ScrollingDirection.Y
			addCorner(DropdownList, akdo.Setting.ElementCorner)

			UIGridLayout.Parent = DropdownList
			UIGridLayout.CellSize = UDim2.new(1 / itemsPerRow, -10, 0, 30)
			UIGridLayout.CellPadding = UDim2.new(0, 5, 0, 5)
			UIGridLayout.FillDirection = Enum.FillDirection.Horizontal

			DropdownButton.MouseButton1Click:Connect(function()
				if DropdownList.Visible then
					TweenService:Create(DropdownImage, akdo.Setting.TweenInfo, {Rotation = DropdownImage.Rotation - 90}):Play()
					TweenService:Create(DropdownList, akdo.Setting.TweenInfo, {Size = UDim2.new(0.95, 0, 0, 0)}):Play()
					wait(0.2)
					DropdownList.Visible = false
				else
					local numRows = math.ceil(#items / itemsPerRow)
					local itemHeight = 35
					local newHeight = numRows * itemHeight
					local maxHeight = 100
					local finalHeight = math.min(newHeight, maxHeight)
					DropdownList.CanvasSize = UDim2.new(1, 0, 0, newHeight)
					DropdownList.Visible = true
					TweenService:Create(DropdownImage, akdo.Setting.TweenInfo, {Rotation = DropdownImage.Rotation + 90}):Play()
					TweenService:Create(DropdownList, akdo.Setting.TweenInfo, {Size = UDim2.new(0.95, 0, 0, finalHeight)}):Play()
				end
			end)

			DropdownImage.MouseButton1Click:Connect(function() 
				if DropdownList.Visible then
					TweenService:Create(DropdownImage, akdo.Setting.TweenInfo, {Rotation = DropdownImage.Rotation - 90}):Play()
					TweenService:Create(DropdownList, akdo.Setting.TweenInfo, {Size = UDim2.new(0.95, 0, 0, 0)}):Play()
					wait(0.2)
					DropdownList.Visible = false
				else
					local numRows = math.ceil(#items / itemsPerRow)
					local itemHeight = 35
					local newHeight = numRows * itemHeight
					local maxHeight = 100
					local finalHeight = math.min(newHeight, maxHeight)
					DropdownList.CanvasSize = UDim2.new(1, 0, 0, newHeight)
					DropdownList.Visible = true
					TweenService:Create(DropdownImage, akdo.Setting.TweenInfo, {Rotation = DropdownImage.Rotation + 90}):Play()
					TweenService:Create(DropdownList, akdo.Setting.TweenInfo, {Size = UDim2.new(0.95, 0, 0, finalHeight)}):Play()
				end
			end)

			local Item
			local toggled = false
			toggleButton.MouseButton1Click:Connect(function() 
				if toggled then
					toggled = not toggled
					toggleButton.Image = "http://www.roblox.com/asset/?id=6031068433"
					callback(toggled, Item)
				else
					toggled = not toggled
					toggleButton.Image = "http://www.roblox.com/asset/?id=6031068426"
					callback(toggled, Item)
				end
			end)

			for _, item in pairs(items) do
				local ItemButton = Instance.new("TextButton")
				ItemButton.Parent = DropdownList
				ItemButton.BackgroundColor3 = akdo.Setting.Properties.ButtonColor
				ItemButton.Text = item
				ItemButton.Size = UDim2.new(1, 0, 0, 30)
				ItemButton.TextColor3 = akdo.Setting.Properties.TextColor
				ItemButton.TextScaled = true

				ItemButton.MouseButton1Click:Connect(function()
					DropdownButton.Text = name..": "..item
					TweenService:Create(DropdownImage, akdo.Setting.TweenInfo, {Rotation = DropdownImage.Rotation - 90}):Play()
					TweenService:Create(DropdownList, akdo.Setting.TweenInfo, {Size = UDim2.new(0.95, 0, 0, 0)}):Play()
					wait(0.2)
					DropdownList.Visible = false
					Item = item
					callback(toggled, item)
				end)
				addCorner(ItemButton, akdo.Setting.ElementCorner)
			end

			return DTFrame
		end

		function EI:addSliderAndTextBox(name, Info, PlaceholderText, Min, Max, callback, stat, onlyLetters, onlyNumbers, parent)
			local callback = callback or function() end

			local STFrame = Instance.new("Frame")
			local TextBox = Instance.new("TextBox")
			local Text = Instance.new("TextLabel")
			local CanvasGroup = Instance.new("CanvasGroup")
			local FillSlider = Instance.new("Frame")
			local Trigger = Instance.new("TextButton")
			local SliderValue = Instance.new("TextLabel")

			STFrame.Parent = parent or tabContent
			STFrame.BackgroundColor3 = akdo.Setting.Properties.ButtonColor
			STFrame.Size = akdo.Setting.Properties.ButtonSize
			addCorner(STFrame, akdo.Setting.ElementCorner)

			TextBox.Parent = STFrame
			TextBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			TextBox.Position = UDim2.new(0.715, 0, 0, 0)
			TextBox.Size = UDim2.new(0.285, 0, 1, 0)
			TextBox.PlaceholderColor3 = akdo.Setting.Properties.TextColor
			TextBox.PlaceholderText = PlaceholderText or ""
			TextBox.TextColor3 = akdo.Setting.Properties.TextColor
			TextBox.TextScaled = true
			addCorner(TextBox, UDim.new(0.15, 0))

			Text.Name = "text"
			Text.Parent = STFrame
			Text.BackgroundTransparency = 1
			Text.Size = UDim2.new(0.266, 0, 1, 0)
			Text.Font = Enum.Font.SourceSans
			Text.Text = name or "ST"
			Text.TextColor3 = akdo.Setting.Properties.TextColor
			Text.TextScaled = true
			Text.TextXAlignment = Enum.TextXAlignment.Left

			CanvasGroup.Parent = STFrame
			CanvasGroup.BackgroundColor3 = akdo.Setting.Properties.BackgroundColor
			CanvasGroup.Position = UDim2.new(0.315, 0, 0.26, 0)
			CanvasGroup.Size = UDim2.new(0.375, 0, 0.45, 0)
			addCorner(CanvasGroup, UDim.new(0.5, 0))
			addStroke(CanvasGroup, 1, akdo.Setting.Properties.Background_Border_Color)

			FillSlider.Parent = CanvasGroup
			FillSlider.BackgroundColor3 = akdo.Setting.Properties.TextColor
			FillSlider.Size = UDim2.new(0, 0, 1, 0)
			addCorner(FillSlider, UDim.new(0.5, 0))

			Trigger.Name = "trig"
			Trigger.Parent = CanvasGroup
			Trigger.BackgroundTransparency = 1
			Trigger.Size = UDim2.new(1, 0, 1, 0)
			Trigger.TextTransparency = 1

			SliderValue.Parent = CanvasGroup
			SliderValue.BackgroundTransparency = 1
			SliderValue.Size = UDim2.new(1, 0, 1, 0)
			SliderValue.Text = "0"
			SliderValue.TextColor3 = akdo.Setting.Properties.TextColor
			SliderValue.TextScaled = true
			addStroke(SliderValue, 1.5, akdo.Setting.Properties.Background_Border_Color)

			local function UpdateSlider(mouseX)
				local sliderPosX = Trigger.AbsolutePosition.X
				local sliderSizeX = Trigger.AbsoluteSize.X
				local output = math.clamp((mouseX - sliderPosX) / sliderSizeX, 0, 1)
				local Value = output * (Max - Min) + Min

				local tween = game.TweenService:Create(FillSlider, akdo.Setting.TweenInfo, {Size = UDim2.new(output, 0, 1, 0)})
				tween:Play()

				SliderValue.Text = tostring(math.floor(Value))
				callback(Value)
			end

			local isDragging = false
			Trigger.MouseButton1Down:Connect(function()
				isDragging = true
				while isDragging do
					local mouse = UserInputService:GetMouseLocation().X
					UpdateSlider(mouse)
					wait()
				end
			end)

			UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					isDragging = false
				end
			end)

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
				CanvasGroup.Size = UDim2.new(0.335, 0,0.45, 0)
				TextBox.Position = UDim2.new(0.665, 0,0, 0)
				TextBox.Size = UDim2.new(0.211, 0,1, 0)
				Text.Size = UDim2.new(0.584, 0,1, 0)

				local Image = Instance.new("ImageButton")
				Image.Parent = STFrame
				Image.BackgroundTransparency = 1
				Image.Position = akdo.Setting.Image.InfoImagePOS
				Image.Size = akdo.Setting.Image.ImageSize
				Image.Image = "http://www.roblox.com/asset/?id=6026568210"
				Image.ImageColor3 = akdo.Setting.Properties.TextColor
				Image.MouseButton1Click:Connect(function()
					TextInfo.Text = Info
					if InfoFrame.Size.Y ~= {0.148, 0} then
						InfoFrame.Visible = true
						local tweenSize = TweenService:Create(InfoFrame, akdo.Setting.TweenInfo, {Size = UDim2.new(0.7133, 0,0.148, 0)})
						tweenSize:Play()
					end
				end)
			end
		end

--[[	function akdo:updateSliderAndTextBox(parent, name, Info, placeholderText, Min, Max, callback)
			local callback = callback or function() end
			local TextBox = parent:FindFirstChild("TextBox")
			local TextLabel = parent:FindFirstChild("TextLabel")
			local image = parent:FindFirstChild("ImageButton")
			local Trigger = parent:FindFirstChild("trig")
			local CanvasGroup = parent:FindFirstChild("CanvasGroup")
			local FillSlider = CanvasGroup:FindFirstChild("Frame")
			local SliderValue = CanvasGroup:FindFirstChild("TextLabel")


			if name and name ~= "" then
				TextBox.Text = TextBox or TextBox.Text
			end

			if placeholderText and placeholderText ~= "" and TextBox then
				TextBox.PlaceholderText = placeholderText
			end

			if Info and Info ~= "" then
				if image then
					image.MouseButton1Click:Connect(function()
						TextInfo.Text = Info
					end)
				else
					local Image = Instance.new("ImageButton")
					Image.Parent = parent
					Image.BackgroundTransparency = 1
					Image.Position = akdo.Setting.Image.InfoImagePOS
					Image.Size = akdo.Setting.Image.ImageSize
					Image.Image = "http://www.roblox.com/asset/?id=6026568210"
					Image.ImageColor3 = akdo.Setting.Properties.TextColor
					Image.MouseButton1Click:Connect(function()
						TextInfo.Text = Info
						if InfoFrame.Size.Y ~= {0.148, 0} then
							InfoFrame.Visible = true
							local tweenSize = TweenService:Create(InfoFrame, akdo.Setting.TweenInfo, {Size = UDim2.new(0.7133, 0,0.148, 0)})
							tweenSize:Play()
						end
					end)
				end
			end

			local Value
			local function UpdateSlider(mouseX)
				local sliderPosX = Trigger.AbsolutePosition.X
				local sliderSizeX = Trigger.AbsoluteSize.X
				local output = math.clamp((mouseX - sliderPosX) / sliderSizeX, 0, 1)

				local Value = output * (Max - Min) + Min

				local tween = game.TweenService:Create(FillSlider, akdo.Setting.TweenInfo, {Size = UDim2.new(output, 0, 1, 0)})
				tween:Play()

				SliderValue.Text = tostring(math.floor(Value))
				callback(Value)
			end

			local isDragging = false

			Trigger.MouseButton1Down:Connect(function ()
				isDragging = true

				while isDragging do
					local mouse = UserInputService:GetMouseLocation().X
					UpdateSlider(mouse)

					wait()
				end
			end)
		end

		function akdo:updateDropdownAndToggle(parent, name, items, itemsPerRow, callback)
			local callback = callback or function() end
			local DropdownButton = parent:FindFirstChild("TextButton")
			local DropdownList = parent:FindFirstChild("ScrollingFrame")
			local DropdownImage = parent:FindFirstChild("DImageButton")
			local ToggleButton = parent:FindFirstChild("ImageButton")

			DropdownButton.Text = name or DropdownButton.Text

			DropdownButton.MouseButton1Click:Connect(function()
				if DropdownList.Visible then
					TweenService:Create(DropdownImage, akdo.Setting.TweenInfo, {Rotation = DropdownImage.Rotation - 90}):Play()
					TweenService:Create(DropdownList, akdo.Setting.TweenInfo, {Size = UDim2.new(0.95, 0, 0, 0)}):Play()
					wait(0.2)
					DropdownList.Visible = false
				else
					local numRows = math.ceil(#items / itemsPerRow)
					local itemHeight = 35
					local newHeight = numRows * itemHeight
					local maxHeight = 100
					local finalHeight = math.min(newHeight, maxHeight)
					DropdownList.CanvasSize = UDim2.new(1, 0, 0, newHeight)
					DropdownList.Visible = true
					TweenService:Create(DropdownImage, akdo.Setting.TweenInfo, {Rotation = DropdownImage.Rotation + 90}):Play()
					TweenService:Create(DropdownList, akdo.Setting.TweenInfo, {Size = UDim2.new(0.95, 0, 0, finalHeight)}):Play()
				end
			end)

			local Item
			local toggled = false
			ToggleButton.MouseButton1Click:Connect(function() 
				if toggled then
					toggled = not toggled
					ToggleButton.Image = "http://www.roblox.com/asset/?id=6031068433"
					callback(toggled, Item)
				else
					toggled = not toggled
					ToggleButton.Image = "http://www.roblox.com/asset/?id=6031068426"
					callback(toggled, Item)
				end
			end)

			for _, item in pairs(items) do
				local ItemButton = Instance.new("TextButton")
				ItemButton.Parent = DropdownList
				ItemButton.BackgroundColor3 = akdo.Setting.Properties.ButtonColor
				ItemButton.Text = item
				ItemButton.Size = UDim2.new(1, 0, 0, 30)
				ItemButton.TextColor3 = akdo.Setting.Properties.TextColor
				ItemButton.TextScaled = true

				ItemButton.MouseButton1Click:Connect(function()
					DropdownButton.Text = name..": "..item
					TweenService:Create(DropdownImage, akdo.Setting.TweenInfo, {Rotation = DropdownImage.Rotation - 90}):Play()
					TweenService:Create(DropdownList, akdo.Setting.TweenInfo, {Size = UDim2.new(0.95, 0, 0, 0)}):Play()
					wait(0.2)
					DropdownList.Visible = false
					Item = item
					callback(toggled, item)
				end)
				addCorner(ItemButton, akdo.Setting.ElementCorner)
			end
		end	]]

		function EI:addLabel(text, parent)
			local label = Instance.new("TextLabel")
			label.Size = akdo.Setting.Properties.ButtonSize
			label.Text = text or "Label"
			label.TextColor3 = akdo.Setting.Properties.TextColor
			label.TextScaled = true
			label.BackgroundTransparency = 1
			label.Parent = parent or tabContent
		end

		function EI:addSection(text, parent)
			local Section = Instance.new("TextLabel")
			Section.Size = akdo.Setting.Properties.ButtonSize
			Section.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			Section.Text = text or "Section"
			Section.TextColor3 = akdo.Setting.Properties.TextColor
			Section.TextScaled = true
			Section.Parent = parent or tabContent
			addCorner(Section, akdo.Setting.ElementCorner)
		end

		function EI:addRow(FramePerRow, lines, parent)
			local row = Instance.new("Frame")
			row.Name = "RFrame"
			row.Size = UDim2.new(0.95, 0, 0, 30)
			row.BackgroundTransparency = 1
			row.Parent = parent or tabContent

			local GridLayout = Instance.new("UIGridLayout")
			GridLayout.CellPadding = UDim2.new(0.02, 0, 0.02, 0)
			GridLayout.FillDirection = Enum.FillDirection.Horizontal
			GridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			GridLayout.VerticalAlignment = Enum.VerticalAlignment.Top
			GridLayout.SortOrder = Enum.SortOrder.LayoutOrder
			GridLayout.Parent = row

			local function update()
				local buttonCount = 0
				for _, child in ipairs(row:GetChildren()) do
					if child:IsA("Frame") or child:IsA("TextButton") or child:IsA("ImageButton") then
						buttonCount = buttonCount + 1
					end
				end

				local actualFramePerRow = FramePerRow and math.min(buttonCount, FramePerRow) or buttonCount
				local totalPaddingScale = (actualFramePerRow - 1) * GridLayout.CellPadding.X.Scale
				local availableWidthScale = 1 - totalPaddingScale
				local cellWidthScale = availableWidthScale / actualFramePerRow

				local rowHeight = 1
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
		end

		return EI
	end

	return TabsAndStyles
end

local fram = akdo:createFrame()
local tab = fram:addTab()
local tab = fram:addTab()
local tab = fram:addTab()
local button = tab:addButton()
local button = tab:addButton()
local button = tab:addButton()

return akdo
