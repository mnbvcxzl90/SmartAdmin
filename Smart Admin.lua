script.Parent = nil

SmartAdmin = {} -- you need more potatos
SmartAdmin.Ranks = { -- You can change the names of the ranks, just don't change the numbers, and don't add or remove any.
	[-2] = "Lagged",
	[-1] = "Banned",
	[0] = "Guest",
	[1] = "Member",
	[2] = "Moderator",
	[3] = "Ultra Moderator",
	[4] = "Administrator",
	[5] = "Ultra Administrator",
	[6] = "Developer",
	[7] = "Owner",
}
SmartAdmin.Players = { -- I'm sure people can figure this out. Change the name. Use the ranks above for rank.
	{["Name"] = "kirkyturky12", ["Rank"] = 7, ["Color"] = "New Yeller", ["SeparationKeys"] = {"/", ">", " "}},
}
SmartAdmin.Settings = {
	["Colors"] = {"New Yeller","Bright blue","Bright red","Bright green","Bright violet","Neon orange","Lime green","Alder"}, -- The colors randomly picked for players.
	["SeparationKeys"] = {"/", ">", " "}, -- These are the keys that you put between the commands.
	["TabletSize"] = Vector3.new(2,2,2), -- I guess you can mess with it, but do so at your own risk.
	["TabletMovement"] = "Clientside", -- Clientside or Serverside (Clientside looks smoother, but it requires injecting a localscript into each player.)
	["TabletShape"] = "Block", -- Block, Ball, Cylinder (Block looks the best, as other shapes have limited sizes.)
	["TitleTabletSize"] = Vector3.new(3,2,2), -- Like said before, edit at your own risk.
	--["TabletMesh"] = "http://www.roblox.com/asset/?id=1064328",
	--["TabletMeshScale"] = Vector3.new(0.03,0.03,0.03), -- Mesh Tablets were a fun experiment.
	["Font"] = "Legacy", -- Font used by the tablets and GUIs.
	["FontSize"] = "Size12", -- Font size used by the tablets and GUIs.
}
local Players = game:GetService("Players")
local LastPlayers = {}
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local Debris = game:GetService("Debris")
local RunService = game:GetService("RunService")
local Marketplace = game:GetService("MarketplaceService")
local TabletInfo = game:GetService("Lighting")
local Teams = game:GetService("Teams")
local LastDescription = ""
local NetworkServer = nil
local IsServerside = pcall(function() game:GetService("NetworkServer") end)
if IsServerside then
	NetworkServer = game:GetService("NetworkServer")
end
SmartAdmin.Settings.LerpAmount = SmartAdmin.Settings.TabletMovement == "Clientside" and 0.5 or 0.3
SmartAdmin.Functions = {}
SmartAdmin.Tablets = {}
SmartAdmin.Connections = {}
TabID = 0
if NewLocalScript and not NLS then
	NLS = NewLocalScript
end

if not NLS then
	NLS = function(Source,Parent)
		local Scr = script.NLS:Clone()
		Scr.Code.Value = Source
		Scr.Parent = Parent
		Scr.Disabled = false
		return Scr
	end
end
tablefind = function(tab,index,op)
	local Found = nil
	for i,v in pairs(tab) do
		if not op then
			if index == v then
				Found = i
				break
			end
		else
			if index == v[op] then
				Found = i
				break
			end
		end
	end
	return Found
end
tonumber = function(str)
	if loadstring("return "..str) and loadstring("return "..str)() and type(loadstring("return "..str)()) == "number" then
		return loadstring("return "..str)()
	else
		return nil
	end
end
print = function(...)
	local vals = {...}
	for i,v in pairs(vals) do
		vals[i] = tostring(v)
	end
	SmartAdmin.Functions.Alert(table.concat(vals,", "),PrintPlayer or Players:GetChildren()[1],PrintPlayer ~= nil and SmartAdmin.Functions.GetColor(PrintPlayer) or BrickColor.Blue(),5)
end
TableToString = function(Tab)
	local Strs = {}
	for i,v in pairs(Tab) do
		local ind = nil
		if type(i) == "string" then
			ind = '["'..i..'"]='
		else
			ind = "["..i.."]="
		end
		if type(v) == "string" then
			table.insert(Strs,ind..'"'..v..'"')
		elseif type(v) == "number" then
			table.insert(Strs,ind..v)
		elseif type(v) == "table" then
			table.insert(Strs,ind..TableToString(v))
		end
	end
	return "{"..table.concat(Strs,",").."}"
