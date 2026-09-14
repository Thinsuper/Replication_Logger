local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicationEvent = ReplicatedStorage:WaitForChild("Replication")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

if game.PlaceId ~= 10449761463 then
    Player:Kick("wrong game to use this pal")
end

for _, UI in PlayerGui:GetChildren() do
	if UI:IsA("ScreenGui") and (UI.Name == "ReplicationLogger" or UI.Name == "ReplicationLogger") then
		UI:Destroy()
	end
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ReplicationLogger"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.fromOffset(650, 440)
Frame.Position = UDim2.new(0, 20, 0.5, -220)
Frame.BackgroundColor3 = Color3.fromRGB(22, 22, 25)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 8)
Corner.Parent = Frame

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(55, 55, 60)
Stroke.Thickness = 1
Stroke.Parent = Frame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -305, 0, 34)
Title.Position = UDim2.fromOffset(10, 0)
Title.BackgroundTransparency = 1
Title.Text = "Replication Logger"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextColor3 = Color3.fromRGB(235, 235, 235)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Frame

local ButtonFrame = Instance.new("Frame")
ButtonFrame.Size = UDim2.fromOffset(290, 34)
ButtonFrame.Position = UDim2.new(1, -295, 0, 0)
ButtonFrame.BackgroundTransparency = 1
ButtonFrame.Parent = Frame

local function createButton(Text, Position, Width)
	local Button = Instance.new("TextButton")
	Button.Size = UDim2.fromOffset(Width, 25)
	Button.Position = Position
	Button.BackgroundColor3 = Color3.fromRGB(42, 42, 47)
	Button.BorderSizePixel = 0
	Button.TextColor3 = Color3.fromRGB(220, 220, 220)
	Button.Text = Text
	Button.Font = Enum.Font.GothamMedium
	Button.TextSize = 11
	Button.AutoButtonColor = true
	Button.Parent = ButtonFrame

	local ButtonCorner = Instance.new("UICorner")
	ButtonCorner.CornerRadius = UDim.new(0, 5)
	ButtonCorner.Parent = Button

	return Button
end

local PauseButton = createButton("Pause", UDim2.fromOffset(0, 4), 65)
local ClearButton = createButton("Clear", UDim2.fromOffset(70, 4), 65)
local SaveButton = createButton("Save", UDim2.fromOffset(140, 4), 65)
local BlacklistButton = createButton("Blacklist", UDim2.fromOffset(210, 4), 65)

local Line = Instance.new("Frame")
Line.Size = UDim2.new(1, -20, 0, 1)
Line.Position = UDim2.fromOffset(10, 34)
Line.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
Line.BorderSizePixel = 0
Line.Parent = Frame

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, -20, 1, -48)
ScrollingFrame.Position = UDim2.fromOffset(10, 43)
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 19)
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.CanvasSize = UDim2.new()
ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollingFrame.ScrollBarThickness = 5
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 85)
ScrollingFrame.Parent = Frame

local ScrollCorner = Instance.new("UICorner")
ScrollCorner.CornerRadius = UDim.new(0, 6)
ScrollCorner.Parent = ScrollingFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = ScrollingFrame

local Padding = Instance.new("UIPadding")
Padding.PaddingTop = UDim.new(0, 6)
Padding.PaddingBottom = UDim.new(0, 6)
Padding.PaddingLeft = UDim.new(0, 6)
Padding.PaddingRight = UDim.new(0, 6)
Padding.Parent = ScrollingFrame

local Blacklist = {
	Effect = {},
	Type = {},
}

local BlacklistFrame = Instance.new("Frame")
BlacklistFrame.Size = UDim2.fromOffset(300, 350)
BlacklistFrame.Position = UDim2.new(1, 10, 0, 45)
BlacklistFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 25)
BlacklistFrame.BorderSizePixel = 0
BlacklistFrame.Visible = false
BlacklistFrame.Parent = Frame

local BlacklistCorner = Instance.new("UICorner")
BlacklistCorner.CornerRadius = UDim.new(0, 8)
BlacklistCorner.Parent = BlacklistFrame

