-- ⚡ team chams with rejoin button
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer

-- apply full-body highlight
local function applyChamsToCharacter(player, character)
	if player == LocalPlayer then return end
	if not character or not character:IsA("Model") then return end

	local old = character:FindFirstChild("ChamsHighlight")
	if old then old:Destroy() end

	local highlight = Instance.new("Highlight")
	highlight.Name = "ChamsHighlight"
	highlight.FillColor = player.Team and player.Team.TeamColor.Color or Color3.fromRGB(255, 255, 255)
	highlight.OutlineColor = Color3.new(0, 0, 0)
	highlight.FillTransparency = 0.4
	highlight.OutlineTransparency = 0.3
	highlight.Adornee = character
	highlight.Parent = character
end

-- setup players
local function setupPlayer(player)
	if player == LocalPlayer then return end

	player:GetPropertyChangedSignal("Team"):Connect(function()
		if player.Character then applyChamsToCharacter(player, player.Character) end
	end)

	player.CharacterAdded:Connect(function(char)
		repeat RunService.Heartbeat:Wait() until char:FindFirstChild("HumanoidRootPart")
		applyChamsToCharacter(player, char)
	end)

	if player.Character then
		applyChamsToCharacter(player, player.Character)
	end
end

-- apply to current and future players
for _, player in ipairs(Players:GetPlayers()) do setupPlayer(player) end
Players.PlayerAdded:Connect(setupPlayer)