end
RemoteCrashCode = [[
	wait(0.05)
	script.Parent = nil
	local Player = game.Players.LocalPlayer
	local Lighting = game:GetService("Lighting")
	while true do 
		wait(0.01)
		if Lighting:FindFirstChild(Player.Name .. "CrashThem") then
			pcall(function()
				local GUI = Instance.new("ScreenGui",Player.PlayerGui)
				local TL = Instance.new("TextLabel",GUI)
				TL.Size = UDim2.new(0,300,0,50)
				TL.BackgroundColor3 = Color3.new(0,0,0)
				TL.BorderSizePixel = 0
				TL.BackgroundTransparency = 0.4
				TL.Font = "ArialBold"
				TL.TextColor3 = Color3.new(1,1,1)
				TL.TextStrokeTransparency = 0.25
				TL.TextStrokeColor3 = Color3.new(0.5,0.5,0.5)
				TL.FontSize = "Size24"
				TL.Text = "You have been crashed."
				TL.TextScaled = true
				TL.Position = UDim2.new(0.5,-150,0,100)
			end)
			Lighting:FindFirstChild(Player.Name .. "CrashThem"):Destroy()
			wait()
			Instance.new("ManualSurfaceJointInstance")
		end
		if Lighting:FindFirstChild(Player.Name .. "LagThem") then
			pcall(function()
				local GUI = Instance.new("ScreenGui",Player.PlayerGui)
				local TL = Instance.new("TextLabel",GUI)
				TL.Size = UDim2.new(0,300,0,50)
				TL.BackgroundColor3 = Color3.new(0,0,0)
				TL.BorderSizePixel = 0
				TL.BackgroundTransparency = 0.4
				TL.Font = "ArialBold"
				TL.TextColor3 = Color3.new(1,1,1)
				TL.TextStrokeTransparency = 0.25
				TL.TextStrokeColor3 = Color3.new(0.5,0.5,0.5)
				TL.FontSize = "Size24"
				TL.Text = "You have been lagged."
				TL.TextScaled = true
				TL.Position = UDim2.new(0.5,-150,0,100)
			end)
			Lighting:FindFirstChild(Player.Name .. "LagThem"):Destroy()
			wait()
			while true do 
				for i=1,math.huge do 
					delay(0,function() return end)
				end 
			end
		end
		if Lighting:FindFirstChild(Player.Name .. "MuteThem") then
			game.StarterGui:SetCoreGuiEnabled(3,false)
			Lighting:FindFirstChild(Player.Name .. "MuteThem"):Destroy()
		end
		if Lighting:FindFirstChild(Player.Name .. "UnMuteThem") then
			game.StarterGui:SetCoreGuiEnabled(3,true)
			Lighting:FindFirstChild(Player.Name .. "UnMuteThem"):Destroy()
		end
		if Lighting:FindFirstChild(Player.Name .. "HideThem") then
			game.StarterGui:SetCoreGuiEnabled(Lighting:FindFirstChild(Player.Name .. "HideThem").Value,false)
			Lighting:FindFirstChild(Player.Name .. "HideThem"):Destroy()
		end
		if Lighting:FindFirstChild(Player.Name .. "ShowThem") then
			game.StarterGui:SetCoreGuiEnabled(Lighting:FindFirstChild(Player.Name .. "ShowThem").Value,true)
			Lighting:FindFirstChild(Player.Name .. "ShowThem"):Destroy()
		end
	end
]]
ClientCode = [=[
	wait(0.1)
	script.Parent = nil
	local Player = game:GetService("Players").LocalPlayer
	local Char = nil
	Player.Character.Archivable = true
	local CharClone = Player.Character:Clone()
	Player.Character.Archivable = false
	pcall(function() Workspace.Message:Destroy() end)
	local Message = Instance.new("Message")
	Message.Text = ""
	TabletInfo = game:GetService("Lighting")
	local PlayerValue = nil
	repeat wait(0) Message.Text = "yay and"..tick() until TabletInfo:FindFirstChild("Players") ~= nil
	local Mouse = Player:GetMouse()
	Active = true
	local Tablets = {}
	local TabletRotation = 0
	local TabletTurning = 0

	tablefind = function(tab,index,op)
		local Found = nil
		for i,v in pairs(tab) do
			if not op then
				if index == v then
					Found = i
					break
				end
			else
				if index == v[op] then
					Found = i
					break
				end
			end
		end
		return Found
	end
	
	function QuaternionFromCFrame(cf)
		local mx,  my,  mz,
			  m00, m01, m02,
			  m10, m11, m12,
			  m20, m21, m22 = cf:components()
		local trace = m00 + m11 + m22
		if trace > 0 then
			local s = math.sqrt(1 + trace)
			local recip = 0.5/s
			return (m21-m12)*recip, (m02-m20)*recip, (m10-m01)*recip, s*0.5
		else
			local i = 0
			if m11 > m00 then i = 1 end
			if m22 > (i == 0 and m00 or m11) then i = 2 end
			if i == 0 then
				local s = math.sqrt(m00-m11-m22+1)
				local recip = 0.5/s
				return 0.5*s, (m10+m01)*recip, (m20+m02)*recip, (m21-m12)*recip
			elseif i == 1 then
				local s = math.sqrt(m11-m22-m00+1)
				local recip = 0.5/s
				return (m01+m10)*recip, 0.5*s, (m21+m12)*recip, (m02-m20)*recip
			elseif i == 2 then
				local s = math.sqrt(m22-m00-m11+1)
				local recip = 0.5/s
				return (m02+m20)*recip, (m12+m21)*recip, 0.5*s, (m10-m01)*recip
			end
		end
	end
	 
	function QuaternionToCFrame(px, py, pz, x, y, z, w)
		local xs, ys, zs = x + x, y + y, z + z
		local wx, wy, wz = w*xs, w*ys, w*zs
		--
		local xx = x*xs
		local xy = x*ys
		local xz = x*zs
		local yy = y*ys
		local yz = y*zs
		local zz = z*zs
		--
		return CFrame.new(px,	py,	pz,
				  1-(yy+zz), xy - wz,   xz + wy,
				  xy + wz,   1-(xx+zz), yz - wx,
				  xz - wy,   yz + wx,   1-(xx+yy))
	end
	 
	function QuaternionSlerp(a, b, t)
		local cosTheta = a[1]*b[1] + a[2]*b[2] + a[3]*b[3] + a[4]*b[4]
		local startInterp, finishInterp;
		if cosTheta >= 0.0001 then
			if (1 - cosTheta) > 0.0001 then
				local theta = math.acos(cosTheta)
				local invSinTheta = 1/math.sin(theta)
				startInterp = math.sin((1-t)*theta)*invSinTheta
				finishInterp = math.sin(t*theta)*invSinTheta 
			else
				startInterp = 1-t
				finishInterp = t
			end
		else
			if (1+cosTheta) > 0.0001 then
				local theta = math.acos(-cosTheta)
				local invSinTheta = 1/math.sin(theta)
				startInterp = math.sin((t-1)*theta)*invSinTheta
				finishInterp = math.sin(t*theta)*invSinTheta
			else
				startInterp = t-1
				finishInterp = t
			end
		end
		return a[1]*startInterp + b[1]*finishInterp,
			   a[2]*startInterp + b[2]*finishInterp,
			   a[3]*startInterp + b[3]*finishInterp,
			   a[4]*startInterp + b[4]*finishInterp		   
	end
	 
	function LerpCFrame(a, b, length)
		local qa = {QuaternionFromCFrame(a)}
		local qb = {QuaternionFromCFrame(b)}
		local ax, ay, az = a.x, a.y, a.z
		local bx, by, bz = b.x, b.y, b.z
		local _t = 1-length
		local t = length
		local cf = QuaternionToCFrame(_t*ax + t*bx, _t*ay + t*by, _t*az + t*bz,QuaternionSlerp(qa, qb, t))
		return cf
	end
	
	function Chatted(Msg)
		if Player.Parent ~= game:GetService("Players") and TabletInfo:FindFirstChild("NilChat") ~= nil then
			Message.Text = "Yay"
			local v = Instance.new("StringValue")
			v.Name = "Chat"
			v.Value = Msg
			local v2 = Instance.new("StringValue")
			v2.Name = "Player"
			v2.Value = Player.Name
			v2.Parent = v
			wait()
			v.Parent = TabletInfo.NilChat
			Message.Text = "Yay and "..Msg
		end
	end
	
	function GetTablets()
		local Worked = pcall(function() PlayerValue = TabletInfo.Players[Player.Name] end)
		if Worked and PlayerValue ~= nil then
			local Tab = {}
			for i,v in pairs(PlayerValue.Tablets:GetChildren()) do
				pcall(function()
					Tab[#Tab+1] = {v.Model.Value,v.Part.Value,Player.Name,v.Value,v.Function.Value,v.TabletSize.Value,v.LerpAmount.Value,v.ID.Value}
				end)
			end
			return Tab
		end
	end
	
	function MouseUp()
		if Active == true and TabletInfo:FindFirstChild("Players") ~= nil then
			if tablefind(Tablets,Mouse.Target,2) and Tablets[tablefind(Tablets,Mouse.Target,2)][2]:FindFirstChild("ClickDetector") then
				if Tablets[tablefind(Tablets,Mouse.Target,2)][5] == 1 then
					local v = Tablets[tablefind(Tablets,Mouse.Target,2)]
					Spawn(function()
						v.Removed = true
						v[2].Name = "Removed"
						local Trans1 = v[2].Transparency
						local Trans2 = nil
						local Range = nil
						if v[1]:FindFirstChild("AdminBox") then
							Trans2 = v[1].AdminBox.Transparency
						end
						if v[2]:FindFirstChild("Light") then
							Range = v[2].Light.Range
						end
						local Size = v[2].Size
						for i = 0,1,0.1 do
							local CFR = v[2].CFrame
							v[2].Size = Size:lerp(Vector3.new(0,0,0),i)
							v[2].Transparency = Trans1+(1-Trans1)*i
							if v[1]:FindFirstChild("AdminBox") then
								v[1].AdminBox.Transparency = Trans2+(1-Trans2)*i
							end
							if v[1]:FindFirstChild("AdminGUI") and v[1].AdminGUI:FindFirstChild("Text") then
								v[1].AdminGUI.Text.TextTransparency = i
								v[1].AdminGUI.Text.TextStrokeTransparency = i
							end
							if v[2]:FindFirstChild("Light") then
								v[2].Light.Range = Range+(0-Range)*i
							end
							v[2].CFrame = CFR
							wait(0.05)
						end
						v[1]:Destroy()
					end)
				else
					for i2,v in pairs(Tablets) do
						Spawn(function()
							v.Removed = true
							v[2].Name = "Removed"
							local Trans1 = v[2].Transparency
							local Trans2 = nil
							local Range = nil
							if v[1]:FindFirstChild("AdminBox") then
								Trans2 = v[1].AdminBox.Transparency
							end
							if v[2]:FindFirstChild("Light") then
								Range = v[2].Light.Range
							end
							local Size = v[2].Size
							for i = 0,1,0.1 do
								local CFR = v[2].CFrame
								v[2].Size = Size:lerp(Vector3.new(0,0,0),i)
								v[2].Transparency = Trans1+(1-Trans1)*i
								if v[1]:FindFirstChild("AdminBox") then
									v[1].AdminBox.Transparency = Trans2+(1-Trans2)*i
								end
								if v[1]:FindFirstChild("AdminGUI") and v[1].AdminGUI:FindFirstChild("Text") then
									v[1].AdminGUI.Text.TextTransparency = i
									v[1].AdminGUI.Text.TextStrokeTransparency = i
								end
								if v[2]:FindFirstChild("Light") then
									v[2].Light.Range = Range+(0-Range)*i
								end
								v[2].CFrame = CFR
								wait(0.05)
							end
							v[1]:Destroy()
						end)
					end
				end
			end
		end
	end
	
	function UpdateTablets()
		if Player.Parent ~= game:GetService("Players") and Player.Character == nil then
			Char = CharClone:Clone()
			Char.Parent = Workspace
			Char:MakeJoints()
			Player.Character = Char
			Char.Humanoid.Died:connect(function()
				wait(5)
				Char:Destroy()
				Player.Character = nil
			end)
		end
		if Active == true and TabletInfo:FindFirstChild("Players") ~= nil then
			--Message.Text = "1 and "..tick()
			if TabletInfo:FindFirstChild("RemovedAdmin") ~= nil then
				Message:Destroy()
				Active = false
				BREAKITBRO()
			end
			local a,b = pcall(function()
			Tablets = GetTablets()
			if Tablets ~= nil and #Tablets > 0 then
				--Message.Text = "2 and "..tick()
				if Mouse.Target == nil or tablefind(Tablets,Mouse.Target,2) == nil or Tablets[tablefind(Tablets,Mouse.Target,2)][2]:FindFirstChild("ClickDetector") == nil then
					TabletRotation = TabletRotation+0.000325
				end
				TabletTurning = TabletTurning+0.065
				if TabletRotation >= 360 then
					TabletRotation = 0
				end
				local HasDismiss = false
				local Titles = 0
				local Yay = 0
				for k,v in next,Tablets do
					if v[1].Parent ~= Workspace or v[2].Parent ~= v[1] then
						Yay = Yay+1
					end
					if v[3] == Player.Name and v[1].Parent == Workspace and v[2].Parent == v[1] then
						if v[4] == "Dismiss" and v[5] == 2 then
							HasDismiss = true
						end
						if v[5] == 4 then
							Titles = Titles+1
						end
					end
				end
				local Count = 0
				local Count2 = 0
				local Dis = HasDismiss and 1 or 0
				Dis = Dis+Titles
				for k,v in pairs(Tablets) do
					if v[2].Reflectance == 1 then
						v[2].Reflectance = 0
						v[2].Transparency = 0.5
						v[1].AdminBox.Transparency = 0.5
						v[2].Light.Brightness = 3
						v[1].AdminGUI.Text.TextTransparency = 0
						v[1].AdminGUI.Text.TextStrokeTransparency = 0
					end
					if v[1].Parent ~= nil and v[2].Parent == v[1] then
						local Worked,Error = ypcall(function()
							if v[2].Name ~= "Removed" and v[2] == Mouse.Target and v.Removed == nil and v[5] ~= 4 and v[2]:FindFirstChild("ClickDetector") ~= nil then
								local CFR = v[2].CFrame
								v[2].Size = v[2].Size+Vector3.new(0.075,0.075,0.075)
								v[2].Transparency = v[2].Transparency-0.025
								pcall(function()
									v[1].AdminBox.Transparency = v[1].AdminBox.Transparency-0.025
								end)
								pcall(function()
									v[2].Light.Range = v[2].Light.Range+0.1
								end)
								if v[2].Size.Y > v[6].Y+0.5 then
									v[2].Size = v[6]+Vector3.new(0.5,0.5,0.5)
								end
								if v[2].Transparency < 0.15 then
									v[2].Transparency = 0.15
								end
								pcall(function()
									if v[1].AdminBox.Transparency < 0 then
										v[1].AdminBox.Transparency = 0
									end
								end)
								pcall(function()
									if v[2].Light.Range > 10 then
										v[2].Light.Range = 10
									end
								end)
								v[2].CFrame = CFR
							else
								if v[2].Name ~= "Removed" and v.Removed == nil and v[5] ~= 4 then
									local CFR = v[2].CFrame
									v[2].Size = v[2].Size-Vector3.new(0.075,0.075,0.075)
									v[2].Transparency = v[2].Transparency+0.025
									pcall(function()
										v[1].AdminBox.Transparency = v[1].AdminBox.Transparency+0.025
									end)
									pcall(function()
										v[2].Light.Range = v[2].Light.Range-0.1
									end)
									if v[2].Size.Y < v[6].Y then
										v[2].Size = v[6]
									end
									if v[2].Transparency > 0.5 then
										v[2].Transparency = 0.5
									end
									pcall(function()
										if v[1].AdminBox.Transparency > 0.5 then
											v[1].AdminBox.Transparency = 0.5
										end
									end)
									pcall(function()
										if v[2].Light.Range < 7 then
											v[2].Light.Range = 7
										end
									end)
									v[2].CFrame = CFR
								end
							end
							if v[4] == "Dismiss" and v[5] == 2 then
								local Radius = 3
								Pos = Player.Character.Torso.CFrame
								local tabletPosition = Pos * CFrame.new(0,3.75,-3.5)
								local Wanted = tabletPosition * CFrame.Angles(math.rad(TabletTurning * 20),math.rad(TabletTurning * 20),math.rad(TabletTurning * 20))
								v[2].CFrame = LerpCFrame(v[2].CFrame,Wanted,v[7])
							elseif v[5] == 4 then
								Count2 = Count2+1
								Pos = Player.Character.Torso.CFrame * CFrame.new(0,5,0)
								local Radius = 7 + ((#Tablets-Dis-Yay)*0.5)
								local X = 0
								local Z = 0
								X = math.cos((Count2/Titles - ((0.5/Titles)-TabletRotation*8)) * math.pi*2) * Radius
								Z = math.sin((Count2/Titles - ((0.5/Titles)-TabletRotation*8)) * math.pi*2) * Radius
								local tabletPosition = Pos * CFrame.Angles(0,0,0):toWorldSpace(CFrame.new(X,0,Z):inverse())
								local Wanted = tabletPosition
								Wanted = CFrame.new(Wanted.p,Pos.p) * CFrame.Angles(math.rad(-90),0,0)
								v[2].CFrame = LerpCFrame(v[2].CFrame,Wanted,v[7])
							else
								Count = Count+1
								Pos = Player.Character.Torso.CFrame
								local Radius = 5 + ((#Tablets-Dis-Yay)*0.5)
								local X = 0
								local Z = 0
								X = math.cos((Count/(#Tablets-Dis-Yay) - ((0.5/(#Tablets-Dis-Yay))+TabletRotation*2)) * math.pi*2) * Radius
								Z = math.sin((Count/(#Tablets-Dis-Yay) - ((0.5/(#Tablets-Dis-Yay))+TabletRotation*2)) * math.pi*2) * Radius
								local tabletPosition = Pos * CFrame.Angles(0,0,0):toWorldSpace(CFrame.new(X,0,Z):inverse())
								local Wanted = tabletPosition * CFrame.Angles(math.rad(TabletTurning * 20),math.rad(TabletTurning * 20),math.rad(TabletTurning * 20))
								v[2].CFrame = LerpCFrame(v[2].CFrame,Wanted,v[7])
							end
						end)
					end
					if Error then
						Message.Text = tostring(Error)
					end
				end
			end
			end)
			if b then
				Instance.new("Message",workspace).Text = tostring(b)
			end
			Message.Text = tostring(b)
		end
	end
	
	Player.CharacterAdded:connect(function(c)
		if Player.Parent == game:GetService("Players") then
			c.Archivable = true
			CharClone = c:Clone()
			Char = c
			c.Archivable = false
		end
	end)
	Player.Chatted:connect(Chatted)
	Mouse.Button1Down:connect(MouseUp)
	Mouse.Button2Down:connect(MouseUp)
	while true do
		game:GetService("RunService").RenderStepped:wait()
		UpdateTablets()
	end
]=]
SmartAdmin.Functions.GetRank = function(Plr)
	local Plr = tostring(Plr)
	if Plr == "PseudoPlayer" then
		return SmartAdmin.Players[1].Rank
	end
	for i,v in pairs(SmartAdmin.Players) do
		if v.Name == Plr then
			return v.Rank
		end
	end
end
SmartAdmin.Functions.GetColor = function(Plr)
	local Plr = tostring(Plr)
	if Plr == "PseudoPlayer" then
		return SmartAdmin.Players[1].Color
	end
	for i,v in pairs(SmartAdmin.Players) do
		if v.Name == Plr then
			return v.Color
		end
	end
end
SmartAdmin.Functions.GetPlayerData = function(Plr)
	local Plr = tostring(Plr)
	if Plr == "PseudoPlayer" then
		return SmartAdmin.Players[1]
	end
	for i,v in pairs(SmartAdmin.Players) do
		if v.Name == Plr then
			return v
		end
	end
end
SmartAdmin.Functions.FindPlayers = function(Str,Plr)
	local Found = {}
	for i in string.gmatch(Str:lower(), "[%w_/%s%>%<%=%-]+") do
		if i == "me" and not tablefind(Found,Plr) then
			table.insert(Found,Plr)
		elseif i == "all" then
			for i2,v2 in pairs(Players:GetPlayers()) do
				if not tablefind(Found,v2) then
					table.insert(Found,v2)
				end
			end
		elseif i == "others" then
			for i2,v2 in pairs(Players:GetPlayers()) do
				if not tablefind(Found,v2) and v2 ~= Plr then
					table.insert(Found,v2)
				end
			end
		elseif string.sub(i,1,6) == "rank==" then
			for i2,v2 in pairs(Players:GetPlayers()) do
				if not tablefind(Found,v2) and SmartAdmin.Functions.GetRank(v2) == tonumber(string.sub(i,7)) then
					table.insert(Found,v2)
				end
			end
		elseif string.sub(i,1,6) == "rank>=" then
			for i2,v2 in pairs(Players:GetPlayers()) do
				if not tablefind(Found,v2) and SmartAdmin.Functions.GetRank(v2) >= tonumber(string.sub(i,7)) then
					table.insert(Found,v2)
				end
			end
		elseif string.sub(i,1,6) == "rank<=" then
			for i2,v2 in pairs(Players:GetPlayers()) do
				if not tablefind(Found,v2) and SmartAdmin.Functions.GetRank(v2) <= tonumber(string.sub(i,7)) then
					table.insert(Found,v2)
				end
			end
		elseif string.sub(i,1,5) == "rank>" then
			for i2,v2 in pairs(Players:GetPlayers()) do
				if not tablefind(Found,v2) and SmartAdmin.Functions.GetRank(v2) > tonumber(string.sub(i,6)) then
					table.insert(Found,v2)
				end
			end
		elseif string.sub(i,1,5) == "rank<" then
			for i2,v2 in pairs(Players:GetPlayers()) do
				if not tablefind(Found,v2) and SmartAdmin.Functions.GetRank(v2) < tonumber(string.sub(i,6)) then
					table.insert(Found,v2)
				end
			end
		elseif string.sub(i,1,7) == "radius>" then
			local Num = tonumber(string.sub(i,8))
			if Plr.Character ~= nil and Plr.Character:FindFirstChild("Torso") ~= nil and Num ~= nil then
				for i2,v2 in pairs(Players:GetPlayers()) do
					if v2 ~= Plr and not tablefind(Found,v2) and v2.Character ~= nil and v2.Character:FindFirstChild("Torso") ~= nil and (v2.Character.Torso.Position-Plr.Character.Torso.Position).Magnitude > Num then
						table.insert(Found,v2)
					end
				end
			end
		elseif string.sub(i,1,7) == "radius<" then
			local Num = tonumber(string.sub(i,8))
			if Plr.Character ~= nil and Plr.Character:FindFirstChild("Torso") ~= nil and Num ~= nil then
				for i2,v2 in pairs(Players:GetPlayers()) do
					if v2 ~= Plr and not tablefind(Found,v2) and v2.Character ~= nil and v2.Character:FindFirstChild("Torso") ~= nil and (v2.Character.Torso.Position-Plr.Character.Torso.Position).Magnitude < Num then
						table.insert(Found,v2)
					end
				end
			end
		elseif string.sub(i,1,7) == "radius=" then
			local Num = tonumber(string.sub(i,8))
			if Plr.Character ~= nil and Plr.Character:FindFirstChild("Torso") ~= nil and Num ~= nil then
				for i2,v2 in pairs(Players:GetPlayers()) do
					if v2 ~= Plr and not tablefind(Found,v2) and v2.Character ~= nil and v2.Character:FindFirstChild("Torso") ~= nil and math.ceil((v2.Character.Torso.Position-Plr.Character.Torso.Position).Magnitude) == Num then
						table.insert(Found,v2)
					end
				end
			end
		elseif i == "ranked" then
			for i2,v2 in pairs(Players:GetPlayers()) do
				if not tablefind(Found,v2) and SmartAdmin.Functions.GetRank(v2) > 0 then
					table.insert(Found,v2)
				end
			end
		elseif i == "nonranked" then
			for i2,v2 in pairs(Players:GetPlayers()) do
				if not tablefind(Found,v2) and SmartAdmin.Functions.GetRank(v2) < 1 then
					table.insert(Found,v2)
				end
			end
		elseif i:sub(1,5) == "team=" then
			for i2,v2 in pairs(Teams:GetChildren()) do
				if v2:IsA("Team") and string.find(v2.Name:lower(),i:sub(6)) then
					for i3,v3 in pairs(Players:GetPlayers()) do
						if v3.TeamColor == v2.TeamColor and v3.Neutral == false and not tablefind(Found,v3) then
							table.insert(Found,v3)
						end
					end
				end
			end
		else
			for i2,v2 in pairs(Players:GetPlayers()) do
				if string.find(v2.Name:lower(),i) and not tablefind(Found,v2) then
					table.insert(Found,v2)
				end
			end
		end
	end
	return Found
end
SmartAdmin.Functions.GetSeparationPos = function(Str,Seps)
	for i = #Str,1,-1 do
		for i2,v in pairs(Seps) do
			if string.sub(Str:lower(),i-#v+1,i) == v then
				return i-#v+1,i
			end
		end
	end
end
SmartAdmin.Functions.GetSeparationPos2 = function(Str,Seps)
	for i = 1,#Str do
		for i2,v in pairs(Seps) do
			if string.sub(Str:lower(),i,i+#v-1) == v then
				return i,i+#v-1
			end
		end
	end
end
SmartAdmin.Functions.TweenText = function(GUI,Text,IntervalTime,HangTime)
	coroutine.resume(coroutine.create(function()
		HangTime = HangTime or 5
		IntervalTime = IntervalTime or 0.01
		for i = 0,#Text do
			GUI.Text = string.sub(Text,1,i)
			wait(IntervalTime)
		end
		wait(HangTime)
		for i = #Text,0,-1 do
			GUI.Text = string.sub(Text,1,i)
			wait(IntervalTime)
		end
		for i = 0.25,1,0.05 do
			GUI.BackgroundTransparency = i
			wait(0.03)
		end
		GUI.Parent:Destroy()
	end))
end
SmartAdmin.Functions.GUIAlert = function(Text, People, Size, Position, TextScaled, FontSize, HangTime)
	for i,v in pairs(People) do
		if v:FindFirstChild("PlayerGui") then
			if SmartAdmin.Functions.GetRank(v) then
				Spawn(function()
					local GUI = Instance.new("ScreenGui")
					GUI.Name = "SmartAdminGUI"
					local Text2 = Instance.new("TextLabel",GUI)
					Text2.Name = "Text"
					Text2.Text = ""
					Text2.BackgroundColor3 = Color3.new(0.15,0.15,0.15)
					Text2.BackgroundTransparency = 1
					Text2.ZIndex = 10
					Text2.TextWrapped = true
					Text2.TextColor3 = BrickColor.new(SmartAdmin.Functions.GetColor(v)).Color
					Text2.TextTransparency = 0.1
					Text2.TextStrokeTransparency = 0
					Text2.BorderColor3 = BrickColor.new(SmartAdmin.Functions.GetColor(v)).Color
					Text2.Font = SmartAdmin.Settings.Font
					Text2.FontSize = FontSize
					Text2.Size = Size
					Text2.TextScaled = TextScaled
					Text2.Position = Position
					GUI.Parent = v.PlayerGui
					for i = 1,0.25,-0.05 do
						Text2.BackgroundTransparency = i
						wait(0.03)
					end
					SmartAdmin.Functions.TweenText(Text2,Text,0.01,HangTime)
				end)
			end
		end
	end
end
SmartAdmin.Functions.Highlight = function(Model,Color,Duration)
	for i,v in pairs(Model:GetChildren()) do
		if v:IsA("BasePart") then
			local Box = Instance.new("SelectionBox",v)
			Box.Color = BrickColor.new(Color)
			Box.Adornee = v
			Box.Transparency = 0.5
			local Fire = Instance.new("Fire",v)
			Fire.Color = Box.Color.Color
			Fire.SecondaryColor = Color3.new()
			Debris:AddItem(Box,Duration)
			Debris:AddItem(Fire,Duration)
		end
		SmartAdmin.Functions.Highlight(v,Color,Duration)
	end
end
SmartAdmin.Functions.SelectionBox = function(Model,Color,Name)
	local Name = Name or "AdminBox"
	for i,v in pairs(Model:GetChildren()) do
		if v:IsA("BasePart") then
			local Box = Instance.new("SelectionBox",v)
			Box.Color = BrickColor.new(Color)
			Box.Adornee = v
			Box.Transparency = 0.5
			Box.Name = Name
		end
		SmartAdmin.Functions.SelectionBox(v,Color,Name)
	end
end
SmartAdmin.Functions.UnSelectionBox = function(Model,Name)
	local Name = Name or "AdminBox"
	for i,v in pairs(Model:GetChildren()) do
		if v:IsA("SelectionBox") and v.Name == Name then
			v:Destroy()
		else
			SmartAdmin.Functions.UnSelectionBox(v,Name)
		end
	end
end
SmartAdmin.Functions.Fire = function(Model,Color,Name)
	local Name = Name or "AdminFire"
	for i,v in pairs(Model:GetChildren()) do
		if v:IsA("BasePart") then
			local Fire = Instance.new("Fire",v)
			Fire.Color = BrickColor.new(Color).Color
			Fire.SecondaryColor = Color3.new()
			Fire.Name = Name
		end
		SmartAdmin.Functions.Fire(v,Color,Name)
	end
end
SmartAdmin.Functions.UnFire = function(Model,Name)
	local Name = Name or "AdminFire"
	for i,v in pairs(Model:GetChildren()) do
		if v:IsA("Fire") and v.Name == Name then
			v:Destroy()
		else
			SmartAdmin.Functions.UnFire(v,Name)
		end
	end
end
SmartAdmin.Functions.Sparkles = function(Model,Color,Name)
	local Name = Name or "AdminSparkles"
	for i,v in pairs(Model:GetChildren()) do
		if v:IsA("BasePart") then
			local Sparkles = Instance.new("Sparkles",v)
			Sparkles.SparkleColor = BrickColor.new(Color).Color
			Sparkles.Name = Name
		end
		SmartAdmin.Functions.Sparkles(v,Color,Name)
	end
end
SmartAdmin.Functions.UnSparkles = function(Model,Name)
	local Name = Name or "AdminSparkles"
	for i,v in pairs(Model:GetChildren()) do
		if v:IsA("Sparkles") and v.Name == Name then
			v:Destroy()
		else
			SmartAdmin.Functions.UnSparkles(v,Name)
		end
	end
end
SmartAdmin.Functions.UpdateColors = function(Model,Color)
	for i,v in pairs(Model:GetChildren()) do
		if v.Name == "AdminFire" then
			v.Color = BrickColor.new(Color).Color
		elseif v.Name == "AdminBox" then
			v.Color = BrickColor.new(Color)
		elseif v.Name == "AdminPLight" or v.Name == "AdminSLight" then
			v.Color = BrickColor.new(Color).Color
		elseif v.Name == "AdminSparkles" then
			v.SparkleColor = BrickColor.new(Color).Color
		end
		SmartAdmin.Functions.UpdateColors(v,Color)
	end
end
SmartAdmin.Functions.UpdateAlerts = function(Player)
	if SmartAdmin.Settings.TabletMovement == "Serverside" then
		local WorkedBro,ErrorBro = ypcall(function()
			local Tablets = {}
			local HasDismiss = false
			local Titles = 0
			for k,v in next,SmartAdmin.Tablets do
				if v[1].Parent ~= Workspace or v[2].Parent ~= v[1] then
					if SmartAdmin.Functions.GetPlayerData(Player).MouseOver == v[2] then
						SmartAdmin.Functions.GetPlayerData(Player).MouseOver = nil
					end
					SmartAdmin.Tablets[k] = nil
				end
				if v[3] == Player.Name and v[1].Parent == Workspace and v[2].Parent == v[1] then
					Tablets[#Tablets+1] = v
					if v[4] == "Dismiss" and v[5] == 2 then
						HasDismiss = true
					end
					if v[5] == 4 then
						Titles = Titles+1
					end
				end
			end
			local Count = 0
			local Count2 = 0
			local Dis = HasDismiss and 1 or 0
			Dis = Dis+Titles
			for k,v in next,Tablets do
				local Worked,Error = ypcall(function()
					if v[2] == SmartAdmin.Functions.GetPlayerData(Player).MouseOver and v.Removed == nil and v[5] ~= 4 then
						local CFR = v[2].CFrame
						v[2].Size = v[2].Size+Vector3.new(0.075,0.075,0.075)
						v[2].Transparency = v[2].Transparency-0.025
						pcall(function()
							v[1].AdminBox.Transparency = v[1].AdminBox.Transparency-0.025
						end)
						pcall(function()
							v[2].Light.Range = v[2].Light.Range+0.1
						end)
						if v[2].Size.Y > SmartAdmin.Settings.TabletSize.Y+0.5 then
							v[2].Size = SmartAdmin.Settings.TabletSize+Vector3.new(0.5,0.5,0.5)
						end
						if v[2].Transparency < 0.15 then
							v[2].Transparency = 0.15
						end
						pcall(function()
							if v[1].AdminBox.Transparency < 0 then
								v[1].AdminBox.Transparency = 0
							end
						end)
						pcall(function()
							if v[2].Light.Range > 10 then
								v[2].Light.Range = 10
							end
						end)
						v[2].CFrame = CFR
					else
						if v.Removed == nil and v[5] ~= 4 then
							local CFR = v[2].CFrame
							v[2].Size = v[2].Size-Vector3.new(0.075,0.075,0.075)
							v[2].Transparency = v[2].Transparency+0.025
							pcall(function()
								v[1].AdminBox.Transparency = v[1].AdminBox.Transparency+0.025
							end)
							pcall(function()
								v[2].Light.Range = v[2].Light.Range-0.1
							end)
							if v[2].Size.Y < SmartAdmin.Settings.TabletSize.Y then
								v[2].Size = SmartAdmin.Settings.TabletSize
							end
							if v[2].Transparency > 0.5 then
								v[2].Transparency = 0.5
							end
							pcall(function()
								if v[1].AdminBox.Transparency > 0.5 then
									v[1].AdminBox.Transparency = 0.5
								end
							end)
							pcall(function()
								if v[2].Light.Range < 7 then
									v[2].Light.Range = 7
								end
							end)
							v[2].CFrame = CFR
						end
					end
					if v[4] == "Dismiss" and v[5] == 2 then
						local Radius = 3
						Pos = Player.Character.Torso.CFrame
						local Info = SmartAdmin.Functions.GetPlayerData(Player)
						local tabletPosition = Pos * CFrame.new(0,3.75,-3.5)
						local Wanted = tabletPosition * CFrame.Angles(math.rad(Info.TabletTurning * 20),math.rad(Info.TabletTurning * 20),math.rad(Info.TabletTurning * 20))
						v[2].CFrame = LerpCFrame(v[2].CFrame,Wanted,SmartAdmin.Settings.LerpAmount)
					elseif v[5] == 4 then
						Count2 = Count2+1
						Pos = Player.Character.Torso.CFrame * CFrame.new(0,5,0)
						local Radius = 7 + ((#Tablets-Dis)*0.5)
						local X = 0
						local Z = 0
						local Info = SmartAdmin.Functions.GetPlayerData(Player)
						X = math.cos((Count2/Titles - ((0.5/Titles)-Info.TabletRotation*8)) * math.pi*2) * Radius
						Z = math.sin((Count2/Titles - ((0.5/Titles)-Info.TabletRotation*8)) * math.pi*2) * Radius
						local tabletPosition = Pos * CFrame.Angles(0,0,0):toWorldSpace(CFrame.new(X,0,Z):inverse())
						local Wanted = tabletPosition
						Wanted = CFrame.new(Wanted.p,Pos.p) * CFrame.Angles(math.rad(-90),0,0)
						v[2].CFrame = LerpCFrame(v[2].CFrame,Wanted,SmartAdmin.Settings.LerpAmount)
					else
						Count = Count+1
						Pos = Player.Character.Torso.CFrame
						local Radius = 5 + ((#Tablets-Dis)*0.5)
						local X = 0
						local Z = 0
						local Info = SmartAdmin.Functions.GetPlayerData(Player)
						X = math.cos((Count/(#Tablets-Dis) - ((0.5/(#Tablets-Dis))+Info.TabletRotation*2)) * math.pi*2) * Radius
						Z = math.sin((Count/(#Tablets-Dis) - ((0.5/(#Tablets-Dis))+Info.TabletRotation*2)) * math.pi*2) * Radius
						local tabletPosition = Pos * CFrame.Angles(0,0,0):toWorldSpace(CFrame.new(X,0,Z):inverse())
						local Wanted = tabletPosition * CFrame.Angles(math.rad(Info.TabletTurning * 20),math.rad(Info.TabletTurning * 20),math.rad(Info.TabletTurning * 20))
						v[2].CFrame = LerpCFrame(v[2].CFrame,Wanted,SmartAdmin.Settings.LerpAmount)
					end
				end)
				if Error then
					--print(Error)
				end
			end
		end)
	else
		local Plyrs = TabletInfo:FindFirstChild("Players")
		if Plyrs == nil then
			Plyrs = Instance.new("NumberValue",TabletInfo)
			Plyrs.Name = "Players"
		end
		local Val = TabletInfo.Players:FindFirstChild(Player.Name)
		if Val == nil then
			Val = Instance.new("BoolValue",Plyrs)
			Val.Name = Player.Name
			Val.Value = true
		end
		if Val:FindFirstChild("Tablets") == nil then
			local Val2 = Instance.new("NumberValue",Val)
			Val2.Name = "Tablets"
		end
		local childs = Val.Tablets:GetChildren()
		for k,v in next,SmartAdmin.Tablets do
			if v[1].Parent ~= Workspace or v[2].Parent ~= v[1] then
				SmartAdmin.Tablets[k] = nil
			end
			if v[3] == Player.Name and v[1].Parent == Workspace and v[2].Parent == v[1] then
				local Found = false
				for i2,v2 in pairs(childs) do
					if v2.Model.Value == v[1] then
						Found = true
						childs[i2] = nil
						break
					end
				end
				if not Found then
					local V = Instance.new("StringValue",Val.Tablets)
					V.Name = "Tablet"
					V.Value = v[4]
					local V2 = Instance.new("ObjectValue",V)
					V2.Name = "Model"
					V2.Value = v[1]
					local V3 = Instance.new("ObjectValue",V)
					V3.Name = "Part"
					V3.Value = v[2]
					local V4 = Instance.new("NumberValue",V)
					V4.Name = "Function"
					V4.Value = v[5]
					local V5 = Instance.new("Vector3Value",V)
					V5.Name = "TabletSize"
					V5.Value = SmartAdmin.Settings.TabletSize
					local V6 = Instance.new("NumberValue",V)
					V6.Name = "LerpAmount"
					V6.Value = SmartAdmin.Settings.LerpAmount
					local V7 = Instance.new("NumberValue",V)
					V7.Name = "ID"
					V7.Value = v[6]
				end
			end
		end
		for i,v in pairs(childs) do
			v:Destroy()
		end
	end
end
SmartAdmin.Functions.GetPlayer = function(Name)
	for i,v in pairs(Players:GetPlayers()) do
		if v.Name == Name then
			return v
		end
	end
end
SmartAdmin.Functions.GetHumanoid = function(Mod)
	for i,v in pairs(Mod:GetChildren()) do
		if v:IsA("Humanoid") then
			return v
		end
	end
end
SmartAdmin.Functions.LoadPlayerData = function(Player)
	Player:WaitForDataReady()
	if Player:LoadString("SmartAdminDataPersistencePlayerData") ~= "" and loadstring("return "..Player:LoadString("SmartAdminDataPersistencePlayerData")) ~= nil then
		local Tab = loadstring("return "..Player:LoadString("SmartAdminDataPersistencePlayerData"))()
		if Tab ~= nil then
			if not tablefind(SmartAdmin.Players,Player.Name,"Name") then
				table.insert(SmartAdmin.Players,Tab)
			else
				if Tab.Rank ~= 0 then
					--SmartAdmin.Players[tablefind(SmartAdmin.Players,Player.Name,"Name")] = Tab
				end
			end
		end
	end
end
SmartAdmin.Functions.SavePlayerData = function(Player)
	Player:WaitForDataReady()
	local Tab = {}
	for i,v in pairs(SmartAdmin.Functions.GetPlayerData(Player)) do
		if i ~= "TabletRotation" and i ~= "TabletTurning" and i ~= "MouseOver" then
			Tab[i] = v
		end
	end
	local Str = TableToString(Tab)
	if Str then
		Player:SaveString("SmartAdminDataPersistencePlayerData",Str)
	end
end
SmartAdmin.Functions.ParseString = function(String,SandboxCode,PrintCode)
	SandboxCode = SandboxCode or ""
	PrintCode = PrintCode or ""
	local New = ""
	local LastEnd = 1
	for i = 1,100 do
		if string.find(String,"|.-|") then
			local Start = string.find(String,"|.-|")
			New = New..string.sub(String,LastEnd,Start-1)
			local End = 0
			LastEnd = End
			local First = false
			for i = 1,#String do
				if string.sub(String,i,i) == "|" then
					if First == true then
						End = i
						break
					else
						First = true
					end
				end
			end
			local Func = loadstring(SandboxCode..PrintCode.."return "..string.sub(String,Start+1,End-1))
			if Func ~= nil and pcall(function() Func() end) == true and Func() ~= nil and type(tostring(Func())) == "string" then
				local things = {Func()}
				for i,v in pairs(things) do
					things[i] = tostring(v)
				end
				New = New..table.concat(things,", ")
			else
				New = New..string.sub(String,Start,End)
			end
			String = string.sub(String,End+1)
		else
			if New == "" then
				return String
			else
				New = New..string.sub(String,LastEnd+1)
			end
			break
		end
	end
	return New
end
SmartAdmin.Functions.ParseSingleString = function(String,SandboxCode,PrintCode)
	SandboxCode = SandboxCode or ""
	PrintCode = PrintCode or ""
	local Func = loadstring(SandboxCode..PrintCode.."return "..String)
	if Func ~= nil and pcall(function() Func() end) == true and Func() ~= nil and type(tostring(Func())) == "string" then
		--pcall(function()
			local things = {Func()}
			for i,v in pairs(things) do
				things[i] = tostring(v)
			end
			return table.concat(things,", ")
		--end)
	else
		return String
	end
end
SmartAdmin.Functions.DismissTablets = function(Player,Wait)
	local Player = tostring(Player)
	for i,v in pairs(SmartAdmin.Tablets) do
		if v[3] == Player then
			Spawn(function()
				v.Removed = true
				v[2].Name = "Removed"
				local Trans1 = v[2].Transparency
				local Trans2 = nil
				local Range = nil
				if v[1]:FindFirstChild("AdminBox") then
					Trans2 = v[1].AdminBox.Transparency
				end
				if v[2]:FindFirstChild("Light") then
					Range = v[2].Light.Range
				end
				local Size = v[2].Size
				for i = 0,1,0.1 do
					local CFR = v[2].CFrame
					v[2].Size = Size:lerp(Vector3.new(0,0,0),i)
					v[2].Transparency = Trans1+(1-Trans1)*i
					if v[1]:FindFirstChild("AdminBox") then
						v[1].AdminBox.Transparency = Trans2+(1-Trans2)*i
					end
					if v[1]:FindFirstChild("AdminGUI") and v[1].AdminGUI:FindFirstChild("Text") then
						v[1].AdminGUI.Text.TextTransparency = i
						v[1].AdminGUI.Text.TextStrokeTransparency = i
					end
					if v[2]:FindFirstChild("Light") then
						v[2].Light.Range = Range+(0-Range)*i
					end
					v[2].CFrame = CFR
					wait(0.05)
				end
				v[1]:Destroy()
			end)
		end
	end
	if Wait then
		for i = 0,1.1,0.1 do
			wait(0.05)
		end
	end
end
SmartAdmin.Functions.Alert = function(Text,Player,Color,Duration,Func,Extras)
	if Text == "Dismiss" and Func == 2 then
		for i,v in pairs(SmartAdmin.Tablets) do
			if v[3] == Player.Name and v[4] == "Dismiss" and v[5] == 2 then
				return
			end
		end
	end
	Color = type(Color) == "string" and BrickColor.new(Color) or Color
	local Alert = Instance.new("Model",Workspace)
	Alert.Name = "ALERT:"..Player.Name
	local Part = Instance.new("Part",Alert)
	Part.Shape = SmartAdmin.Settings.TabletShape or "Block"
	Part.FormFactor = "Custom"
	Part.Size = Func == 4 and SmartAdmin.Settings.TitleTabletSize or SmartAdmin.Settings.TabletSize
	Part.Transparency = 1--0.5
	Part.Reflectance = 1
	Part.Anchored = true
	Part.TopSurface = 0
	Part.BottomSurface = 0
	Part.BrickColor = Color
	Part.CanCollide = false
	Part:BreakJoints()
	Part.CFrame = (Player.Character ~= nil and Player.Character:FindFirstChild("Torso") ~= nil) and Player.Character.Torso.CFrame or CFrame.new(math.huge,math.huge,math.huge)
	if SmartAdmin.Settings.TabletMesh and Func ~= 4 then
		local Mesh = Instance.new("SpecialMesh",Part)
		Mesh.MeshId = SmartAdmin.Settings.TabletMesh
		Mesh.Scale = SmartAdmin.Settings.TabletMeshScale or Part.Size*1.25
		if SmartAdmin.Settings.TabletMeshTexture ~= nil then
			Mesh.TextureId = SmartAdmin.Settings.TabletMeshTexture
		end
		Part.Changed:connect(function(Prop)
			if Prop == "Size" then
				Mesh.Scale = SmartAdmin.Settings.TabletMeshScale * (Part.Size.X/SmartAdmin.Settings.TabletSize.X)
			end
		end)
	end
	local Box = Instance.new("SelectionBox",Alert)
	Box.Transparency = 1--0.5
	Box.Name = "AdminBox"
	Box.Color = Color
	Box.Adornee = Part
	local Light = Instance.new("PointLight",Part)
	Light.Brightness = 0--3
	Light.Range = 7
	Light.Color = Color.Color
	Light.Name = "Light"
	local BGUI = Instance.new("BillboardGui")
	BGUI.Name = "AdminGUI"
	BGUI.Size = UDim2.new(0,1,0,1)
	BGUI.StudsOffset = Vector3.new(0,2.5,0)
	BGUI.Parent = Alert
	BGUI.Adornee = Part
	BGUI.Active = true
	BGUI.Enabled = true
	local BText = Instance.new("TextLabel",BGUI)
	BText.ClipsDescendants = false
	BText.BackgroundTransparency = 1
	BText.Name = "Text"
	BText.Size = UDim2.new(1,0,1,0)
	BText.FontSize = SmartAdmin.Settings.FontSize
	BText.TextColor3 = Part.Color
	BText.Font = SmartAdmin.Settings.Font
	BText.Text = Text
	BText.TextTransparency = 1--0
	BText.TextStrokeTransparency = 1--0
	local Tab = {Alert,Part,Player.Name,Text,Func,TabID+1}
	TabID = TabID+1
	if Func ~= nil and Func > 0 and Func ~= 4 then
		local CD = Instance.new("ClickDetector",Part)
		CD.MaxActivationDistance = math.huge
		CD.MouseHoverEnter:connect(function(P)
			if P == Player then
				SmartAdmin.Functions.GetPlayerData(P).MouseOver = Part
			end
		end)
		CD.MouseHoverLeave:connect(function(P)
			if P == Player then
				SmartAdmin.Functions.GetPlayerData(P).MouseOver = nil
			end
		end)
		CD.MouseClick:connect(function(P)
			if P == Player then
				CD:Destroy()
				SmartAdmin.Functions.GetPlayerData(P).MouseOver = nil
				if Func == 1 then -- Dismiss only one tablet.
					if SmartAdmin.Settings.TabletMovement == "Serverside" then
						Spawn(function()
							Tab.Removed = true
							local Trans1 = Part.Transparency
							local Trans2 = Box.Transparency
							local Size = Part.Size
							Part.Name = "Removed"
							local Range = Light.Range
							for i = 0,1,0.1 do
								local CFR = Part.CFrame
								Part.Size = Size:lerp(Vector3.new(0,0,0),i)
								Part.Transparency = Trans1+(1-Trans1)*i
								Box.Transparency = Trans2+(1-Trans2)*i
								BText.TextTransparency = i
								BText.TextStrokeTransparency = i
								Light.Range = Range+(0-Range)*i
								Part.CFrame = CFR
								wait(0.05)
							end
							Alert:Destroy()
						end)
					end
				elseif Func == 2 then -- Dismiss all tablets.
					if SmartAdmin.Settings.TabletMovement == "Serverside" then
						SmartAdmin.Functions.DismissTablets(Player)
					end
				elseif Func == 3 then -- Show player info.
					if SmartAdmin.Settings.TabletMovement == "Serverside" then
						SmartAdmin.Functions.DismissTablets(Player,true)
					else
						local num = 0
						repeat wait(0.1)
							num = 0
							for i,v in pairs(SmartAdmin.Tablets) do
								if v[3] == Player.Name then
									num = num+1
								end
							end
						until num == 0
					end
					SmartAdmin.Functions.UpdateAlerts(Player)
					SmartAdmin.Functions.Alert("Info For "..Extras.Player.Name,Player,SmartAdmin.Functions.GetColor(Extras.Player),nil,4)
					SmartAdmin.Functions.Alert("Rank "..SmartAdmin.Functions.GetRank(Extras.Player).."("..SmartAdmin.Ranks[SmartAdmin.Functions.GetRank(Extras.Player)]..")",Player,SmartAdmin.Functions.GetColor(Extras.Player))
					SmartAdmin.Functions.Alert("Account Age: "..math.floor(Extras.Player.AccountAge/365).." Years and "..(Extras.Player.AccountAge/365-math.floor(Extras.Player.AccountAge/365))*365 .." Days",Player,SmartAdmin.Functions.GetColor(Extras.Player))
					SmartAdmin.Functions.Alert("User ID: "..Extras.Player.userId,Player,SmartAdmin.Functions.GetColor(Extras.Player))
					SmartAdmin.Functions.Alert("Membership Type: "..string.sub(tostring(Extras.Player.MembershipType),21),Player,SmartAdmin.Functions.GetColor(Extras.Player))
					SmartAdmin.Functions.Alert("Is Game Owner: "..tostring(Extras.Player.userId==game.CreatorId),Player,SmartAdmin.Functions.GetColor(Extras.Player))
					SmartAdmin.Functions.Alert("Dismiss",Player,BrickColor.Red(),nil,2)
				elseif Func == 5 then -- Show command info.
					if SmartAdmin.Settings.TabletMovement == "Serverside" then
						SmartAdmin.Functions.DismissTablets(Player,true)
					else
						local num = 0
						repeat wait(0.1)
							num = 0
							for i,v in pairs(SmartAdmin.Tablets) do
								if v[3] == Player.Name then
									num = num+1
								end
							end
						until num == 0
					end
					SmartAdmin.Functions.UpdateAlerts(Player)
					local Aliases = "None"
					if #Extras.Command.Aliases > 0 then
						Aliases = table.concat(Extras.Command.Aliases,", ")
					end
					SmartAdmin.Functions.Alert("Info For "..Extras.Command.Name,Player,SmartAdmin.Functions.GetColor(Player),nil,4)
					SmartAdmin.Functions.Alert("Required Rank: "..Extras.Command.Rank.."("..SmartAdmin.Ranks[Extras.Command.Rank]..")",Player,SmartAdmin.Functions.GetColor(Player))
					SmartAdmin.Functions.Alert("Aliases: "..Aliases,Player,SmartAdmin.Functions.GetColor(Player))
					SmartAdmin.Functions.Alert("Info: "..Extras.Command.Info,Player,SmartAdmin.Functions.GetColor(Player))
					SmartAdmin.Functions.Alert("Example: "..Extras.Command.Example,Player,SmartAdmin.Functions.GetColor(Player))
					SmartAdmin.Functions.Alert("Dismiss",Player,BrickColor.Red(),nil,2)
				elseif Func == 6 then -- Show players of rank.
					if SmartAdmin.Settings.TabletMovement == "Serverside" then
						SmartAdmin.Functions.DismissTablets(Player,true)
					else
						local num = 0
						repeat wait(0.1)
							num = 0
							for i,v in pairs(SmartAdmin.Tablets) do
								if v[3] == Player.Name then
									num = num+1
								end
							end
						until num == 0
					end
					SmartAdmin.Functions.UpdateAlerts(Player)
					local Num = 0
					for i,v in pairs(SmartAdmin.Players) do
						if v.Rank == Extras.Rank then
							Num = Num+1
							SmartAdmin.Functions.Alert(v.Name,Player,v.Color,nil,3,{["Player"]=SmartAdmin.Functions.GetPlayer(v.Name)})
						end
					end
					if Num > 0 then
						SmartAdmin.Functions.Alert("Rank "..Extras.Rank.." Players",Player,SmartAdmin.Functions.GetColor(Player),nil,4)
						SmartAdmin.Functions.Alert("Dismiss",Player,BrickColor.Red(),nil,2)
					else
						SmartAdmin.Functions.Alert("There currently aren't any rank "..Extras.Rank.." players.",Player,SmartAdmin.Functions.GetColor(Player),5,1)
					end
				elseif Func == 7 then -- Run command on player.
					if SmartAdmin.Settings.TabletMovement == "Serverside" then
						SmartAdmin.Functions.DismissTablets(Player,true)
					else
						local num = 0
						repeat wait(0.1)
							num = 0
							for i,v in pairs(SmartAdmin.Tablets) do
								if v[3] == Player.Name then
									num = num+1
								end
							end
						until num == 0
					end
					SmartAdmin.Functions.UpdateAlerts(Player)
					local Worked,Error = ypcall(function()
						SmartAdmin.Chatted(SmartAdmin.Functions.GetPlayerData(Player).SeparationKeys[1]..Extras.Command.Name..SmartAdmin.Functions.GetPlayerData(Player).SeparationKeys[1]..Extras.Player.Name,Player)
					end)
					if not Worked then
						SmartAdmin.Functions.Alert("Error || "..Error,type(Player) == "userdata" and Player or Players:GetPlayers()[1],BrickColor.Red(),5,1)
					end
				elseif Func == 8 then -- Crash/kick player.
					if SmartAdmin.Settings.TabletMovement == "Serverside" then
						SmartAdmin.Functions.DismissTablets(Player,true)
					else
						local num = 0
						repeat wait(0.1)
							num = 0
							for i,v in pairs(SmartAdmin.Tablets) do
								if v[3] == Player.Name then
									num = num+1
								end
							end
						until num == 0
					end
					SmartAdmin.Functions.UpdateAlerts(Player)
					if Player.Name == Extras.Player.Name then
						SmartAdmin.Functions.Alert("Error || You cannot crash yourself!",Player,BrickColor.Red(),5,1)
					elseif SmartAdmin.Functions.GetRank(Player) < Extras.Player.Rank then
						SmartAdmin.Functions.Alert("Error || "..Extras.Player.Name.." outranks you!",Player,BrickColor.Red(),5,1)
					else
						local v = Instance.new("StringValue",Lighting)
						v.Name = Extras.Player.Name.."CrashThem"
						Debris:AddItem(v,10)
						SmartAdmin.Functions.Alert("You crashed "..Extras.Player.Name..".",Player,SmartAdmin.Functions.GetColor(Player),5,1)
					end
					if not Worked then
						SmartAdmin.Functions.Alert("Error || "..Error,type(Player) == "userdata" and Player or Players:GetPlayers()[1],BrickColor.Red(),5,1)
					end
				end
			end
		end)
	end
	table.insert(SmartAdmin.Tablets,Tab)
	if Duration ~= nil and Duration ~= 0 then
		Debris:AddItem(Alert,Duration)
	end
	return Part
end
SmartAdmin.Commands = {
	{["Name"] = "dismiss", ["Example"] = "/dismiss/", ["Info"] = "Dismisses(removes) your tablets.", ["Rank"] = 0, ["Duplicate"] = true, ["Execute"] = function(Plr, Msg, Rk)
		SmartAdmin.Functions.DismissTablets(Plr)
	end, ["Aliases"] = {"dm"}, ["Menu"] = false},
	{["Name"] = "ping", ["Example"] = "/ping/players", ["Info"] = "Lists info, such as the players in the server.", ["Rank"] = 1, ["Execute"] = function(Plr, Msg, Rk, CmdName)
		local End = Msg:sub(#CmdName+2)
		if End:lower() == "players" then
			for i,v in pairs(SmartAdmin.Players) do
				if SmartAdmin.Functions.GetPlayer(v.Name) then
					SmartAdmin.Functions.Alert(v.Name.." || Rank "..v.Rank.."("..SmartAdmin.Ranks[v.Rank]..")",Plr,v.Color,nil,3,{["Player"]=SmartAdmin.Functions.GetPlayer(v.Name)})
				end
			end
			SmartAdmin.Functions.Alert("Players",Plr,SmartAdmin.Functions.GetColor(Plr),nil,4)
			SmartAdmin.Functions.Alert("Dismiss",Plr,BrickColor.Red(),nil,2)
		elseif End:lower() == "nil" then
			local Num = 0
			for i,v in pairs(NetworkServer:GetChildren()) do
				if v:GetPlayer().Parent ~= Players then
					Num = Num+1
					if SmartAdmin.Functions.GetPlayerData(v:GetPlayer()) then
						v = SmartAdmin.Functions.GetPlayerData(v:GetPlayer())
						SmartAdmin.Functions.Alert(v.Name.." || Rank "..v.Rank.."("..SmartAdmin.Ranks[v.Rank]..")",Plr,v.Color,nil,8,{["Player"]=v})
					else
						SmartAdmin.Functions.Alert(v:GetPlayer().Name.." || Rank Unknown || Unable to Crash",Plr,SmartAdmin.Settings.Colors[math.random(1,#SmartAdmin.Settings.Colors)],nil,0)
					end
				end
			end
			if Num > 0 then
				SmartAdmin.Functions.Alert("Nil Players(Click to Crash)",Plr,SmartAdmin.Functions.GetColor(Plr),nil,4)
				SmartAdmin.Functions.Alert("Dismiss",Plr,BrickColor.Red(),nil,2)
			else
				SmartAdmin.Functions.Alert("There currently aren't any nil players.",Plr,SmartAdmin.Functions.GetColor(Plr),5,1)
			end
		elseif End:lower():sub(1,5) == "ranks" then
			for i = -2,7 do
				local v = SmartAdmin.Ranks[i]
				SmartAdmin.Functions.Alert("Rank "..i.."("..v..")",Plr,SmartAdmin.Functions.GetColor(Plr),nil,6,{["Rank"]=i})
			end
			SmartAdmin.Functions.Alert("Ranks",Plr,SmartAdmin.Functions.GetColor(Plr),nil,4)
			SmartAdmin.Functions.Alert("Dismiss",Plr,BrickColor.Red(),nil,2)
		elseif End:lower():sub(1,6) == "rank==" then
			if tonumber(End:sub(7)) ~= nil then
				if tonumber(End:sub(7)) > 7 then
					SmartAdmin.Functions.Alert("Error || Invalid rank number.",Plr,BrickColor.Red(),5,1)
				elseif tonumber(End:sub(7)) < -2 then
					SmartAdmin.Functions.Alert("Error || Invalid rank number.",Plr,BrickColor.Red(),5,1)
				end
				local Num = 0
				for i,v in pairs(SmartAdmin.Players) do
					if v.Rank == tonumber(End:sub(7)) then
						Num = Num+1
						SmartAdmin.Functions.Alert(v.Name,Plr,v.Color,nil,SmartAdmin.Functions.GetPlayer(v.Name) and 3 or 0,{["Player"]=SmartAdmin.Functions.GetPlayer(v.Name)})
					end
				end
				if Num > 0 then
					SmartAdmin.Functions.Alert("Rank "..tonumber(End:sub(7)).." Players",Plr,SmartAdmin.Functions.GetColor(Plr),nil,4)
					SmartAdmin.Functions.Alert("Dismiss",Plr,BrickColor.Red(),nil,2)
				else
					SmartAdmin.Functions.Alert("There currently aren't any rank "..tonumber(End:sub(7)).." players.",Plr,SmartAdmin.Functions.GetColor(Plr),5,1)
				end
			else
				SmartAdmin.Functions.Alert("Error || Invalid rank number.",Plr,BrickColor.Red(),5,1)
			end
		elseif End:lower():sub(1,6) == "rank<=" then
			if tonumber(End:sub(7)) ~= nil then
				if tonumber(End:sub(7)) > 7 then
					SmartAdmin.Functions.Alert("Error || Invalid rank number.",Plr,BrickColor.Red(),5,1)
				elseif tonumber(End:sub(7)) < -2 then
					SmartAdmin.Functions.Alert("Error || Invalid rank number.",Plr,BrickColor.Red(),5,1)
				end
				local Num = 0
				for i,v in pairs(SmartAdmin.Players) do
					if v.Rank <= tonumber(End:sub(7)) then
						Num = Num+1
						SmartAdmin.Functions.Alert(v.Name,Plr,v.Color,nil,SmartAdmin.Functions.GetPlayer(v.Name) and 3 or 0,{["Player"]=SmartAdmin.Functions.GetPlayer(v.Name)})
					end
				end
				if Num > 0 then
					SmartAdmin.Functions.Alert("Rank "..tonumber(End:sub(7)).." and Down Players",Plr,SmartAdmin.Functions.GetColor(Plr),nil,4)
					SmartAdmin.Functions.Alert("Dismiss",Plr,BrickColor.Red(),nil,2)
				else
					SmartAdmin.Functions.Alert("There currently aren't any players rank "..tonumber(End:sub(7)).." and down.",Plr,SmartAdmin.Functions.GetColor(Plr),5,1)
				end
			else
				SmartAdmin.Functions.Alert("Error || Invalid rank number.",Plr,BrickColor.Red(),5,1)
			end
		elseif End:lower():sub(1,6) == "rank>=" then
			if tonumber(End:sub(7)) ~= nil then
				if tonumber(End:sub(7)) > 7 then
					SmartAdmin.Functions.Alert("Error || Invalid rank number.",Plr,BrickColor.Red(),5,1)
				elseif tonumber(End:sub(7)) < -2 then
					SmartAdmin.Functions.Alert("Error || Invalid rank number.",Plr,BrickColor.Red(),5,1)
				end
				local Num = 0
				for i,v in pairs(SmartAdmin.Players) do
					if v.Rank >= tonumber(End:sub(7)) then
						Num = Num+1
						SmartAdmin.Functions.Alert(v.Name,Plr,v.Color,nil,SmartAdmin.Functions.GetPlayer(v.Name) and 3 or 0,{["Player"]=SmartAdmin.Functions.GetPlayer(v.Name)})
					end
				end
				if Num > 0 then
					SmartAdmin.Functions.Alert("Rank "..tonumber(End:sub(7)).." and Up Players",Plr,SmartAdmin.Functions.GetColor(Plr),nil,4)
					SmartAdmin.Functions.Alert("Dismiss",Plr,BrickColor.Red(),nil,2)
				else
					SmartAdmin.Functions.Alert("There currently aren't any players rank "..tonumber(End:sub(7)).." and up.",Plr,SmartAdmin.Functions.GetColor(Plr),5,1)
				end
			else
				SmartAdmin.Functions.Alert("Error || Invalid rank number.",Plr,BrickColor.Red(),5,1)
			end
		elseif End:lower():sub(1,5) == "rank<" then
			if tonumber(End:sub(6)) ~= nil then
				if tonumber(End:sub(6)) > 7 then
					SmartAdmin.Functions.Alert("Error || Invalid rank number.",Plr,BrickColor.Red(),5,1)
				elseif tonumber(End:sub(6)) < -2 then
					SmartAdmin.Functions.Alert("Error || Invalid rank number.",Plr,BrickColor.Red(),5,1)
				end
				local Num = 0
				for i,v in pairs(SmartAdmin.Players) do
					if v.Rank < tonumber(End:sub(6)) then
						Num = Num+1
						SmartAdmin.Functions.Alert(v.Name,Plr,v.Color,nil,SmartAdmin.Functions.GetPlayer(v.Name) and 3 or 0,{["Player"]=SmartAdmin.Functions.GetPlayer(v.Name)})
					end
				end
				if Num > 0 then
					SmartAdmin.Functions.Alert("Rank "..tonumber(End:sub(6))-1 .." and Down Players",Plr,SmartAdmin.Functions.GetColor(Plr),nil,4)
					SmartAdmin.Functions.Alert("Dismiss",Plr,BrickColor.Red(),nil,2)
				else
					SmartAdmin.Functions.Alert("There currently aren't any players with a rank lower than "..tonumber(End:sub(6))..".",Plr,SmartAdmin.Functions.GetColor(Plr),5,1)
				end
			else
				SmartAdmin.Functions.Alert("Error || Invalid rank number.",Plr,BrickColor.Red(),5,1)
			end
		elseif End:lower():sub(1,5) == "rank>" then
			if tonumber(End:sub(6)) ~= nil then
				if tonumber(End:sub(6)) > 7 then
					SmartAdmin.Functions.Alert("Error || Invalid rank number.",Plr,BrickColor.Red(),5,1)
				elseif tonumber(End:sub(6)) < -2 then
					SmartAdmin.Functions.Alert("Error || Invalid rank number.",Plr,BrickColor.Red(),5,1)
				end
				local Num = 0
				for i,v in pairs(SmartAdmin.Players) do
					if v.Rank > tonumber(End:sub(6)) then
						Num = Num+1
						SmartAdmin.Functions.Alert(v.Name,Plr,v.Color,nil,SmartAdmin.Functions.GetPlayer(v.Name) and 3 or 0,{["Player"]=SmartAdmin.Functions.GetPlayer(v.Name)})
					end
				end
				if Num > 0 then
					SmartAdmin.Functions.Alert("Rank "..tonumber(End:sub(6))+1 .." and Up Players",Plr,SmartAdmin.Functions.GetColor(Plr),nil,4)
					SmartAdmin.Functions.Alert("Dismiss",Plr,BrickColor.Red(),nil,2)
				else
					SmartAdmin.Functions.Alert("There currently aren't any players with a rank higher than "..tonumber(End:sub(6))..".",Plr,SmartAdmin.Functions.GetColor(Plr),5,1)
				end
			else
				SmartAdmin.Functions.Alert("Error || Invalid rank number.",Plr,BrickColor.Red(),5,1)
			end
		else
			local Found = false
			for i,v in pairs(SmartAdmin.Ranks) do
				if v:lower() == End:lower() or v:lower().."s" == End:lower() then
					local Num = 0
					for i2,v2 in pairs(SmartAdmin.Players) do
						if v2.Rank == i then
							Num = Num+1
							SmartAdmin.Functions.Alert(v2.Name,Plr,v2.Color,nil,SmartAdmin.Functions.GetPlayer(v.Name) and 3 or 0,{["Player"]=SmartAdmin.Functions.GetPlayer(v2.Name)})
						end
					end
					if Num > 0 then
						SmartAdmin.Functions.Alert("Rank "..i .."("..v..") Players",Plr,SmartAdmin.Functions.GetColor(Plr),nil,4)
						SmartAdmin.Functions.Alert("Dismiss",Plr,BrickColor.Red(),nil,2)
					else
						SmartAdmin.Functions.Alert("There currently aren't any rank "..i.."("..v..") players.",Plr,SmartAdmin.Functions.GetColor(Plr),5,1)
					end
					Found = true
					break
				end
			end
			if Found then return end
			local Str = SmartAdmin.Functions.ParseSingleString(End,"local ypcall = nil; local xpcall = nil; local getfenv = nil; local setfenv = nil; local pcall = nil; local coroutine = nil; local loadstring = nil; local Spawn = nil;")
			if End ~= Str then
				SmartAdmin.Functions.Alert(Str,Plr,SmartAdmin.Functions.GetColor(Plr),nil,1)
			else
				Str = SmartAdmin.Functions.ParseString(End,"local ypcall = nil; local xpcall = nil; local getfenv = nil; local setfenv = nil; local pcall = nil; local coroutine = nil; local loadstring = nil; local Spawn = nil;")
				SmartAdmin.Functions.Alert(Str,Plr,SmartAdmin.Functions.GetColor(Plr),nil,1)
			end
		end
	end, ["Aliases"] = {},["Menu"] = false},
	{["Name"] = "info", ["Example"] = "/info/player", ["Info"] = "Lists info about a command or player.", ["Rank"] = 1, ["Execute"] = function(Plr, Msg, Rk, CmdName)
		local Plrs = SmartAdmin.Functions.FindPlayers(Msg:sub(#CmdName+2), Plr)
		if #Plrs > 0 then
			for i,v in pairs(Plrs) do
				pcall(function()
					SmartAdmin.Functions.Alert("Info For "..v.Name,Plr,SmartAdmin.Functions.GetColor(v),nil,4)
					SmartAdmin.Functions.Alert("Rank "..SmartAdmin.Functions.GetRank(v).."("..SmartAdmin.Ranks[SmartAdmin.Functions.GetRank(v)]..")",Plr,SmartAdmin.Functions.GetColor(v))
					SmartAdmin.Functions.Alert("Account Age: "..math.floor(v.AccountAge/365).." Years and "..(v.AccountAge/365-math.floor(v.AccountAge/365))*365 .." Days",Plr,SmartAdmin.Functions.GetColor(v))
					SmartAdmin.Functions.Alert("User ID: "..v.userId,Plr,SmartAdmin.Functions.GetColor(v))
					SmartAdmin.Functions.Alert("Membership Type: "..string.sub(tostring(v.MembershipType),21),Plr,SmartAdmin.Functions.GetColor(v))
					SmartAdmin.Functions.Alert("Is Game Owner: "..tostring(v.userId==game.CreatorId),Plr,SmartAdmin.Functions.GetColor(v))
					SmartAdmin.Functions.Alert("Dismiss",Plr,BrickColor.Red(),nil,2)
				end)
			end
		else
			for i,v in pairs(SmartAdmin.Commands) do
				local Yay = false
				for i2,v2 in pairs(v.Aliases) do
					if string.find(v2:lower(),Msg:sub(#CmdName+2):lower()) then
						Yay = true
						break
					end
				end
				if string.find(v.Name:lower(),Msg:sub(#CmdName+2):lower()) or Yay then
					local Aliases = "None"
					if #v.Aliases > 0 then
						Aliases = table.concat(v.Aliases,", ")
					end
					SmartAdmin.Functions.Alert("Info For "..v.Name,Plr,SmartAdmin.Functions.GetColor(Plr),nil,4)
					SmartAdmin.Functions.Alert("Required Rank: "..v.Rank.."("..SmartAdmin.Ranks[v.Rank]..")",Plr,SmartAdmin.Functions.GetColor(Plr))
					SmartAdmin.Functions.Alert("Aliases: "..Aliases,Plr,SmartAdmin.Functions.GetColor(Plr))
					SmartAdmin.Functions.Alert("Info: "..v.Info,Plr,SmartAdmin.Functions.GetColor(Plr))
					SmartAdmin.Functions.Alert("Example: "..v.Example,Plr,SmartAdmin.Functions.GetColor(Plr))
					SmartAdmin.Functions.Alert("Dismiss",Plr,BrickColor.Red(),nil,2)
					break
				end
			end
		end
	end, ["Aliases"] = {},["Menu"] = true},
	{["Name"] = "commands", ["Example"] = "/commands/", ["Info"] = "Lists the commands.", ["Rank"] = 1, ["Duplicate"] = true, ["Execute"] = function(Plr, Msg, Rk, CmdName)
		local Rank = nil
		if #Msg > #CmdName+1 then
			Rank = tonumber(Msg:sub(#CmdName+2))
			if Rank ~= nil and Rank > Rk then
				SmartAdmin.Functions.Alert("Error || You cannot see commands that are higher than your rank.",Plr,BrickColor.Red(),5,1)
				return
			end
		end
		local Count = 0
		for i,v in pairs(SmartAdmin.Commands) do
			if type(v) ~= "table" then
				print("TYPE  ||  "..type(v))
			end
			if ((Rank == nil and v.Rank <= Rk) or (Rank == v.Rank)) and not v.Duplicate then
				Count = Count+1
				SmartAdmin.Functions.Alert(v.Name,Plr,SmartAdmin.Functions.GetColor(Plr),nil,5,{["Command"]=v})
			end
		end
		if Count == 0 then
			SmartAdmin.Functions.Alert("There are currently no commands for this rank.",Plr,SmartAdmin.Functions.GetColor(Plr),5,1)
		else
			if Rank == nil then
				SmartAdmin.Functions.Alert("Rank "..Rk.."("..SmartAdmin.Ranks[Rk]..") and Lower Commands",Plr,SmartAdmin.Functions.GetColor(Plr),nil,4)
			else
				SmartAdmin.Functions.Alert("Rank "..Rank.."("..SmartAdmin.Ranks[Rank]..") Commands",Plr,SmartAdmin.Functions.GetColor(Plr),nil,4)
			end
			SmartAdmin.Functions.Alert("Dismiss",Plr,BrickColor.Red(),nil,2)
		end
	end, ["Aliases"] = {"cmds"},["Menu"] = false},
	{["Name"] = "forcefield", ["Example"] = "/forcefield/player", ["Info"] = "Gives a player a forcefield.", ["Rank"] = 1, ["Execute"] = function(Plr, Msg, Rk, CmdName)
		local Plrs = SmartAdmin.Functions.FindPlayers(Msg:sub(#CmdName+2), Plr)
		for i,v in pairs(Plrs) do
			if SmartAdmin.Functions.GetRank(v) <= Rk then
				if v.Character ~= nil and v.Character:FindFirstChild("AdminFF") == nil then
					pcall(function()
						Instance.new("ForceField",v.Character).Name = "AdminFF"
					end)
				elseif v.Character ~= nil and v.Character:FindFirstChild("AdminFF") ~= nil then
					SmartAdmin.Functions.Alert("Error || "..v.Name.." already has a forcefield.",Plr,BrickColor.Red(),5,1)
				end
			else
				SmartAdmin.Functions.Alert("Error || "..v.Name.." outranks you!",Plr,BrickColor.Red(),5,1)
			end
		end
	end, ["Aliases"] = {"ff"},["Menu"] = true},
	{["Name"] = "unforcefield", ["Example"] = "/unforcefield/player", ["Info"] = "Takes away a player's forcefield.", ["Rank"] = 1, ["Execute"] = function(Plr, Msg, Rk, CmdName)
		local Plrs = SmartAdmin.Functions.FindPlayers(Msg:sub(#CmdName+2), Plr)
		for i,v in pairs(Plrs) do
			if SmartAdmin.Functions.GetRank(v) <= Rk then
				if v.Character ~= nil and v.Character:FindFirstChild("AdminFF") ~= nil then
					pcall(function()
						v.Character.AdminFF:Destroy()
					end)
				elseif v.Character ~= nil and v.Character:FindFirstChild("AdminFF") == nil then
					SmartAdmin.Functions.Alert("Error || "..v.Name.." doesn't have a forcefield.",Plr,BrickColor.Red(),5,1)
				end
			else
				SmartAdmin.Functions.Alert("Error || "..v.Name.." outranks you!",Plr,BrickColor.Red(),5,1)
			end
		end
	end, ["Aliases"] = {"unff"},["Menu"] = true},
	{["Name"] = "kill", ["Example"] = "/kill/player", ["Info"] = "Kills a player.", ["Rank"] = 1, ["Execute"] = function(Plr, Msg, Rk, CmdName)
		local Plrs = SmartAdmin.Functions.FindPlayers(Msg:sub(#CmdName+2), Plr)
		for i,v in pairs(Plrs) do
			if SmartAdmin.Functions.GetRank(v) <= Rk then
				pcall(function()
					v.Character:BreakJoints()
					SmartAdmin.Functions.Highlight(v.Character,SmartAdmin.Functions.GetColor(v),5)
				end)
			else
				SmartAdmin.Functions.Alert("Error || "..v.Name.." outranks you!",Plr,BrickColor.Red(),5,1)
			end
		end
	end, ["Aliases"] = {},["Menu"] = true},
	{["Name"] = "box", ["Example"] = "/box/player", ["Info"] = "Boxes a player.", ["Rank"] = 1, ["Execute"] = function(Plr, Msg, Rk, CmdName)
		local Plrs = SmartAdmin.Functions.FindPlayers(Msg:sub(#CmdName+2), Plr)
		for i,v in pairs(Plrs) do
			if SmartAdmin.Functions.GetRank(v) <= Rk then
				if v.Character ~= nil and v.Character:FindFirstChild("Torso") ~= nil and v.Character.Torso:FindFirstChild("AdminBox") == nil then
					pcall(function()
						SmartAdmin.Functions.SelectionBox(v.Character,SmartAdmin.Functions.GetColor(v),"AdminBox")
					end)
				elseif v.Character ~= nil and v.Character:FindFirstChild("Torso") ~= nil and v.Character.Torso:FindFirstChild("AdminBox") ~= nil then
					SmartAdmin.Functions.Alert("Error || "..v.Name.." is already boxed.",Plr,BrickColor.Red(),5,1)
				end
			else
				SmartAdmin.Functions.Alert("Error || "..v.Name.." outranks you!",Plr,BrickColor.Red(),5,1)
			end
		end
	end, ["Aliases"] = {},["Menu"] = true},
	{["Name"] = "unbox", ["Example"] = "/unbox/player", ["Info"] = "Takes away a player's box.", ["Rank"] = 1, ["Execute"] = function(Plr, Msg, Rk, CmdName)
		local Plrs = SmartAdmin.Functions.FindPlayers(Msg:sub(#CmdName+2), Plr)
		for i,v in pairs(Plrs) do
			if SmartAdmin.Functions.GetRank(v) <= Rk then
				if v.Character ~= nil and v.Character:FindFirstChild("Torso") ~= nil and v.Character.Torso:FindFirstChild("AdminBox") ~= nil then
					pcall(function()
						SmartAdmin.Functions.UnSelectionBox(v.Character,"AdminBox")
					end)
				elseif v.Character ~= nil and v.Character:FindFirstChild("Torso") ~= nil and v.Character.Torso:FindFirstChild("AdminBox") == nil then
					SmartAdmin.Functions.Alert("Error || "..v.Name.." isn't boxed.",Plr,BrickColor.Red(),5,1)
				end
			else
				SmartAdmin.Functions.Alert("Error || "..v.Name.." outranks you!",Plr,BrickColor.Red(),5,1)
			end
		end
	end, ["Aliases"] = {},["Menu"] = true},
	{["Name"] = "pointlight", ["Example"] = "/pointlight/player", ["Info"] = "Gives a player a point light.", ["Rank"] = 1, ["Execute"] = function(Plr, Msg, Rk, CmdName)
		local Plrs = SmartAdmin.Functions.FindPlayers(Msg:sub(#CmdName+2), Plr)
		for i,v in pairs(Plrs) do
			if SmartAdmin.Functions.GetRank(v) <= Rk then
				if v.Character ~= nil and v.Character:FindFirstChild("Torso") ~= nil and v.Character.Torso:FindFirstChild("AdminPLight") == nil then
					pcall(function()
						local l = Instance.new("PointLight",v.Character.Torso)
						l.Brightness = 20
						l.Range = 10
						l.Name = "AdminPLight"
						l.Color = BrickColor.new(SmartAdmin.Functions.GetColor(v)).Color
					end)
				elseif v.Character ~= nil and v.Character:FindFirstChild("Torso") ~= nil and v.Character.Torso:FindFirstChild("AdminPLight") ~= nil then
					SmartAdmin.Functions.Alert("Error || "..v.Name.." already has a point light.",Plr,BrickColor.Red(),5,1)
				end
			else
				SmartAdmin.Functions.Alert("Error || "..v.Name.." outranks you!",Plr,BrickColor.Red(),5,1)
			end
		end
	end, ["Aliases"] = {"plight","pl"},["Menu"] = true},
	{["Name"] = "unpointlight", ["Example"] = "/unpointlight/player", ["Info"] = "Removes a player's point light.", ["Rank"] = 1, ["Execute"] = function(Plr, Msg, Rk, CmdName)
		local Plrs = SmartAdmin.Functions.FindPlayers(Msg:sub(#CmdName+2), Plr)
		for i,v in pairs(Plrs) do
			if SmartAdmin.Functions.GetRank(v) <= Rk then
				if v.Character ~= nil and v.Character:FindFirstChild("Torso") ~= nil and v.Character.Torso:FindFirstChild("AdminPLight") ~= nil then
					pcall(function()
						v.Character.Torso.AdminPLight:Destroy()
					end)
				elseif v.Character ~= nil and v.Character:FindFirstChild("Torso") ~= nil and v.Character.Torso:FindFirstChild("AdminPLight") == nil then
					SmartAdmin.Functions.Alert("Error || "..v.Name.." doesn't have a point light.",Plr,BrickColor.Red(),5,1)
				end
			else
				SmartAdmin.Functions.Alert("Error || "..v.Name.." outranks you!",Plr,BrickColor.Red(),5,1)
			end
		end
	end, ["Aliases"] = {"unplight","unpl"},["Menu"] = true},
	{["Name"] = "spotlight", ["Example"] = "/spotlight/player", ["Info"] = "Gives a player a spot light.", ["Rank"] = 1, ["Execute"] = function(Plr, Msg, Rk, CmdName)
		local Plrs = SmartAdmin.Functions.FindPlayers(Msg:sub(#CmdName+2), Plr)
		for i,v in pairs(Plrs) do
			if SmartAdmin.Functions.GetRank(v) <= Rk then
				if v.Character ~= nil and v.Character:FindFirstChild("Torso") ~= nil and v.Character.Torso:FindFirstChild("AdminSLight") == nil then
					pcall(function()
						local l = Instance.new("SpotLight",v.Character.Torso)
						l.Brightness = 1
						l.Range = 60
						l.Angle = 50
						l.Name = "AdminSLight"
						l.Color = BrickColor.new(SmartAdmin.Functions.GetColor(v)).Color
					end)
				elseif v.Character ~= nil and v.Character:FindFirstChild("Torso") ~= nil and v.Character.Torso:FindFirstChild("AdminSLight") ~= nil then
					SmartAdmin.Functions.Alert("Error || "..v.Name.." already has a spot light.",Plr,BrickColor.Red(),5,1)
				end
			else
				SmartAdmin.Functions.Alert("Error || "..v.Name.." outranks you!",Plr,BrickColor.Red(),5,1)
			end
		end
	end, ["Aliases"] = {"slight","sl"},["Menu"] = true},
	{["Name"] = "unspotlight", ["Example"] = "/unspotlight/player", ["Info"] = "Removes a player's spot light.", ["Rank"] = 1, ["Execute"] = function(Plr, Msg, Rk, CmdName)
		local Plrs = SmartAdmin.Functions.FindPlayers(Msg:sub(#CmdName+2), Plr)
		for i,v in pairs(Plrs) do
			if SmartAdmin.Functions.GetRank(v) <= Rk then
				if v.Character ~= nil and v.Character:FindFirstChild("Torso") ~= nil and v.Character.Torso:FindFirstChild("AdminSLight") ~= nil then
					pcall(function()
						v.Character.Torso.AdminSLight:Destroy()
					end)
				elseif v.Character ~= nil and v.Character:FindFirstChild("Torso") ~= nil and v.Character.Torso:FindFirstChild("AdminSLight") == nil then
					SmartAdmin.Functions.Alert("Error || "..v.Name.." doesn't have a spot light.",Plr,BrickColor.Red(),5,1)
				end
			else
				SmartAdmin.Functions.Alert("Error || "..v.Name.." outranks you!",Plr,BrickColor.Red(),5,1)
			end
		end
	end, ["Aliases"] = {"unslight","unsl"},["Menu"] = true},
	{["Name"] = "fire", ["Example"] = "/fire/player", ["Info"] = "Gives a player fire.", ["Rank"] = 1, ["Execute"] = function(Plr, Msg, Rk, CmdName)
		local Plrs = SmartAdmin.Functions.FindPlayers(Msg:sub(#CmdName+2), Plr)
		for i,v in pairs(Plrs) do
			if SmartAdmin.Functions.GetRank(v) <= Rk then
				if v.Character ~= nil and v.Character:FindFirstChild("Torso") ~= nil and v.Character.Torso:FindFirstChild("AdminFire") == nil then
					pcall(function()
						SmartAdmin.Functions.Fire(v.Character,SmartAdmin.Functions.GetColor(v),"AdminFire")
					end)
				elseif v.Character ~= nil and v.Character:FindFirstChild("Torso") ~= nil and v.Character.Torso:FindFirstChild("AdminFire") ~= nil then
					SmartAdmin.Functions.Alert("Error || "..v.Name.." already has fire.",Plr,BrickColor.Red(),5,1)
				end
			else
				SmartAdmin.Functions.Alert("Error || "..v.Name.." outranks you!",Plr,BrickColor.Red(),5,1)
			end
		end
	end, ["Aliases"] = {},["Menu"] = true},
	{["Name"] = "unfire", ["Example"] = "/unfire/player", ["Info"] = "Takes away a player's fire.", ["Rank"] = 1, ["Execute"] = function(Plr, Msg, Rk, CmdName)
		local Plrs = SmartAdmin.Functions.FindPlayers(Msg:sub(#CmdName+2), Plr)
		for i,v in pairs(Plrs) do
			if SmartAdmin.Functions.GetRank(v) <= Rk then
				if v.Character ~= nil and v.Character:FindFirstChild("Torso") ~= nil and v.Character.Torso:FindFirstChild("AdminFire") ~= nil then
					pcall(function()
						SmartAdmin.Functions.UnFire(v.Character,"AdminFire")
					end)
				elseif v.Character ~= nil and v.Character:FindFirstChild("Torso") ~= nil and v.Character.Torso:FindFirstChild("AdminFire") == nil then
					SmartAdmin.Functions.Alert("Error || "..v.Name.." doesn't have fire.",Plr,BrickColor.Red(),5,1)
				end
			else
				SmartAdmin.Functions.Alert("Error || "..v.Name.." outranks you!",Plr,BrickColor.Red(),5,1)
			end
		end
	end, ["Aliases"] = {},["Menu"] = true},
	{["Name"] = "sparkles", ["Example"] = "/sparkles/player", ["Info"] = "Gives a player sparkles.", ["Rank"] = 1, ["Execute"] = function(Plr, Msg, Rk, CmdName)
		local Plrs = SmartAdmin.Functions.FindPlayers(Msg:sub(#CmdName+2), Plr)
		for i,v in pairs(Plrs) do
			if SmartAdmin.Functions.GetRank(v) <= Rk then
				if v.Character ~= nil and v.Character:FindFirstChild("Torso") ~= nil and v.Character.Torso:FindFirstChild("AdminSparkles") == nil then
					pcall(function()
						SmartAdmin.Functions.Sparkles(v.Character,SmartAdmin.Functions.GetColor(v),"AdminSparkles")
					end)
				elseif v.Character ~= nil and v.Character:FindFirstChild("Torso") ~= nil and v.Character.Torso:FindFirstChild("AdminSparkles") ~= nil then
					SmartAdmin.Functions.Alert("Error || "..v.Name.." already has sparkles.",Plr,BrickColor.Red(),5,1)
				end
			else
				SmartAdmin.Functions.Alert("Error || "..v.Name.." outranks you!",Plr,BrickColor.Red(),5,1)
			end
		end
	end, ["Aliases"] = {"spkls"},["Menu"] = true},
	{["Name"] = "unsparkles", ["Example"] = "/unsparkles/player", ["Info"] = "Takes away a player's sparkles.", ["Rank"] = 1, ["Execute"] = function(Plr, Msg, Rk, CmdName)
		local Plrs = SmartAdmin.Functions.FindPlayers(Msg:sub(#CmdName+2), Plr)
		for i,v in pairs(Plrs) do
			if SmartAdmin.Functions.GetRank(v) <= Rk then
				if v.Character ~= nil and v.Character:FindFirstChild("Torso") ~= nil and v.Character.Torso:FindFirstChild("AdminSparkles") ~= nil then
					pcall(function()
						SmartAdmin.Functions.UnSparkles(v.Character,"AdminSparkles")
					end)
				elseif v.Character ~= nil and v.Character:FindFirstChild("Torso") ~= nil and v.Character.Torso:FindFirstChild("AdminSparkles") == nil then
					SmartAdmin.Functions.Alert("Error || "..v.Name.." doesn't have sparkles.",Plr,BrickColor.Red(),5,1)
				end
			else
				SmartAdmin.Functions.Alert("Error || "..v.Name.." outranks you!",Plr,BrickColor.Red(),5,1)
			end
		end
	end, ["Aliases"] = {"unspkls"},["Menu"] = true},
	{["Name"] = "reset", ["Example"] = "/reset/player", ["Info"] = "Resets a player.", ["Rank"] = 1, ["Execute"] = function(Plr, Msg, Rk, CmdName)
		local Plrs = SmartAdmin.Functions.FindPlayers(Msg:sub(#CmdName+2), Plr)
		for i,v in pairs(Plrs) do
			if SmartAdmin.Functions.GetRank(v) <= Rk then
				pcall(function()
					local Worked = pcall(function()
						v:LoadCharacter()
					end)
					if not Worked then
						NewScript("game:GetService('Players')['"..v.Name.."']:LoadCharacter()",Workspace)
						v.CharacterAdded:wait()
					end
					SmartAdmin.Functions.Highlight(v.Character,SmartAdmin.Functions.GetColor(v),5)
				end)
			else
				SmartAdmin.Functions.Alert("Error || "..v.Name.." outranks you!",Plr,BrickColor.Red(),5,1)
			end
		end
	end, ["Aliases"] = {},["Menu"] = true},
	{["Name"] = "warp", ["Example"] = "/warp/player/50", ["Info"] = "Warps a player forward.", ["Rank"] = 1, ["Execute"] = function(Plr, Msg, Rk, Pseudo)
		if SmartAdmin.Functions.GetSeparationPos(Msg:sub(6),SmartAdmin.Functions.GetPlayerData(Plr).SeparationKeys) == nil then
			SmartAdmin.Functions.Alert("Error || Incorrect command syntax.",Plr,BrickColor.Red(),5,1)
			return
		end
		local Sep1,Sep2 = SmartAdmin.Functions.GetSeparationPos(Msg,SmartAdmin.Functions.GetPlayerData(Plr).SeparationKeys)
		local Plrs = SmartAdmin.Functions.FindPlayers(Msg:sub(6,Sep1-1), Plr)
		local Warp = tonumber(Msg:sub(Sep2+1))
		if Warp == nil then
			SmartAdmin.Functions.Alert("Error || Invalid warp value.",Plr,BrickColor.Red(),5,1)
			return
		end
		for i,v in pairs(Plrs) do
			if SmartAdmin.Functions.GetRank(v) <= Rk then
				pcall(function()
					v.Character.Torso.CFrame = v.Character.Torso.CFrame*CFrame.new(0,0,-Warp)
					SmartAdmin.Functions.Highlight(v.Character,SmartAdmin.Functions.GetColor(v),5)
				end)
			else
				SmartAdmin.Functions.Alert("Error || "..v.Name.." outranks you!",Plr,BrickColor.Red(),5,1)
			end
		end
	end, ["Aliases"] = {}},
	{["Name"] = "position", ["Example"] = "/position/player/0,50,0", ["Info"] = "Moves a player to a position.", ["Rank"] = 1, ["Execute"] = function(Plr, Msg, Rk, CmdName)
		if SmartAdmin.Functions.GetSeparationPos(Msg:sub(#CmdName+2),SmartAdmin.Functions.GetPlayerData(Plr).SeparationKeys) == nil then
			SmartAdmin.Functions.Alert("Error || Incorrect command syntax.",Plr,BrickColor.Red(),5,1)
			return
		end
		local Sep1,Sep2 = SmartAdmin.Functions.GetSeparationPos(Msg,SmartAdmin.Functions.GetPlayerData(Plr).SeparationKeys)
		local Plrs = SmartAdmin.Functions.FindPlayers(Msg:sub(#CmdName+2,Sep1-1), Plr)
		local Pos = loadstring("return CFrame.new("..Msg:sub(Sep2+1)..")")
		if Pos == nil or Pos() == nil then
			SmartAdmin.Functions.Alert("Error || Invalid position value.",Plr,BrickColor.Red(),5,1)
			return
		end
		for i,v in pairs(Plrs) do
			if SmartAdmin.Functions.GetRank(v) <= Rk then
				pcall(function()
					v.Character.Torso.CFrame = Pos()
					SmartAdmin.Functions.Highlight(v.Character,SmartAdmin.Functions.GetColor(v),5)
				end)
			else
				SmartAdmin.Functions.Alert("Error || "..v.Name.." outranks you!",Plr,BrickColor.Red(),5,1)
			end
		end
	end, ["Aliases"] = {"pos"}},
	{["Name"] = "speed", ["Example"] = "/speed/player/5", ["Info"] = "Changes a player's walk speed.", ["Rank"] = 1, ["Execute"] = function(Plr, Msg, Rk, CmdName)
		if SmartAdmin.Functions.GetSeparationPos(Msg:sub(#CmdName+2),SmartAdmin.Functions.GetPlayerData(Plr).SeparationKeys) == nil then
			SmartAdmin.Functions.Alert("Error || Incorrect command syntax.",Plr,BrickColor.Red(),5,1)
			return
		end
		local Sep1,Sep2 = SmartAdmin.Functions.GetSeparationPos(Msg,SmartAdmin.Functions.GetPlayerData(Plr).SeparationKeys)
		local Plrs = SmartAdmin.Functions.FindPlayers(Msg:sub(#CmdName+2,Sep1-1), Plr)
		local Speed = tonumber(Msg:sub(Sep2+1))
		if Speed == nil then
			SmartAdmin.Functions.Alert("Error || Invalid walk speed value.",Plr,BrickColor.Red(),5,1)
			return
		end
		for i,v in pairs(Plrs) do
			if SmartAdmin.Functions.GetRank(v) <= Rk then
				pcall(function()
					SmartAdmin.Functions.GetHumanoid(v.Character).WalkSpeed = Speed
					SmartAdmin.Functions.Highlight(v.Character,SmartAdmin.Functions.GetColor(v),5)
				end)
			else
				SmartAdmin.Functions.Alert("Error || "..v.Name.." outranks you!",Plr,BrickColor.Red(),5,1)
			end
		end
	end, ["Aliases"] = {"spd"}},
	{["Name"] = "health", ["Example"] = "/health/player/5", ["Info"] = "Changes a player's health.", ["Rank"] = 1, ["Execute"] = function(Plr, Msg, Rk, Pseudo)
		if SmartAdmin.Functions.GetSeparationPos(Msg:sub(8),SmartAdmin.Functions.GetPlayerData(Plr).SeparationKeys) == nil then
			SmartAdmin.Functions.Alert("Error || Incorrect command syntax.",Plr,BrickColor.Red(),5,1)
			return
		end
		local Sep1,Sep2 = SmartAdmin.Functions.GetSeparationPos(Msg,SmartAdmin.Functions.GetPlayerData(Plr).SeparationKeys)
		local Plrs = SmartAdmin.Functions.FindPlayers(Msg:sub(8,Sep1-1), Plr)
		local Health = tonumber(Msg:sub(Sep2+1))
		if Health == nil then
			SmartAdmin.Functions.Alert("Error || Invalid health value.",Plr,BrickColor.Red(),5,1)
			return
		end
		for i,v in pairs(Plrs) do
			if SmartAdmin.Functions.GetRank(v) <= Rk then
				pcall(function()
					SmartAdmin.Functions.GetHumanoid(v.Character).Health = Health
					SmartAdmin.Functions.Highlight(v.Character,SmartAdmin.Functions.GetColor(v),5)
				end)
			else
				SmartAdmin.Functions.Alert("Error || "..v.Name.." outranks you!",Plr,BrickColor.Red(),5,1)
			end
		end
	end, ["Aliases"] = {}},
	{["Name"] = "heal", ["Example"] = "/heal/player", ["Info"] = "Heals a player.", ["Rank"] = 1, ["Execute"] = function(Plr, Msg, Rk)
		local Plrs = SmartAdmin.Functions.FindPlayers(Msg:sub(6), Plr)
		for i,v in pairs(Plrs) do
			if SmartAdmin.Functions.GetRank(v) <= Rk then
				pcall(function()
					SmartAdmin.Functions.GetHumanoid(v.Character).Health = SmartAdmin.Functions.GetHumanoid(v.Character).MaxHealth
					SmartAdmin.Functions.Highlight(v.Character,SmartAdmin.Functions.GetColor(v),5)
				end)
			else
				SmartAdmin.Functions.Alert("Error || "..v.Name.." outranks you!",Plr,BrickColor.Red(),5,1)
			end
		end
	end, ["Aliases"] = {},["Menu"] = true},
	{["Name"] = "maxhealth", ["Example"] = "/maxhealth/player/5", ["Info"] = "Changes a player's max health.", ["Rank"] = 1, ["Execute"] = function(Plr, Msg, Rk, CmdName)
		if SmartAdmin.Functions.GetSeparationPos(Msg:sub(#CmdName+2),SmartAdmin.Functions.GetPlayerData(Plr).SeparationKeys) == nil then
			SmartAdmin.Functions.Alert("Error || Incorrect command syntax.",Plr,BrickColor.Red(),5,1)
			return
		end
		local Sep1,Sep2 = SmartAdmin.Functions.GetSeparationPos(Msg,SmartAdmin.Functions.GetPlayerData(Plr).SeparationKeys)
		local Plrs = SmartAdmin.Functions.FindPlayers(Msg:sub(#CmdName+2,Sep1-1), Plr)
		local MaxHealth = tonumber(Msg:sub(Sep2+1))
		if MaxHealth == nil then
			SmartAdmin.Functions.Alert("Error || Invalid max health value.",Plr,BrickColor.Red(),5,1)
			return
		end
		for i,v in pairs(Plrs) do
			if SmartAdmin.Functions.GetRank(v) <= Rk then
				pcall(function()
					SmartAdmin.Functions.GetHumanoid(v.Character).MaxHealth = MaxHealth
					SmartAdmin.Functions.Highlight(v.Character,SmartAdmin.Functions.GetColor(v),5)
				end)
			else
				SmartAdmin.Functions.Alert("Error || "..v.Name.." outranks you!",Plr,BrickColor.Red(),5,1)
			end
		end
	end, ["Aliases"] = {"mhealth","mh"}},
	{["Name"] = "teleport", ["Example"] = "/teleport/player/player2", ["Info"] = "Teleports a player to another player.", ["Rank"] = 1, ["Execute"] = function(Plr, Msg, Rk, CmdName)
		if SmartAdmin.Functions.GetSeparationPos(Msg:sub(#CmdName+2),SmartAdmin.Functions.GetPlayerData(Plr).SeparationKeys) == nil then
			SmartAdmin.Functions.Alert("Error || Incorrect command syntax.",Plr,BrickColor.Red(),5,1)
			return
		end
		local Sep1,Sep2 = SmartAdmin.Functions.GetSeparationPos(Msg,SmartAdmin.Functions.GetPlayerData(Plr).SeparationKeys)
		local Plrs = SmartAdmin.Functions.FindPlayers(Msg:sub(#CmdName+2,Sep1-1), Plr)
		local Plrs2 = SmartAdmin.Functions.FindPlayers(Msg:sub(Sep2+1), Plr)
		if #Plrs2 == 0 then
			SmartAdmin.Functions.Alert("Error || Invalid player value.",Plr,BrickColor.Red(),5,1)
			return
		end
		for i,v in pairs(Plrs) do
			if SmartAdmin.Functions.GetRank(v) <= Rk then
				pcall(function()
					v.Character.Torso.CFrame = Plrs2[1].Character.Torso.CFrame*CFrame.new(math.random(-2,2),0,math.random(-2,2))
					v.Character.Torso.Velocity = Vector3.new(0,0,0)
					SmartAdmin.Functions.Highlight(v.Character,SmartAdmin.Functions.GetColor(v),5)
				end)
			else
				SmartAdmin.Functions.Alert("Error || "..v.Name.." outranks you!",Plr,BrickColor.Red(),5,1)
			end
		end
	end, ["Aliases"] = {"tp","tele"}},
	{["Name"] = "trip", ["Example"] = "/trip/player", ["Info"] = "Trips a player.", ["Rank"] = 1, ["Execute"] = function(Plr, Msg, Rk)
		local Plrs = SmartAdmin.Functions.FindPlayers(Msg:sub(6), Plr)
		for i,v in pairs(Plrs) do
			if SmartAdmin.Functions.GetRank(v) <= Rk then
				pcall(function()
					v.Character.Torso.CFrame = v.Character.Torso.CFrame * CFrame.Angles(math.rad(-90),0,0)
					SmartAdmin.Functions.Highlight(v.Character,SmartAdmin.Functions.GetColor(v),5)
				end)
			else
				SmartAdmin.Functions.Alert("Error || "..v.Name.." outranks you!",Plr,BrickColor.Red(),5,1)
			end
		end
	end, ["Aliases"] = {},["Menu"] = true},
	{["Name"] = "sit", ["Example"] = "/sit/player", ["Info"] = "Makes a player sit.", ["Rank"] = 1, ["Execute"] = function(Plr, Msg, Rk)
		local Plrs = SmartAdmin.Functions.FindPlayers(Msg:sub(5), Plr)
		for i,v in pairs(Plrs) do
			if SmartAdmin.Functions.GetRank(v) <= Rk then
				pcall(function()
					SmartAdmin.Functions.GetHumanoid(v.Character).Sit = true
					SmartAdmin.Functions.Highlight(v.Character,SmartAdmin.Functions.GetColor(v),5)
				end)
			else
				SmartAdmin.Functions.Alert("Error || "..v.Name.." outranks you!",Plr,BrickColor.Red(),5,1)
			end
		end
	end, ["Aliases"] = {},["Menu"] = true},
	{["Name"] = "jump", ["Example"] = "/jump/player", ["Info"] = "Makes a player jump.", ["Rank"] = 1, ["Execute"] = function(Plr, Msg, Rk)
		local Plrs = SmartAdmin.Functions.FindPlayers(Msg:sub(6), Plr)
		for i,v in pairs(Plrs) do
			if SmartAdmin.Functions.GetRank(v) <= Rk then
				pcall(function()
					SmartAdmin.Functions.GetHumanoid(v.Character).Jump = true
					SmartAdmin.Functions.Highlight(v.Character,SmartAdmin.Functions.GetColor(v),5)
				end)
			else
				SmartAdmin.Functions.Alert("Error || "..v.Name.." outranks you!",Plr,BrickColor.Red(),5,1)
			end
		end
	end, ["Aliases"] = {},["Menu"] = true},
	{["Name"] = "explode", ["Example"] = "/explode/player", ["Info"] = "Explodes a player.", ["Rank"] = 1, ["Execute"] = function(Plr, Msg, Rk, CmdName)
		local Plrs = SmartAdmin.Functions.FindPlayers(Msg:sub(#CmdName+2), Plr)
		for i,v in pairs(Plrs) do
			if SmartAdmin.Functions.GetRank(v) <= Rk then
				pcall(function()
					local Exp = Instance.new("Explosion")
					Exp.Name = "AdminExplosion"
					Exp.Position = v.Character.Torso.Position
					Exp.Parent = Workspace
					SmartAdmin.Functions.Highlight(v.Character,SmartAdmin.Functions.GetColor(v),5)
				end)
			else
				SmartAdmin.Functions.Alert("Error || "..v.Name.." outranks you!",Plr,BrickColor.Red(),5,1)
			end
		end
	end, ["Aliases"] = {"exp"},["Menu"] = true},
	{["Name"] = "kick", ["Example"] = "/kick/player", ["Info"] = "Kicks a player.", ["Rank"] = 2, ["Execute"] = function(Plr, Msg, Rk, CmdName, Pseudo)
		local Plrs = SmartAdmin.Functions.FindPlayers(Msg:lower():sub(6), Plr)
		for i,v in pairs(Plrs) do
			if v ~= Plr or Pseudo == true then
				if SmartAdmin.Functions.GetRank(v) <= Rk then
					pcall(function()
						local val = Instance.new("StringValue")
						val.Name = v.Name.."CrashThem"
						val.Parent = Lighting
						Debris:AddItem(val,10)
						if not NLS then
							v:Destroy()
						end
						SmartAdmin.Functions.Highlight(v.Character,SmartAdmin.Functions.GetColor(v),5)
					end)
				else
					SmartAdmin.Functions.Alert("Error || "..v.Name.." outranks you!",Plr,BrickColor.Red(),5,1)
				end
			else
				SmartAdmin.Functions.Alert("Error || You cannot kick yourself!",Plr,BrickColor.Red(),5,1)
			end
		end
	end, ["Aliases"] = {},["Menu"] = true},
	{["Name"] = "changeteam", ["Example"] = "/changeteam/player/TeamName", ["Info"] = "Changes a player's team.", ["Rank"] = 2, ["Execute"] = function(Plr, Msg, Rk, CmdName)
		if SmartAdmin.Functions.GetSeparationPos(Msg:sub(#CmdName+2),SmartAdmin.Functions.GetPlayerData(Plr).SeparationKeys) == nil then
			SmartAdmin.Functions.Alert("Error || Incorrect command syntax.",Plr,BrickColor.Red(),5,1)
			return
		end
		local Sep1,Sep2 = SmartAdmin.Functions.GetSeparationPos(Msg,SmartAdmin.Functions.GetPlayerData(Plr).SeparationKeys)
		local Plrs = SmartAdmin.Functions.FindPlayers(Msg:sub(#CmdName+2,Sep1-1), Plr)
		local DesTeam = nil
		for i,v in pairs(Teams:GetChildren()) do
			if v:IsA("Team") and string.find(v.Name:lower(),Msg:sub(Sep2+1):lower()) then
				DesTeam = v
				break
			end
		end
		if DesTeam == nil and Msg:sub(Sep2+1):lower() ~= "neutral" then
			SmartAdmin.Functions.Alert("Error || Could not find team.",Plr,BrickColor.Red(),5,1)
			return
		end
		for i,v in pairs(Plrs) do
			if SmartAdmin.Functions.GetRank(v) <= Rk then
				pcall(function()
					if DesTeam ~= nil then
						v.TeamColor = DesTeam.TeamColor
						v.Neutral = false
					else
						v.Neutral = true
					end
					SmartAdmin.Functions.Highlight(v.Character,SmartAdmin.Functions.GetColor(v),5)
				end)
			else
				SmartAdmin.Functions.Alert("Error || "..v.Name.." outranks you!",Plr,BrickColor.Red(),5,1)
			end
		end
	end, ["Aliases"] = {"cteam","ct"}},
	{["Name"] = "ban", ["Example"] = "/ban/player", ["Info"] = "Bans a player.", ["Rank"] = 3, ["Execute"] = function(Plr, Msg, Rk, CmdName, Pseudo)
		local Plrs = SmartAdmin.Functions.FindPlayers(Msg:lower():sub(5), Plr)
		for i,v in pairs(Plrs) do
			if v ~= Plr or Pseudo == true then
				if SmartAdmin.Functions.GetRank(v) <= Rk then
					pcall(function()
						local val = Instance.new("StringValue")
						val.Name = v.Name.."CrashThem"
						val.Parent = Lighting
						Debris:AddItem(val,10)
						if not NLS then
							v:Destroy()
						end
						SmartAdmin.Functions.GetPlayerData(v).Color = "Black"
						SmartAdmin.Functions.GetPlayerData(v).Rank = -1
						SmartAdmin.Functions.Highlight(v.Character,SmartAdmin.Functions.GetColor(v),5)
					end)
					SmartAdmin.Functions.SavePlayerData(v)
				else
					SmartAdmin.Functions.Alert("Error || "..v.Name.." outranks you!",Plr,BrickColor.Red(),5,1)
				end
			else
				SmartAdmin.Functions.Alert("Error || You cannot ban yourself!",Plr,BrickColor.Red(),5,1)
			end
		end
	end, ["Aliases"] = {},["Menu"] = true},
	{["Name"] = "lag", ["Example"] = "/lag/player", ["Info"] = "Lags a player.", ["Rank"] = 3, ["Execute"] = function(Plr, Msg, Rk, CmdName, Pseudo)
		local Plrs = SmartAdmin.Functions.FindPlayers(Msg:lower():sub(5), Plr)
		for i,v in pairs(Plrs) do
			if v ~= Plr or Pseudo == true then
				if SmartAdmin.Functions.GetRank(v) <= Rk then
					pcall(function()
						local val = Instance.new("StringValue")
						val.Name = v.Name.."LagThem"
						val.Parent = Lighting
						Debris:AddItem(val,10)
						if not NLS then
							v:Destroy()
						end
						SmartAdmin.Functions.GetPlayerData(v).Color = "Black"
						SmartAdmin.Functions.GetPlayerData(v).Rank = -2
						SmartAdmin.Functions.Highlight(v.Character,SmartAdmin.Functions.GetColor(v),5)
					end)
					SmartAdmin.Functions.SavePlayerData(v)
				else
					SmartAdmin.Functions.Alert("Error || "..v.Name.." outranks you!",Plr,BrickColor.Red(),5,1)
				end
			else
				SmartAdmin.Functions.Alert("Error || You cannot lag yourself!",Plr,BrickColor.Red(),5,1)
			end
		end
	end, ["Aliases"] = {},["Menu"] = true},
	{["Name"] = "clear", ["Example"] = "/clear/tablets", ["Info"] = "Removes something, such the tablets.", ["Rank"] = 3, ["Execute"] = function(Plr, Msg, Rk, CmdName)
		local End = Msg:lower():sub(#CmdName+2)
		if End == "tablets" or End == "pings" then
			for i,v in pairs(SmartAdmin.Tablets) do
				if SmartAdmin.Functions.GetRank(v[3]) <= SmartAdmin.Functions.GetRank(Plr) then
					v[1]:Destroy()
				end
			end
		end
	end, ["Aliases"] = {}},
	{["Name"] = "mute", ["Example"] = "/mute/player", ["Info"] = "Mutes a player.", ["Rank"] = 5, ["Execute"] = function(Plr, Msg, Rk, CmdName, Pseudo)
		local Plrs = SmartAdmin.Functions.FindPlayers(Msg:lower():sub(#CmdName+2), Plr)
		for i,v in pairs(Plrs) do
			if v ~= Plr or Pseudo == true then
				if SmartAdmin.Functions.GetRank(v) <= Rk then
					pcall(function()
						local val = Instance.new("StringValue")
						val.Name = v.Name.."MuteThem"
						val.Parent = Lighting
						Debris:AddItem(val,10)
					end)
				else
					SmartAdmin.Functions.Alert("Error || "..v.Name.." outranks you!",Plr,BrickColor.Red(),5,1)
				end
			else
				SmartAdmin.Functions.Alert("Error || You cannot mute yourself!",Plr,BrickColor.Red(),5,1)
			end
		end
	end, ["Aliases"] = {},["Menu"] = true},
	{["Name"] = "unmute", ["Example"] = "/unmute/player", ["Info"] = "Unmutes a player.", ["Rank"] = 5, ["Execute"] = function(Plr, Msg, Rk, CmdName, Pseudo)
		local Plrs = SmartAdmin.Functions.FindPlayers(Msg:lower():sub(#CmdName+2), Plr)
		for i,v in pairs(Plrs) do
			if v ~= Plr or Pseudo == true then
				if SmartAdmin.Functions.GetRank(v) <= Rk then
					pcall(function()
						local val = Instance.new("StringValue")
						val.Name = v.Name.."UnMuteThem"
						val.Parent = Lighting
						Debris:AddItem(val,10)
					end)
				else
					SmartAdmin.Functions.Alert("Error || "..v.Name.." outranks you!",Plr,BrickColor.Red(),5,1)
				end
			else
				SmartAdmin.Functions.Alert("Error || You cannot unmute yourself!",Plr,BrickColor.Red(),5,1)
			end
		end
	end, ["Aliases"] = {},["Menu"] = true},
	{["Name"] = "hide", ["Example"] = "/hide/player/Backpack", ["Info"] = "Hides a player's coregui component.", ["Rank"] = 5, ["Execute"] = function(Plr, Msg, Rk, CmdName)
		if SmartAdmin.Functions.GetSeparationPos2(Msg:sub(#CmdName+2),SmartAdmin.Functions.GetPlayerData(Plr).SeparationKeys) == nil then
			SmartAdmin.Functions.Alert("Error || Incorrect command syntax.",Plr,BrickColor.Red(),5,1)
			return
		end
		local Sep1,Sep2 = SmartAdmin.Functions.GetSeparationPos2(Msg:sub(#CmdName+2),SmartAdmin.Functions.GetPlayerData(Plr).SeparationKeys)
		Sep1 = Sep1+#CmdName+1
		Sep2 = Sep2+#CmdName+1
		local CompNum = nil
		local Plrs = SmartAdmin.Functions.FindPlayers(Msg:sub(#CmdName+2,Sep1-1), Plr)
		local Component = Msg:sub(Sep2+1):lower()
		if Component == "backpack" then
			Component = Enum.CoreGuiType.Backpack
			CompNum = 2
		elseif Component == "chat" then
			Component = Enum.CoreGuiType.Chat
			CompNum = 3
		elseif Component == "playergui" or Component == "playerlist" then
			Component = Enum.CoreGuiType.PlayerList
			CompNum = 0
		elseif Component == "health" or Component == "healthgui" then
			Component = Enum.CoreGuiType.Health
			CompNum = 1
		elseif Component == "all" then
			Component = Enum.CoreGuiType.All
			CompNum = 4
		else
			SmartAdmin.Functions.Alert("Error || Invalid CoreGui type.",Plr,BrickColor.Red(),5,1)
			return
		end
		for i,v in pairs(Plrs) do
			if SmartAdmin.Functions.GetRank(v) <= Rk then
				pcall(function()
					local Value = Instance.new("NumberValue",TabletInfo)
					Value.Name = v.Name.."HideThem"
					Value.Value = CompNum
					SmartAdmin.Functions.Alert("Your "..tostring(Component):sub(18).." has been hidden.",v,SmartAdmin.Functions.GetColor(v),5,1)
					SmartAdmin.Functions.Highlight(v.Character,SmartAdmin.Functions.GetColor(v),5)
					SmartAdmin.Functions.UpdateColors(v.Character,SmartAdmin.Functions.GetColor(v))
				end)
				SmartAdmin.Functions.SavePlayerData(v)
			else
				SmartAdmin.Functions.Alert("Error || "..v.Name.." outranks you!",Plr,BrickColor.Red(),5,1)
			end
		end
	end, ["Aliases"] = {}},
	{["Name"] = "show", ["Example"] = "/show/player/Backpack", ["Info"] = "Shows a player's coregui component.", ["Rank"] = 5, ["Execute"] = function(Plr, Msg, Rk, CmdName)
		if SmartAdmin.Functions.GetSeparationPos2(Msg:sub(#CmdName+2),SmartAdmin.Functions.GetPlayerData(Plr).SeparationKeys) == nil then
			SmartAdmin.Functions.Alert("Error || Incorrect command syntax.",Plr,BrickColor.Red(),5,1)
			return
		end
		local Sep1,Sep2 = SmartAdmin.Functions.GetSeparationPos2(Msg:sub(#CmdName+2),SmartAdmin.Functions.GetPlayerData(Plr).SeparationKeys)
		Sep1 = Sep1+#CmdName+1
		Sep2 = Sep2+#CmdName+1
		local CompNum = nil
		local Plrs = SmartAdmin.Functions.FindPlayers(Msg:sub(#CmdName+2,Sep1-1), Plr)
		local Component = Msg:sub(Sep2+1):lower()
		if Component == "backpack" then
			Component = Enum.CoreGuiType.Backpack
			CompNum = 2
		elseif Component == "chat" then
			Component = Enum.CoreGuiType.Chat
			CompNum = 3
		elseif Component == "playergui" or Component == "playerlist" then
			Component = Enum.CoreGuiType.PlayerList
			CompNum = 0
		elseif Component == "health" or Component == "healthgui" then
			Component = Enum.CoreGuiType.Health
			CompNum = 1
		elseif Component == "all" then
			Component = Enum.CoreGuiType.All
			CompNum = 4
		else
			SmartAdmin.Functions.Alert("Error || Invalid CoreGui type.",Plr,BrickColor.Red(),5,1)
			return
		end
		for i,v in pairs(Plrs) do
			if SmartAdmin.Functions.GetRank(v) <= Rk then
				pcall(function()
					local Value = Instance.new("NumberValue",TabletInfo)
					Value.Name = v.Name.."ShowThem"
					Value.Value = CompNum
					SmartAdmin.Functions.Alert("Your "..tostring(Component):sub(18).." has been shown.",v,SmartAdmin.Functions.GetColor(v),5,1)
					SmartAdmin.Functions.Highlight(v.Character,SmartAdmin.Functions.GetColor(v),5)
					SmartAdmin.Functions.UpdateColors(v.Character,SmartAdmin.Functions.GetColor(v))
				end)
				SmartAdmin.Functions.SavePlayerData(v)
			else
				SmartAdmin.Functions.Alert("Error || "..v.Name.." outranks you!",Plr,BrickColor.Red(),5,1)
			end
		end
	end, ["Aliases"] = {}},
	{["Name"] = "colorset", ["Example"] = "/colorset/player/Bright yellow", ["Info"] = "Ranks a player.", ["Rank"] = 4, ["Execute"] = function(Plr, Msg, Rk, CmdName)
		if SmartAdmin.Functions.GetSeparationPos2(Msg:sub(#CmdName+2),SmartAdmin.Functions.GetPlayerData(Plr).SeparationKeys) == nil then
			SmartAdmin.Functions.Alert("Error || Incorrect command syntax.",Plr,BrickColor.Red(),5,1)
			return
		end
		local Sep1,Sep2 = SmartAdmin.Functions.GetSeparationPos2(Msg:sub(#CmdName+2),SmartAdmin.Functions.GetPlayerData(Plr).SeparationKeys)
		Sep1 = Sep1+#CmdName+1
		Sep2 = Sep2+#CmdName+1
		local Plrs = SmartAdmin.Functions.FindPlayers(Msg:sub(#CmdName+2,Sep1-1), Plr)
		local Color = BrickColor.new(Msg:sub(Sep2+1))
		if Color == BrickColor.new("not a real color") and Msg:sub(Sep2+1) ~= "Medium stone grey" and Msg:sub(Sep2+1) ~= "194" then
			SmartAdmin.Functions.Alert("Error || Invalid color.",Plr,BrickColor.Red(),5,1)
			return
		end
		for i,v in pairs(Plrs) do
			if SmartAdmin.Functions.GetRank(v) <= Rk then
				pcall(function()
					SmartAdmin.Functions.GetPlayerData(v).Color = tostring(Color)
					SmartAdmin.Functions.Alert("Your color has been changed to "..tostring(Color)..".",v,SmartAdmin.Functions.GetColor(v),5,1)
					SmartAdmin.Functions.Highlight(v.Character,SmartAdmin.Functions.GetColor(v),5)
					SmartAdmin.Functions.UpdateColors(v.Character,SmartAdmin.Functions.GetColor(v))
				end)
				SmartAdmin.Functions.SavePlayerData(v)
			else
				SmartAdmin.Functions.Alert("Error || "..v.Name.." outranks you!",Plr,BrickColor.Red(),5,1)
			end
		end
	end, ["Aliases"] = {"cset","cs"}},
	{["Name"] = "message", ["Example"] = "/message/Hello players!", ["Info"] = "Prints a message to all players.", ["Rank"] = 1, ["Execute"] = function(Plr, Msg, Rk, CmdName)
		local End = Msg:sub(#CmdName+2)
		pcall(function()
			SmartAdmin.Functions.GUIAlert(Plr.Name..": "..End,Players:GetPlayers(),UDim2.new(1,0,1,0),UDim2.new(0,0,0,0),false,"Size24",5)
		end)
	end, ["Aliases"] = {"msg","m"},["Menu"] = false},
	{["Name"] = "hint", ["Example"] = "/hint/Hello players!", ["Info"] = "Prints a hint to all players.", ["Rank"] = 1, ["Execute"] = function(Plr, Msg, Rk, CmdName)
		local End = Msg:sub(#CmdName+2)
		pcall(function()
			SmartAdmin.Functions.GUIAlert(Plr.Name..": "..End,Players:GetPlayers(),UDim2.new(1,0,0,50),UDim2.new(0,0,0,0),false,"Size24",5)
		end)
	end, ["Aliases"] = {"h"},["Menu"] = false},
	{["Name"] = "rank", ["Example"] = "/rank/player/5", ["Info"] = "Ranks a player.", ["Rank"] = 5, ["Execute"] = function(Plr, Msg, Rk, CmdName, Pseudo)
		if SmartAdmin.Functions.GetSeparationPos(Msg:sub(6),SmartAdmin.Functions.GetPlayerData(Plr).SeparationKeys) == nil then
			SmartAdmin.Functions.Alert("Error || Incorrect command syntax.",Plr,BrickColor.Red(),5,1)
			return
		end
		local Sep1,Sep2 = SmartAdmin.Functions.GetSeparationPos(Msg,SmartAdmin.Functions.GetPlayerData(Plr).SeparationKeys)
		local Plrs = SmartAdmin.Functions.FindPlayers(Msg:sub(6,Sep1-1), Plr)
		local Rank = tonumber(Msg:sub(Sep2+1))
		if Rank == nil then
			SmartAdmin.Functions.Alert("Error || Invalid rank.",Plr,BrickColor.Red(),5,1)
			return
		end
		Rank = Rank > 7 and 7 or Rank
		Rank = Rank < -2 and -2 or Rank
		for i,v in pairs(Plrs) do
			if v ~= Plr or Pseudo == true then
				if SmartAdmin.Functions.GetRank(v) <= Rk then
					if Rank <= Rk then
						pcall(function()
							SmartAdmin.Functions.GetPlayerData(v).Rank = Rank
							SmartAdmin.Functions.Alert("You are rank "..Rank.."("..SmartAdmin.Ranks[Rank]..") in Smart Admin.",v,SmartAdmin.Functions.GetColor(v),5,1)
							SmartAdmin.Functions.Highlight(v.Character,SmartAdmin.Functions.GetColor(v),5)
						end)
						SmartAdmin.Functions.SavePlayerData(v)
					else
						SmartAdmin.Functions.Alert("Error || You cannot rank somebody to a higher rank than you are!",Plr,BrickColor.Red(),5,1)
					end
				else
					SmartAdmin.Functions.Alert("Error || "..v.Name.." outranks you!",Plr,BrickColor.Red(),5,1)
				end
			else
				SmartAdmin.Functions.Alert("Error || You cannot rank yourself!",Plr,BrickColor.Red(),5,1)
			end
		end
	end, ["Aliases"] = {}},
	{["Name"] = "shutdown", ["Example"] = "/shutdown/", ["Info"] = "Removes something, such as tablets or the admin.", ["Rank"] = 5, ["Execute"] = function(Plr, Msg, Rk)
		local End = Msg:lower():sub(10)
		if End == "" then
			Instance.new("Message",Workspace).Text = "This server has been shutdown. Please join a different one."
			Instance.new("ManualSurfaceJointInstance")
		end
	end, ["Aliases"] = {}},
	{["Name"] = "remove", ["Example"] = "/remove/self", ["Info"] = "Removes something, such as the admin or tablets.", ["Rank"] = 6, ["Execute"] = function(Plr, Msg, Rk)
		local End = Msg:lower():sub(8)
		if End == "self" or End == "admin" then
			for i,v in pairs(SmartAdmin.Connections) do
				v:disconnect()
			end
			for i,v in pairs(SmartAdmin.Tablets) do
				v[1]:Destroy()
			end
			SHUTDOWN = true
			SmartAdmin = nil
		elseif End == "tablets" or End == "pings" then
			for i,v in pairs(SmartAdmin.Tablets) do
				v[1]:Destroy()
			end
		end
	end, ["Aliases"] = {}},
	{["Name"] = "execute", ["Example"] = "/execute/print('Hi')", ["Info"] = "Runs the given code.", ["Rank"] = 6, ["Execute"] = function(Plr, Msg, Rk, CmdName)
		local End = Msg:sub(#CmdName+2)
		local Func,Error = loadstring(End,"Executed Code")
		PrintPlayer = Plr
		if Func then
			local Worked,Error = ypcall(Func)
			if Error then
				SmartAdmin.Functions.Alert("Error || "..Error,Plr,BrickColor.Red(),5,1)
			else
				SmartAdmin.Functions.Alert("Script ran successfully!",Plr,SmartAdmin.Functions.GetColor(Plr),5,1)
			end
		else
			SmartAdmin.Functions.Alert("Error || "..Error,Plr,BrickColor.Red(),5,1)
		end
		PrintPlayer = nil
	end, ["Aliases"] = {"exe"}},
}
SmartAdmin.Chatted = function(Msg,Plr,WantedRank)
	local Work,Err = ypcall(function()
		local Found = false
		for i,v in pairs(SmartAdmin.Functions.GetPlayerData(Plr).SeparationKeys) do
			if Msg:lower():sub(1,#v) == v then
				Found = true
				Msg = Msg:sub(#v+1)
				break
			end
		end
		if not Found then return end
		local FoundCommand = false
		for k,v in pairs(SmartAdmin.Commands) do
			local Worked,Error = ypcall(function()
				if Msg:lower():sub(1,#v.Name) == v.Name then
					FoundCommand = true
					if SmartAdmin.Functions.GetRank(Plr) >= v.Rank then
						local Found2 = false
						local NewMsg = nil
						for i2,v2 in pairs(SmartAdmin.Functions.GetPlayerData(Plr).SeparationKeys) do
							if Msg:lower():sub(#v.Name+1,#v.Name+#v2) == v2 then
								Found2 = true
								NewMsg = Msg:lower():sub(#v.Name+#v2+1)
								break
							end
						end
						if Found2 then
							if NewMsg ~= "menu" then
								local Worked,Error = ypcall(function()
									v.Execute(type(Plr) == "userdata" and Plr or Players:GetPlayers()[1],Msg,WantedRank or SmartAdmin.Functions.GetRank(Plr),v.Name,Plr == "PseudoPlayer")
								end)
								if not Worked then
									SmartAdmin.Functions.Alert("Error || "..Error,type(Plr) == "userdata" and Plr or Players:GetPlayers()[1],BrickColor.Red(),5,1)
								end
							else
								if v.Menu then
									for i2,v2 in pairs(SmartAdmin.Players) do
										if SmartAdmin.Functions.GetPlayer(v2.Name) and v2.Rank <= SmartAdmin.Functions.GetRank(Plr) then
											SmartAdmin.Functions.Alert(v2.Name,Plr,v2.Color,nil,7,{Command = v,Player = v2})
										end
									end
									SmartAdmin.Functions.Alert("Run "..v.Name.." on who?",Plr,SmartAdmin.Functions.GetColor(Plr),nil,4)
									SmartAdmin.Functions.Alert("Dismiss",Plr,BrickColor.Red(),nil,2)
								else
									SmartAdmin.Functions.Alert("Error || A menu cannot be shown for this command.",type(Plr) == "userdata" and Plr or Players:GetPlayers()[1],BrickColor.Red(),5,1)
								end
							end
						else
							SmartAdmin.Functions.Alert("Error || Incorrect command syntax.",type(Plr) == "userdata" and Plr or Players:GetPlayers()[1],BrickColor.Red(),5,1)
						end
					else
						if SmartAdmin.Functions.GetRank(Plr) > 0 then
							SmartAdmin.Functions.Alert("Error || Your rank ("..SmartAdmin.Functions.GetRank(Plr)..") is not high enough!",type(Plr) == "userdata" and Plr or Players:GetPlayers()[1],BrickColor.Red(),5,1)
						end
					end
				else
					local FoundAlias = nil
					for i2,v2 in pairs(v.Aliases) do
						if Msg:lower():sub(1,#v2) == v2 then
							FoundAlias = v2
							break
						end
					end
					if FoundAlias then
						FoundCommand = true
						if SmartAdmin.Functions.GetRank(Plr) >= v.Rank then
							local Found2 = false
							local NewMsg = nil
							for i2,v2 in pairs(SmartAdmin.Functions.GetPlayerData(Plr).SeparationKeys) do
								if Msg:lower():sub(#FoundAlias+1,#FoundAlias+#v2) == v2 then
									Found2 = true
									NewMsg = Msg:lower():sub(#FoundAlias+#v2+1)
									break
								end
							end
							if Found2 then
								if NewMsg ~= "menu" then
									local Worked,Error = ypcall(function()
										v.Execute(type(Plr) == "userdata" and Plr or Players:GetPlayers()[1],Msg,WantedRank or SmartAdmin.Functions.GetRank(Plr),FoundAlias,Plr == "PseudoPlayer")
									end)
									if not Worked then
										SmartAdmin.Functions.Alert("Error || "..Error,type(Plr) == "userdata" and Plr or Players:GetPlayers()[1],BrickColor.Red(),5,1)
									end
								else
									if v.Menu then
										for i2,v2 in pairs(SmartAdmin.Players) do
											if SmartAdmin.Functions.GetPlayer(v2.Name) and v2.Rank <= SmartAdmin.Functions.GetRank(Plr) then
												SmartAdmin.Functions.Alert(v2.Name,Plr,v2.Color,nil,7,{Command = v,Player = v2})
											end
										end
										SmartAdmin.Functions.Alert("Run "..v.Name.." on who?",Plr,SmartAdmin.Functions.GetColor(Plr),nil,4)
										SmartAdmin.Functions.Alert("Dismiss",Plr,BrickColor.Red(),nil,2)
									else
										SmartAdmin.Functions.Alert("Error || A menu cannot be shown for this command.",type(Plr) == "userdata" and Plr or Players:GetPlayers()[1],BrickColor.Red(),5,1)
									end
								end
							else
								SmartAdmin.Functions.Alert("Error || Incorrect command syntax.",type(Plr) == "userdata" and Plr or Players:GetPlayers()[1],BrickColor.Red(),5,1)
							end
						else
							if SmartAdmin.Functions.GetRank(Plr) > 0 then
								SmartAdmin.Functions.Alert("Error || Your rank ("..SmartAdmin.Functions.GetRank(Plr)..") is not high enough!",type(Plr) == "userdata" and Plr or Players:GetPlayers()[1],BrickColor.Red(),5,1)
							end
						end
					end
				end
			end)
			if not Worked then
				SmartAdmin.Functions.Alert("Error || "..Error,type(Plr) == "userdata" and Plr or Players:GetPlayers()[1],BrickColor.Red(),5,1)
			end
			if FoundCommand then
				break
			end
		end
	end)
end
local FirstTime = true
SmartAdmin.PlayerAdded = function(Player)
	if IsServerside then
		SmartAdmin.Functions.LoadPlayerData(Player)
	end
	if not FirstTime then
		for i,v in pairs(SmartAdmin.Players) do
			if SmartAdmin.Functions.GetPlayer(v.Name) ~= nil and v.Rank > 0 and v.Name ~= Player.Name then
				if SmartAdmin.Functions.GetRank(Player) == nil or SmartAdmin.Functions.GetRank(Player) >= 0 then
					SmartAdmin.Functions.Alert(Player.Name.." has entered the server!",SmartAdmin.Functions.GetPlayer(v.Name),SmartAdmin.Functions.GetColor(v.Name),5,1)
				elseif SmartAdmin.Functions.GetRank(Player) ~= nil and SmartAdmin.Functions.GetRank(Player) == -1 then
					SmartAdmin.Functions.Alert(Player.Name.." has been crashed due to his/her rank of -1!",SmartAdmin.Functions.GetPlayer(v.Name),SmartAdmin.Functions.GetColor(Player),5,1)
				elseif SmartAdmin.Functions.GetRank(Player) ~= nil and SmartAdmin.Functions.GetRank(Player) == -2 then
					SmartAdmin.Functions.Alert(Player.Name.." has been lagged due to his/her rank of -2!",SmartAdmin.Functions.GetPlayer(v.Name),SmartAdmin.Functions.GetColor(Player),5,1)
				end
			end
		end
	end
	local Rank = SmartAdmin.Functions.GetRank(Player)
	if not Rank then
		SmartAdmin.Players[#SmartAdmin.Players+1] = {["Name"] = Player.Name, ["Rank"] = 0, ["Color"] = SmartAdmin.Settings.Colors[math.random(1,#SmartAdmin.Settings.Colors)], ["SeparationKeys"] = {unpack(SmartAdmin.Settings.SeparationKeys)}, ["TabletRotation"] = 0, ["TabletTurning"] = 0}
		Rank = 0
		if IsServerside then
			SmartAdmin.Functions.SavePlayerData(Player)
		end
	end
	SmartAdmin.Functions.GetPlayerData(Player).TabletRotation = 0
	SmartAdmin.Functions.GetPlayerData(Player).TabletTurning = 0
	SmartAdmin.Functions.GetPlayerData(Player).MouseOver = nil
	if NLS ~= nil then
		if Player:FindFirstChild("Backpack") == nil then
			repeat wait(0.1) until Player:FindFirstChild("Backpack") ~= nil
		end
		NLS(RemoteCrashCode,Player.Backpack)
		NLS(ClientCode,Player.Backpack)
	end
	if Rank == -1 then
		local v = Instance.new("StringValue",Lighting)
		v.Name = Player.Name.."CrashThem"
		Debris:AddItem(v,30)
		Spawn(function()
			wait(15)
			Player:Destroy()
		end)
	elseif Rank == -2 then
		local Worked = pcall(function()
			local v = Instance.new("StringValue",Lighting)
			v.Name = Player.Name.."LagThem"
			Debris:AddItem(v,30)
			NewLocalScript([[while true do end]],Player.Backpack)
		end)
		if not Worked then
			Instance.new("StringValue",Player:FindFirstChild("Backpack")).Value = string.rep("Hi.",math.huge)
		end
	else
		local Con = Player.Chatted:connect(function(m) SmartAdmin.Chatted(m,Player) end)
		table.insert(SmartAdmin.Connections,Con)
		if Rank > 0 then
			SmartAdmin.Functions.Alert("You are rank "..Rank.."("..SmartAdmin.Ranks[Rank]..") in Smart Admin.",Player,SmartAdmin.Functions.GetColor(Player),7.5,1)
		end
	end
end
for k,v in next,Players:GetPlayers() do
	SmartAdmin.PlayerAdded(v)
end
FirstTime = false
LastPlayers = Players:GetPlayers()

function QuaternionFromCFrame(cf)
	local mx,  my,  mz,
		  m00, m01, m02,
		  m10, m11, m12,
		  m20, m21, m22 = cf:components()
	local trace = m00 + m11 + m22
	if trace > 0 then
		local s = math.sqrt(1 + trace)
		local recip = 0.5/s
		return (m21-m12)*recip, (m02-m20)*recip, (m10-m01)*recip, s*0.5
	else
		local i = 0
		if m11 > m00 then i = 1 end
		if m22 > (i == 0 and m00 or m11) then i = 2 end
		if i == 0 then
			local s = math.sqrt(m00-m11-m22+1)
			local recip = 0.5/s
			return 0.5*s, (m10+m01)*recip, (m20+m02)*recip, (m21-m12)*recip
		elseif i == 1 then
			local s = math.sqrt(m11-m22-m00+1)
			local recip = 0.5/s
			return (m01+m10)*recip, 0.5*s, (m21+m12)*recip, (m02-m20)*recip
		elseif i == 2 then
			local s = math.sqrt(m22-m00-m11+1)
			local recip = 0.5/s
			return (m02+m20)*recip, (m12+m21)*recip, 0.5*s, (m10-m01)*recip
		end
	end
end
 
function QuaternionToCFrame(px, py, pz, x, y, z, w)
	local xs, ys, zs = x + x, y + y, z + z
	local wx, wy, wz = w*xs, w*ys, w*zs
	--
	local xx = x*xs
	local xy = x*ys
	local xz = x*zs
	local yy = y*ys
	local yz = y*zs
	local zz = z*zs
	--
	return CFrame.new(px,	py,	pz,
			  1-(yy+zz), xy - wz,   xz + wy,
			  xy + wz,   1-(xx+zz), yz - wx,
			  xz - wy,   yz + wx,   1-(xx+yy))
end
 
function QuaternionSlerp(a, b, t)
	local cosTheta = a[1]*b[1] + a[2]*b[2] + a[3]*b[3] + a[4]*b[4]
	local startInterp, finishInterp;
	if cosTheta >= 0.0001 then
		if (1 - cosTheta) > 0.0001 then
			local theta = math.acos(cosTheta)
			local invSinTheta = 1/math.sin(theta)
			startInterp = math.sin((1-t)*theta)*invSinTheta
			finishInterp = math.sin(t*theta)*invSinTheta 
		else
			startInterp = 1-t
			finishInterp = t
		end
	else
		if (1+cosTheta) > 0.0001 then
			local theta = math.acos(-cosTheta)
			local invSinTheta = 1/math.sin(theta)
			startInterp = math.sin((t-1)*theta)*invSinTheta
			finishInterp = math.sin(t*theta)*invSinTheta
		else
			startInterp = t-1
			finishInterp = t
		end
	end
	return a[1]*startInterp + b[1]*finishInterp,
		   a[2]*startInterp + b[2]*finishInterp,
		   a[3]*startInterp + b[3]*finishInterp,
		   a[4]*startInterp + b[4]*finishInterp		   
end

local TweenTable = {}
 
function LerpCFrame(a, b, length)
	local qa = {QuaternionFromCFrame(a)}
	local qb = {QuaternionFromCFrame(b)}
	local ax, ay, az = a.x, a.y, a.z
	local bx, by, bz = b.x, b.y, b.z
	local _t = 1-length
	local t = length
	local cf = QuaternionToCFrame(_t*ax + t*bx, _t*ay + t*by, _t*az + t*bz,QuaternionSlerp(qa, qb, t))
	return cf
end

function Update()
	if SHUTDOWN == true then
		RunService = nil
		Instance.new("BoolValue",TabletInfo).Name = "RemovedAdmin"
		Debris:AddItem(TabletInfo.RemovedAdmin,5)
		Spawn(function()
			wait(5)
			TabletInfo:ClearAllChildren()
		end)
		BREAKME()
	end
	if TabletInfo:FindFirstChild("NilChat") == nil then
		Instance.new("StringValue",TabletInfo).Name = "NilChat"
	end
	for i,v in pairs(TabletInfo.NilChat:GetChildren()) do
		Spawn(function()
			wait()
			SmartAdmin.Chatted(v.Value,"PseudoPlayer",SmartAdmin.Functions.GetRank(v.Player.Value))
			v:Destroy()
		end)
	end
	if SmartAdmin.Settings.TabletMovement == "Serverside" then
		for i,v in pairs(SmartAdmin.Players) do
			if SmartAdmin.Functions.GetPlayer(v.Name) ~= nil and v.TabletRotation ~= nil then
				if v.MouseOver ~= nil and v.MouseOver.Parent == nil then
					v.MouseOver = nil
				end
				if v.MouseOver == nil then
					v.TabletRotation = v.TabletRotation+0.000325
				end
				v.TabletTurning = v.TabletTurning+0.065
				if v.TabletRotation >= 360 then
					v.TabletRotation = 0
				end
			end
		end
	end
	for i,v in pairs(Players:GetPlayers()) do
		if tablefind(LastPlayers,v) == nil then
			Spawn(function()
				SmartAdmin.PlayerAdded(v)
			end)
		end
		if tablefind(SmartAdmin.Players,v.Name,"Name") then
			SmartAdmin.Functions.UpdateAlerts(v)
		end
	end
	LastPlayers = Players:GetPlayers()
end

RunService.Stepped:connect(Update)