local BlacklistStroke = Instance.new("UIStroke")
BlacklistStroke.Color = Color3.fromRGB(55, 55, 60)
BlacklistStroke.Thickness = 1
BlacklistStroke.Parent = BlacklistFrame

local BlacklistTitle = Instance.new("TextLabel")
BlacklistTitle.Size = UDim2.new(1, -20, 0, 35)
BlacklistTitle.Position = UDim2.fromOffset(10, 0)
BlacklistTitle.BackgroundTransparency = 1
BlacklistTitle.Text = "Blacklist"
BlacklistTitle.TextColor3 = Color3.fromRGB(235, 235, 235)
BlacklistTitle.Font = Enum.Font.GothamBold
BlacklistTitle.TextSize = 15
BlacklistTitle.TextXAlignment = Enum.TextXAlignment.Left
BlacklistTitle.Parent = BlacklistFrame

local BlacklistInput = Instance.new("TextBox")
BlacklistInput.Size = UDim2.new(1, -80, 0, 28)
BlacklistInput.Position = UDim2.fromOffset(10, 40)
BlacklistInput.BackgroundColor3 = Color3.fromRGB(30, 30, 34)
BlacklistInput.BorderSizePixel = 0
BlacklistInput.PlaceholderText = "Effect / Type"
BlacklistInput.PlaceholderColor3 = Color3.fromRGB(110, 110, 115)
BlacklistInput.Text = ""
BlacklistInput.TextColor3 = Color3.fromRGB(220, 220, 220)
BlacklistInput.Font = Enum.Font.Code
BlacklistInput.TextSize = 12
BlacklistInput.ClearTextOnFocus = false
BlacklistInput.Parent = BlacklistFrame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 5)
InputCorner.Parent = BlacklistInput

local AddBlacklist = Instance.new("TextButton")
AddBlacklist.Size = UDim2.fromOffset(60, 28)
AddBlacklist.Position = UDim2.new(1, -70, 0, 40)
AddBlacklist.BackgroundColor3 = Color3.fromRGB(42, 42, 47)
AddBlacklist.BorderSizePixel = 0
AddBlacklist.Text = "Add"
AddBlacklist.TextColor3 = Color3.fromRGB(220, 220, 220)
AddBlacklist.Font = Enum.Font.GothamMedium
AddBlacklist.TextSize = 11
AddBlacklist.Parent = BlacklistFrame

local AddCorner = Instance.new("UICorner")
AddCorner.CornerRadius = UDim.new(0, 5)
AddCorner.Parent = AddBlacklist

local BlacklistList = Instance.new("ScrollingFrame")
BlacklistList.Size = UDim2.new(1, -20, 1, -80)
BlacklistList.Position = UDim2.fromOffset(10, 75)
BlacklistList.BackgroundColor3 = Color3.fromRGB(16, 16, 19)
BlacklistList.BorderSizePixel = 0
BlacklistList.AutomaticCanvasSize = Enum.AutomaticSize.Y
BlacklistList.CanvasSize = UDim2.new()
BlacklistList.ScrollBarThickness = 4
BlacklistList.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 85)
BlacklistList.Parent = BlacklistFrame

local ListCorner = Instance.new("UICorner")
ListCorner.CornerRadius = UDim.new(0, 6)
ListCorner.Parent = BlacklistList

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 4)
ListLayout.Parent = BlacklistList

local Paused = false
local EntryCount = 0

local function formatKey(k)
	if typeof(k) == "number" then
		return "[" .. k .. "]"
	end

	if typeof(k) ~= "string" then
		return tostring(k)
	end

	if k == "end" or k:find("%W") then
		return string.format('["%s"]', k)
	end

	return k
end

local function formatNumber(value)
	return string.format("%.3f", value):gsub("0+$", ""):gsub("%.$", "")
end

