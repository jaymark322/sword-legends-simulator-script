local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Scythe Simulator Made by Jacob", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})

local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")

-- Main Tab
local Tab = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

-- Auto Rebirth Toggle
Tab:AddToggle({
	Name = "Auto Rebirth",
	Default = false,
	Callback = function(Value)
		getgenv().Rebirth = Value
		
		if getgenv().Rebirth then
			print("Auto Rebirth enabled.")
		else
			print("Auto Rebirth disabled.")
		end

		while getgenv().Rebirth do
			local success, err = pcall(function()
				game:GetService("ReplicatedStorage").Rebirth.Rebirth:FireServer()
				print("Auto Rebirth successful.")
			end)

			if not success then
				print("Error during Auto Rebirth: " .. err)
			end

			wait(0.8) -- Adjust the delay if needed
		end
	end    
})

-- Auto Clicker Toggle (PC & Mobile)
Tab:AddToggle({
	Name = "Auto Clicker",
	Default = false,
	Callback = function(Value)
		getgenv().autoClick = Value
		
		if getgenv().autoClick then
			print("Auto Clicker enabled.")
			-- Start the auto clicker loop
			while getgenv().autoClick do
				pcall(function()
					local player = game.Players.LocalPlayer
					local mouse = player:GetMouse()
					if UserInputService.TouchEnabled then
						-- For mobile (touch input)
						VirtualUser:CaptureController()
						VirtualUser:SetKeyDown("0x20") -- Simulates a tap
						wait(0.1)
						VirtualUser:SetKeyUp("0x20") -- Simulates lifting the finger after a tap
					else
						-- For PC (mouse click)
						mouse1press() -- Press the mouse button
						wait(0.1) -- Adjust the delay to control the click speed
						mouse1release() -- Release the mouse button
					end
				end)
				wait(0.1) -- Delay between clicks
			end
		else
			print("Auto Clicker disabled.")
		end
	end    
})