local function tableToString(value, indent)
	indent = indent or 0

	if typeof(value) == "table" then
		local parts = {}
		local spacing = string.rep("    ", indent)
		local nextSpacing = string.rep("    ", indent + 1)

		for k, v in pairs(value) do
			table.insert(parts, nextSpacing .. formatKey(k) .. " = " .. tableToString(v, indent + 1))
		end

		if #parts == 0 then
			return "{}"
		end

		return "{\n" .. table.concat(parts, ",\n") .. "\n" .. spacing .. "}"
	elseif typeof(value) == "Instance" then
		return value:GetFullName()
	elseif typeof(value) == "string" then
		return string.format("%q", value)
	elseif typeof(value) == "Vector3" then
		return "Vector3.new(" .. formatNumber(value.X) .. ", " .. formatNumber(value.Y) .. ", " .. formatNumber(value.Z) .. ")"
	elseif typeof(value) == "CFrame" then
		return "CFrame.new(" .. formatNumber(value.X) .. ", " .. formatNumber(value.Y) .. ", " .. formatNumber(value.Z) .. ")"
	elseif typeof(value) == "Color3" then
		return "Color3.new(" .. formatNumber(value.R) .. ", " .. formatNumber(value.G) .. ", " .. formatNumber(value.B) .. ")"
	elseif typeof(value) == "NumberRange" then
		return "NumberRange.new(" .. formatNumber(value.Min) .. ", " .. formatNumber(value.Max) .. ")"
	else
		return tostring(value)
	end
end

local function hasEffectKey(tbl)
	if typeof(tbl) ~= "table" then
		return false
	end

	for k in pairs(tbl) do
		if k == "Effect" then
			return true
		end
	end

	return false
end

local function wrapWithEffectFirst(arg)
	if typeof(arg) == "table" then
		local parts = {}

		if hasEffectKey(arg) then
			table.insert(parts, "Effect = " .. tableToString(arg.Effect))

			for k, v in pairs(arg) do
				if k ~= "Effect" then
					table.insert(parts, formatKey(k) .. " = " .. tableToString(v))
				end
			end
		else
			table.insert(parts, 'Effect = ""')

			for k, v in pairs(arg) do
				table.insert(parts, formatKey(k) .. " = " .. tableToString(v))
			end
		end

		return "{\n    " .. table.concat(parts, ",\n    ") .. "\n}"
	end

	return "{\n    Effect = \"\",\n    " .. tableToString(arg) .. "\n}"
end

local function createEntry(text, valueToCopy)
	EntryCount += 1

	local Entry = Instance.new("Frame")
	Entry.Name = "Entry"
	Entry.Size = UDim2.new(1, -12, 0, 32)
	Entry.BackgroundColor3 = Color3.fromRGB(27, 27, 31)
	Entry.BorderSizePixel = 0
	Entry.LayoutOrder = EntryCount
	Entry.ClipsDescendants = true
	Entry.Parent = ScrollingFrame

	local EntryCorner = Instance.new("UICorner")
	EntryCorner.CornerRadius = UDim.new(0, 5)
	EntryCorner.Parent = Entry

	local EntryStroke = Instance.new("UIStroke")
	EntryStroke.Color = Color3.fromRGB(43, 43, 48)
	EntryStroke.Thickness = 1
	EntryStroke.Parent = Entry

	local Header = Instance.new("TextButton")
	Header.Size = UDim2.new(1, 0, 0, 32)
	Header.BackgroundTransparency = 1
	Header.Text = ""
	Header.Parent = Entry

	local Arrow = Instance.new("TextLabel")
	Arrow.Size = UDim2.fromOffset(22, 32)
	Arrow.Position = UDim2.fromOffset(4, 0)
	Arrow.BackgroundTransparency = 1
	Arrow.Text = ">"
	Arrow.TextColor3 = Color3.fromRGB(130, 130, 140)
	Arrow.Font = Enum.Font.Code
	Arrow.TextSize = 14
	Arrow.Parent = Header

	local Label = Instance.new("TextLabel")
	Label.Size = UDim2.new(1, -35, 0, 32)
	Label.Position = UDim2.fromOffset(28, 0)
	Label.BackgroundTransparency = 1
	Label.Text = text
	Label.TextColor3 = Color3.fromRGB(205, 205, 210)
	Label.Font = Enum.Font.Code
	Label.TextSize = 13
	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.TextTruncate = Enum.TextTruncate.AtEnd
	Label.Parent = Header

	local Data = Instance.new("TextLabel")
	Data.Name = "Data"
	Data.Size = UDim2.new(1, -20, 0, 0)
	Data.Position = UDim2.fromOffset(10, 36)
	Data.BackgroundColor3 = Color3.fromRGB(19, 19, 22)
	Data.BorderSizePixel = 0
	Data.Text = valueToCopy
	Data.TextColor3 = Color3.fromRGB(185, 185, 190)
	Data.Font = Enum.Font.Code
	Data.TextSize = 13
	Data.TextXAlignment = Enum.TextXAlignment.Left
	Data.TextYAlignment = Enum.TextYAlignment.Top
	Data.TextWrapped = false
	Data.AutomaticSize = Enum.AutomaticSize.Y
	Data.Visible = false
	Data.Active = true
	Data.Parent = Entry

	local DataPadding = Instance.new("UIPadding")
	DataPadding.PaddingTop = UDim.new(0, 8)
	DataPadding.PaddingBottom = UDim.new(0, 8)
	DataPadding.PaddingLeft = UDim.new(0, 8)
	DataPadding.PaddingRight = UDim.new(0, 8)
	DataPadding.Parent = Data

	local DataCorner = Instance.new("UICorner")
	DataCorner.CornerRadius = UDim.new(0, 4)
	DataCorner.Parent = Data

	local Expanded = false

	local function setExpanded(Value)
	Expanded = Value

	if Expanded then
		Arrow.Text = "v"
		Data.Visible = true
		Data.Size = UDim2.new(1, -20, 0, 0)

		task.defer(function()
			local Height = Data.AbsoluteSize.Y + 42

			TweenService:Create(Entry, TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
				Size = UDim2.new(1, -12, 0, Height)
			}):Play()
		end)
	else
		Arrow.Text = ">"

		TweenService:Create(Entry, TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
			Size = UDim2.new(1, -12, 0, 32)
		}):Play()

		task.delay(0.15, function()
			if not Expanded and Data.Parent then
				Data.Visible = false
			end
		end)
	end
end

	Header.MouseButton1Click:Connect(function()
		setExpanded(not Expanded)
	end)

	Data.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			setclipboard(valueToCopy)

			local OldText = Data.Text
			Data.Text = "Copied!"

			task.delay(0.5, function()
				if Data and Data.Parent then
					Data.Text = OldText
				end
			end)
		end
	end)
end

local function updateBlacklist()
	for _, Child in ipairs(BlacklistList:GetChildren()) do
		if Child:IsA("Frame") then
			Child:Destroy()
		end
	end

	for Kind, Values in pairs(Blacklist) do
		for Value in pairs(Values) do
			local Entry = Instance.new("Frame")
			Entry.Size = UDim2.new(1, -8, 0, 28)
			Entry.BackgroundColor3 = Color3.fromRGB(27, 27, 31)
			Entry.BorderSizePixel = 0
			Entry.Parent = BlacklistList

			local EntryCorner = Instance.new("UICorner")
			EntryCorner.CornerRadius = UDim.new(0, 5)
			EntryCorner.Parent = Entry

			local Label = Instance.new("TextLabel")
			Label.Size = UDim2.new(1, -40, 1, 0)
			Label.Position = UDim2.fromOffset(8, 0)
			Label.BackgroundTransparency = 1
			Label.Text = Kind .. ": " .. Value
			Label.TextColor3 = Color3.fromRGB(205, 205, 210)
			Label.Font = Enum.Font.Code
			Label.TextSize = 12
			Label.TextXAlignment = Enum.TextXAlignment.Left
			Label.Parent = Entry

			local Remove = Instance.new("TextButton")
			Remove.Size = UDim2.fromOffset(28, 28)
			Remove.Position = UDim2.new(1, -28, 0, 0)
			Remove.BackgroundTransparency = 1
			Remove.Text = "×"
			Remove.TextColor3 = Color3.fromRGB(255, 100, 100)
			Remove.Font = Enum.Font.GothamBold
			Remove.TextSize = 16
			Remove.Parent = Entry

			Remove.MouseButton1Click:Connect(function()
				Blacklist[Kind][Value] = nil
				updateBlacklist()
			end)
		end
	end
end

PauseButton.MouseButton1Click:Connect(function()
	Paused = not Paused

	if Paused then
		PauseButton.Text = "Resume"
		PauseButton.BackgroundColor3 = Color3.fromRGB(75, 55, 30)
	else
		PauseButton.Text = "Pause"
		PauseButton.BackgroundColor3 = Color3.fromRGB(42, 42, 47)
	end
end)

ClearButton.MouseButton1Click:Connect(function()
	for _, Child in ipairs(ScrollingFrame:GetChildren()) do
		if Child:IsA("Frame") and Child.Name == "Entry" then
			Child:Destroy()
		end
	end

	EntryCount = 0
	ScrollingFrame.CanvasPosition = Vector2.zero
end)

SaveButton.MouseButton1Click:Connect(function()
	local Logs = {}

	for _, Entry in ipairs(ScrollingFrame:GetChildren()) do
		if Entry:IsA("Frame") and Entry.Name == "Entry" then
			local Data = Entry:FindFirstChild("Data")

			if Data and Data.Text ~= "" then
				table.insert(Logs, Data.Text)
			end
		end
	end

	if #Logs == 0 then
		StarterGui:SetCore("SendNotification", {
			Title = "Replication Logger",
			Text = "No logs to save!",
			Duration = 3,
		})

		return
	end

	local Filename = 0

	local function findAvailableName()
		local Exists

		pcall(function()
			Exists = readfile("ReplicationLogs" .. Filename .. ".txt")
		end)

		if Exists then
			Filename += 1
			return findAvailableName()
		end
	end

	findAvailableName()

	local Content = table.concat(Logs, "\n")
	Content = Content:gsub("\n", "\r\n")

	writefile("ReplicationLogs" .. Filename .. ".txt", Content)

	StarterGui:SetCore("SendNotification", {
	   Title = "Replication Logger",
	   Text = "Logs saved successfully!\nReplicationLogs" .. Filename .. ".txt",
	   Icon = "rbxassetid://176572847",
	   Duration = 5,
    })
end)

AddBlacklist.MouseButton1Click:Connect(function()
	local Value = BlacklistInput.Text:gsub("^%s*(.-)%s*$", "%1")

	if Value == "" then
		return
	end

	local Effect = Value:match("^Effect:%s*(.+)$")
	local Type = Value:match("^Type:%s*(.+)$")

	if Effect then
		Blacklist.Effect[Effect] = true
	elseif Type then
		Blacklist.Type[Type] = true
	else
		Blacklist.Effect[Value] = true
	end

	BlacklistInput.Text = ""
	updateBlacklist()
end)

BlacklistButton.MouseButton1Click:Connect(function()
	BlacklistFrame.Visible = not BlacklistFrame.Visible
end)

local Dragging = false
local DragStart
local StartPosition

Title.InputBegan:Connect(function(Input)
	if Input.UserInputType == Enum.UserInputType.MouseButton1 then
		Dragging = true
		DragStart = Input.Position
		StartPosition = Frame.Position
	end
end)

UserInputService.InputChanged:Connect(function(Input)
	if Dragging and Input.UserInputType == Enum.UserInputType.MouseMovement then
		local Delta = Input.Position - DragStart

		Frame.Position = UDim2.new(
			StartPosition.X.Scale,
			StartPosition.X.Offset + Delta.X,
			StartPosition.Y.Scale,
			StartPosition.Y.Offset + Delta.Y
		)
	end
end)

UserInputService.InputEnded:Connect(function(Input)
	if Input.UserInputType == Enum.UserInputType.MouseButton1 then
		Dragging = false
	end
end)

ReplicationEvent.OnClientEvent:Connect(function(...)
	if Paused then
		return
	end

	local Args = {...}
	local Data = {}
	local Name = "Replication Effect"

	for _, Arg in ipairs(Args) do
		if typeof(Arg) == "table" then
			if Arg.Effect and Blacklist.Effect[tostring(Arg.Effect)] then
				return
			end

			if Arg.Type and Blacklist.Type[tostring(Arg.Type)] then
				return
			end

			Name = Arg.Effect or Arg.Type or Name
		end

		table.insert(Data, wrapWithEffectFirst(Arg))
	end

	createEntry(tostring(Name), table.concat(Data, "\n"))
end)
