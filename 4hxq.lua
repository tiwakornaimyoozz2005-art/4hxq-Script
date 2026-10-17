return function(env)
local C = env.C
local _cs = env._cs
local _isMobile = env._isMobile
local _nvFloatCloseRest = env._nvFloatCloseRest
local _nvL = env._nvL
local createInstance = env.createInstance
local makeFloatingPanel = env.makeFloatingPanel
local makePanelTitleBar = env.makePanelTitleBar
local tween = env.tween
local VCB_W = _isMobile and 280 or 260
local VCB_H = 170
_cs.vcbPanel = makeFloatingPanel(VCB_W, VCB_H, 0.5, 0)
_cs.vcbPanel.Name = "VCBypassPanel"
_G._vcbPanel = _cs.vcbPanel


local vcbBar = makePanelTitleBar(_cs.vcbPanel, "VC BYPASSER", function() _cs.vcbPanel.Visible = false end)
_cs.makePanelDraggable(_cs.vcbPanel, vcbBar)

local vcbContent = createInstance("Frame", {
  Parent = _cs.vcbPanel,
  Name = "Content",
  BackgroundTransparency = 1,
  BorderSizePixel = 0,
  Position = UDim2.new(0, 0, 0, 34),
  Size = UDim2.new(1, 0, 1, -34),
  ZIndex = 151,
})

local VCB_BTN_H = 36
local VCB_MIC_W = VCB_BTN_H
local VCB_PAD = 18
local VCB_SEG_H = 32
local VCB_SEG_Y = 14
local VCB_BTN_Y = VCB_SEG_Y + VCB_SEG_H + 10
local VCB_NOTE_Y = VCB_BTN_Y + VCB_BTN_H + 12
local vcbVersion = 1

local vcbSeg = createInstance("Frame", {
  Parent = vcbContent,
  Name = "Versions",
  Position = UDim2.new(0, VCB_PAD, 0, VCB_SEG_Y),
  Size = UDim2.new(1, -VCB_PAD * 2, 0, VCB_SEG_H),
  BackgroundColor3 = _cs.nvPop.TINT.gray[1],
  BorderSizePixel = 0,
  ZIndex = 152,
})
_cs.nvPop.round(vcbSeg)
createInstance("UIStroke", {
  Parent = vcbSeg,
  ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
  Color = Color3.new(1, 1, 1),
  Transparency = 0.9,
  Thickness = 1,
})
local vcbSegThumb = createInstance("Frame", {
  Parent = vcbSeg,
  Name = "Thumb",
  Position = UDim2.new(0, 3, 0, 3),
  Size = UDim2.new(0.5, -4, 1, -6),
  BackgroundColor3 = _cs.nvPop.WHITE,
  BorderSizePixel = 0,
  ZIndex = 153,
})
_cs.nvPop.round(vcbSegThumb)
local vcbSegBtns = {}
for i, label in { "Bypass V1", "Bypass V2" } do
	vcbSegBtns[i] = createInstance("TextButton", {
	  Parent = vcbSeg,
	  Name = "V" .. i,
	  Position = UDim2.new((i - 1) * 0.5, 0, 0, 0),
	  Size = UDim2.new(0.5, 0, 1, 0),
	  BackgroundTransparency = 1,
	  AutoButtonColor = false,
	  Font = Enum.Font.GothamBold,
	  TextSize = 12,
	  Text = label,
	  TextColor3 = i == 1 and _cs.nvPop.INK or C.TEXT,
	  ZIndex = 154,
	})
end

local vcbExecBtn = createInstance("TextButton", {
  Parent = vcbContent,
  Font = Enum.Font.GothamBold,
  TextSize = 13,
  TextColor3 = C.TEXT,
  Text = "Execute Bypass",
  ZIndex = 152,
})
_cs.nvPop.cta(vcbExecBtn, VCB_PAD, VCB_BTN_Y, VCB_W - VCB_PAD * 2 - VCB_MIC_W - 8, VCB_BTN_H, function(text)
	local t = tostring(text):lower()
	if t == "bypassed" then return _cs.nvPop.TINT.teal end
	if t:find("bypassing", 1, true) then return _cs.nvPop.TINT.gray end
return end)
vcbExecBtn.Size = UDim2.new(1, -(VCB_PAD * 2 + VCB_MIC_W + 8), 0, VCB_BTN_H)

local VCB_NOTES = { "Not supported on Xeno or Solara", "Second VCB" }
local vcbNote = _cs.nvPop.text(vcbContent, VCB_NOTES[1], Enum.Font.GothamMedium, 11, _cs.nvPop.SUBTLE, VCB_PAD, VCB_NOTE_Y, VCB_W - VCB_PAD * 2, 14)
vcbNote.Size = UDim2.new(1, -VCB_PAD * 2, 0, 14)

local vcbMicBtn = createInstance("TextButton", {
  Parent = _cs.vcbPanel,
  Size = UDim2.new(0, VCB_MIC_W, 0, VCB_BTN_H),
  Position = UDim2.new(1, -(VCB_PAD + VCB_MIC_W), 0, 34 + VCB_BTN_Y),
  BackgroundTransparency = 1,
  Text = "",
  AutoButtonColor = false,
  BorderSizePixel = 0,
  ZIndex = 152,
})
createInstance("UICorner", { Parent = vcbMicBtn, CornerRadius = UDim.new(1, 0) })
local vcbMicFace = createInstance("Frame", {
  Parent = vcbMicBtn,
  Name = "Face",
  Size = UDim2.fromScale(1, 1),
  BorderSizePixel = 0,
  BackgroundColor3 = _cs.nvPop.TINT.gray[1],
  ZIndex = 152,
})
createInstance("UICorner", { Parent = vcbMicFace, CornerRadius = UDim.new(1, 0) })
do
	local rim = createInstance("UIStroke", {
		Parent = vcbMicFace,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = Color3.new(1, 1, 1),
		Transparency = 0.9,
		Thickness = 1,
	})
end
local vcbMicIcon = createInstance("ImageLabel", {
  Parent = vcbMicBtn,
  Size = UDim2.new(0, 18, 0, 18),
  AnchorPoint = Vector2.new(0.5, 0.5),
  Position = UDim2.new(0.5, 0, 0.5, 0),
  BackgroundTransparency = 1,
  Icon = "mic",
  ImageColor3 = Color3.new(1, 1, 1),
  ScaleType = Enum.ScaleType.Fit,
  ZIndex = 153,
})
vcbMicIcon:GetAttributeChangedSignal("NvIcon"):Connect(function()
	local muted = vcbMicIcon:GetAttribute("NvIcon") == "micoff"
	local tint = muted and _cs.nvPop.TINT.red or _cs.nvPop.TINT.gray
	tween(vcbMicFace, _cs.nvPop.QUICK, {BackgroundColor3 = tint[1]})
	vcbMicIcon.ImageColor3 = muted and tint[2] or Color3.new(1, 1, 1)
end)
_cs.nvPop.lift(vcbMicBtn)
_cs.nvPop.press(vcbMicBtn)

local function placeVcbTop()
	local pnl = _cs.vcbPanel
	if not pnl then return end
	local cam = workspace.CurrentCamera
	local vp = cam and cam.ViewportSize
	local vpX = tonumber(vp and vp.X) or 1280
	local vpY = tonumber(vp and vp.Y) or 720
	local vcbW = tonumber(VCB_W) or 220
	local vcbH = tonumber(VCB_H) or 90

	local topInset = 36
	pcall(function()
		local tl = game:GetService("GuiService"):GetGuiInset()
		if typeof(tl) == "Vector2" then
			topInset = math.max(tonumber(tl.Y) or 36, 36)
		end
	end)
	topInset = tonumber(topInset) or 36

	local sideMargin = _isMobile and 12 or 16
	local topGap = _isMobile and 8 or 10
	local maxW = math.max(180, vpX - sideMargin * 2)
	local fitW = math.clamp(vcbW, 180, math.min(300, maxW))
	if vpX < 420 then
		fitW = math.clamp(vpX - sideMargin * 2, 180, 280)
	end
	fitW = tonumber(fitW) or vcbW
	pnl.Size = UDim2.new(0, fitW, 0, vcbH)

	local sc = 1
	local us = pnl:FindFirstChildOfClass("UIScale")
	if us then
		local globalSc = tonumber(_G._getScale and _G._getScale()) or 1
		if globalSc <= 0 then globalSc = 1 end
		local maxFit = math.min((vpX - sideMargin * 2) / fitW, (vpY - topInset - topGap - 16) / vcbH)
		sc = math.clamp(math.min(globalSc, tonumber(maxFit) or 1), 0.45, 1.15)
		us.Scale = sc
	end

	local scaledW, scaledH = fitW * sc, vcbH * sc
	pnl.AnchorPoint = Vector2.new(0.5, 0)
	local px = vpX * 0.5
	local py = topInset + topGap
	px = math.clamp(px, scaledW * 0.5 + sideMargin, math.max(scaledW * 0.5 + sideMargin, vpX - scaledW * 0.5 - sideMargin))
	py = math.clamp(py, topGap, math.max(topGap, vpY - scaledH - sideMargin))
	pnl.Position = UDim2.new(0, px, 0, py)
	pcall(function()
		if _nvFloatCloseRest then _nvFloatCloseRest[pnl] = nil end
	end)
end

_G._nvPlaceVcbTop = placeVcbTop
_G._nvToggleVcbPanel = function(forceOpen)
	local pnl = _G._vcbPanel or _cs.vcbPanel
	if not pnl then return end
	if forceOpen == true then
		pnl.Visible = true
	elseif forceOpen == false then
		pnl.Visible = false
		return
	else
		pnl.Visible = not pnl.Visible
	end
	if pnl.Visible then
		task.defer(placeVcbTop)
		if _nvL.xnotify then
			_nvL.xnotify("VC Bypasser", "Unmute your mic, talk into it for 5 seconds, then click execute bypass")
		end
	end
end

placeVcbTop()
pcall(function()
	local cam = workspace.CurrentCamera
	if cam then
		cam:GetPropertyChangedSignal("ViewportSize"):Connect(function()
			if _cs.vcbPanel and _cs.vcbPanel.Visible then
				placeVcbTop()
			end
		end)
	end
end)

local vcbExecuted = false
local vcbMuted = false

local function vcbWaitMicUnmuted()
	local m = "rbxasset://textures/ui/VoiceChat/MicLight/Muted.png"
	local tba = game:GetService("CoreGui"):WaitForChild("TopBarApp", 5)
	tba = tba and tba:WaitForChild("TopBarApp", 5)
	local lf = tba and tba:WaitForChild("UnibarLeftFrame", 5)
	local um = lf and lf:WaitForChild("UnibarMenu", 5)
	local n2 = um and um:WaitForChild("2", 5)
	local n3 = n2 and n2:WaitForChild("3", 5)
	local tmi = n3 and n3:FindFirstChild("toggle_mic_mute", true)
	if not tmi then return end
	local function getIcon(b)
		return b:WaitForChild("IntegrationIconFrame", 5)
			:WaitForChild("IntegrationIcon", 5)["1"]
	end
	repeat task.wait(1) until getIcon(tmi).Image ~= m
end

local function vcbRunBypass()
	local v = cloneref(game:GetService("VoiceChatService"))
	local vi = cloneref(game:GetService("VoiceChatInternal"))
	local gc = clonefunction(getconnections)

	_nvL.notify("VCBypasser", "Unmute your mic to continue bypass...")
	pcall(vcbWaitMicUnmuted)

	v:leaveVoice()
	task.wait(3)
	local h = gc(vi.StateChanged)
	for y = 7, #h do
		h[y]:Disable()
	end
	task.wait(3)
	v:joinVoice()
	vi:PublishPause(vcbMuted)
end

local function vcbPublishMute()
	cloneref(game:GetService("VoiceChatInternal")):PublishPause(vcbMuted)
end

local function vcbEnsureMicHud()
	local _cg = cloneref(game:GetService("CoreGui"))
	if _cg:FindFirstChild("NV_MicToggleGUI") then return end
	local topOrder = 49
	pcall(function()
		local tba = _cg:FindFirstChild("TopBarApp")
		if tba and tba:IsA("ScreenGui") then topOrder = tba.DisplayOrder end
	end)
	local micSG = createInstance("ScreenGui", {
		Name = "NV_MicToggleGUI",
		ResetOnSpawn = false,
		DisplayOrder = topOrder + 1,
		Parent = _cg,
	})

	local micFrame = createInstance("Frame", {
		Name = "StatusFrame",
		Position = UDim2.new(0, 165, 0, -45),
		Size = UDim2.new(0, 40, 0, 40),
		Active = true,
		Parent = micSG,
		BorderSizePixel = 0,
	})
	_G._nv_glass(micFrame, 20, true)

	local micIcon = createInstance("ImageLabel", {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0, 20, 0, 20),
		Icon = "mic",
		ImageColor3 = Color3.new(1, 1, 1),
		ScaleType = Enum.ScaleType.Fit,
		Parent = micFrame,
	})

	local micBtn = createInstance("TextButton", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		Text = "",
		ZIndex = 2,
		Parent = micFrame,
	})

	micBtn.MouseButton1Click:Connect(function()
		vcbMuted = not vcbMuted
		_G._nv_setIcon(micIcon, vcbMuted and "micoff" or "mic")
		_G._nv_setIcon(vcbMicIcon, vcbMuted and "micoff" or "mic")
		local col = vcbMuted and Color3.fromRGB(40, 40, 50) or C.ACTION
		tween(vcbMicBtn, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundColor3 = col})
		tween(micIcon, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {ImageColor3 = vcbMuted and C.DANGER or Color3.new(1, 1, 1)})
		pcall(vcbPublishMute)
	end)
end

local function vcbSelect(i)
	vcbVersion = i
	tween(vcbSegThumb, _cs.nvPop.QUICK, {Position = i == 1 and UDim2.new(0, 3, 0, 3) or UDim2.new(0.5, 1, 0, 3)})
	for k, b in vcbSegBtns do
		tween(b, _cs.nvPop.QUICK, {TextColor3 = k == i and _cs.nvPop.INK or C.TEXT})
	end
	vcbNote.Text = VCB_NOTES[i]
end
for i, b in vcbSegBtns do
	b.MouseButton1Click:Connect(function()
		if vcbVersion == i then return end
		if _G._nvVcbMode then
			_nvL.notify("VC Bypasser", "A bypass is already on. Rejoin to switch versions", 3)
			return
		end
		vcbSelect(i)
	end)
end

local function vcbSetMicIcon(muted)
	_G._nv_setIcon(vcbMicIcon, muted and "micoff" or "mic")
	local col = muted and Color3.fromRGB(40, 40, 50) or C.ACTION
	tween(vcbMicBtn, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundColor3 = col})
end

local function vcbAlreadyOn(mode)
	if _G._nvVcbMode == mode then
		_nvL.notify("VC Bypasser", vcbExecuted and "Already bypassed" or "Already running", 3)
	else
		_nvL.notify("VC Bypasser", "Bypass " .. string.upper(_G._nvVcbMode) .. " is already on. Rejoin to use the other one", 4)
	end
end

_G._nvRunVcb2 = function()
	if _G._nvVcbMode then vcbAlreadyOn("v2") ; return end
	_G._nvVcbMode = "v2"
	vcbSelect(2)
	vcbExecBtn.Text = "BYPASSING..."
	task.spawn(function()
		local ok, err = pcall(function()
			local a = 14
			local b = 13
			local c = 35

			local d = cloneref or function(v) return v end
			local e = clonefunction or function(v) return v end

			local g = d(game:GetService("VoiceChatService"))
			local h = d(game:GetService("VoiceChatInternal"))
			local j = d(game:GetService("CoreGui"))

			local l = _nvL.lp:WaitForChild("PlayerGui")

			local m = getconnections and e(getconnections)
			local n = gethui and e(gethui)

			local o = "rbxasset://textures/ui/VoiceChat/MicLight/Muted.png"
			local p = "rbxasset://textures/ui/VoiceChat/MicLight/Talking0.png"

			local q = nil
			local r = nil
			local s = nil
			local t = nil

			local function u()
				for _, v in ipairs(j:GetDescendants()) do
					if v.Name == "toggle_mic_mute" then
						q = v
					elseif v.Name == "RedVoiceDot" and v:IsA("GuiObject") then
						t = v
					end
				end
				if q then
					r = q:FindFirstChild("IntegrationIconFrame", true)
					if r then
						s = r:FindFirstChild("IntegrationIcon", true)
					end
				end
			end

			u()

			if not q then
				task.spawn(function()
					g:joinVoice()
				end)
				task.wait(1.5)
				u()
			end

			if _nvL.xnotify then _nvL.xnotify("VC Bypasser", "Unmute to continue.") else _nvL.notify("VC Bypasser", "Unmute to continue.", 5) end

			local function v()
				if s and s:FindFirstChild("1") then
					return s["1"].Image
				end
				return nil
			end

			local w = false
			while not w do
				local x = v()
				if x and x ~= o and x ~= "" then
					p = x
					w = true
				end
				if not w then
					task.wait(0.5)
				end
			end
			task.wait(1)

			task.spawn(function()
				g:leaveVoice()
			end)
			task.wait(2)

			if m then
				task.spawn(function()
					local y = m(h.StateChanged)
					for z, aa in ipairs(y) do
						if z >= 7 and aa then
							aa:Disable()
						end
					end
				end)
			end

			task.wait(2)
			task.spawn(function()
				g:joinVoice()
			end)

			task.wait(1)
			u()

			if q then
				task.spawn(function()
					for _, ab in ipairs(q:GetDescendants()) do
						if ab:IsA("ImageLabel") or ab:IsA("ImageButton") then
							ab.ImageTransparency = 1
						elseif ab:IsA("TextLabel") or ab:IsA("TextButton") then
							ab.TextTransparency = 1
						end
					end
				end)
			end

			local ac = (n and n()) or j or l
			local ad = ac:FindFirstChild("CustomVoiceController")
			if ad then
				ad:Destroy()
			end

			local ae = Instance.new("ScreenGui")
			ae.Name = "CustomVoiceController"
			ae.ResetOnSpawn = false
			ae.IgnoreGuiInset = true
			ae.DisplayOrder = 999999
			ae.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
			ae.Parent = ac

			local af = Instance.new("TextButton")
			af.Name = "MicHitArea"
			af.Size = UDim2.new(0, c, 0, c)
			af.Position = UDim2.new(0, 150 + a, 0, 4 + b)
			af.BackgroundTransparency = 1
			af.Text = ""
			af.Active = true
			af.ZIndex = 10000
			af.Parent = ae

			local ag = Instance.new("ImageLabel")
			ag.Name = "MicIcon"
			ag.Size = UDim2.new(1, 0, 1, 0)
			ag.Position = UDim2.new(0, 0, 0, 0)
			ag.BackgroundTransparency = 1
			ag.Image = o
			ag.ScaleType = Enum.ScaleType.Fit
			ag.ZIndex = 10001
			ag.Parent = af

			local ah = false
			pcall(function()
				ah = h:IsPublishPaused()
			end)

			local function ai(aj)
				ag.Image = aj and o or p
				if t and t.Parent then
					t.Visible = not aj
				end
				task.spawn(function()
					h:PublishPause(aj)
				end)
			end

			af.MouseButton1Click:Connect(function()
				ah = not ah
				ai(ah)
				vcbMuted = ah
				vcbSetMicIcon(ah)
			end)
			_G._nvVcb2SetMuted = function(muted)
				ah = muted
				ai(muted)
			end

			ai(true)
			ah = true

			local function ak()
				if not s or not s.Parent then
					u()
				end

				if s and s.AbsolutePosition.X > 50 then
					return s.AbsolutePosition, s.AbsoluteSize
				elseif q and q.AbsolutePosition.X > 50 then
					return q.AbsolutePosition, q.AbsoluteSize
				end

				return nil, nil
			end

			local al = ak()
			if al and al.X > 0 and al.Y >= 0 then
				af.Position = UDim2.new(0, al.X + a, 0, al.Y + b)
				af.Size = UDim2.new(0, c, 0, c)
			end

			if t and t:IsA("GuiObject") then
				t.Visible = not ah
			end

			h.StateChanged:Connect(function()
				pcall(function()
					ah = h:IsPublishPaused()
				end)
				if t and t.Parent then
					t.Visible = not ah
				end
			end)
		end)
		if ok then
			vcbExecuted = true
			vcbMuted = true
			vcbSetMicIcon(true)
			vcbExecBtn.Text = "BYPASSED"
			_nvL.notify("VC Bypasser", "Bypass active. Use the mic button to mute and unmute.", 5)
		else
			_G._nvVcbMode = nil
			vcbExecBtn.Text = "Execute Bypass"
			_nvL.notify("VC Bypasser", "Bypass failed: " .. tostring(err), 5)
		end
	end)
end

vcbExecBtn.MouseButton1Click:Connect(function()
	if vcbVersion == 2 then _G._nvRunVcb2() ; return end
	if _G._nvVcbMode then vcbAlreadyOn("v1") ; return end
	_G._nvVcbMode = "v1"
	vcbExecBtn.Text = "BYPASSING..."
	task.spawn(function()
		pcall(vcbRunBypass)
		vcbExecuted = true
		vcbExecBtn.Text = "BYPASSED"
		_nvL.notify("VCBypasser", "Bypass executed")
		pcall(vcbEnsureMicHud)
	end)
end)

vcbMicBtn.MouseButton1Click:Connect(function()
	if not vcbExecuted then _nvL.notify("VCBypasser", "Execute bypass first"); return end
	vcbMuted = not vcbMuted
	vcbSetMicIcon(vcbMuted)
	if _G._nvVcbMode == "v2" then
		if _G._nvVcb2SetMuted then pcall(_G._nvVcb2SetMuted, vcbMuted) end
		return
	end
	pcall(function()
		local sg = cloneref(game:GetService("CoreGui")):FindFirstChild("NV_MicToggleGUI")
		if sg then
			local sf = sg:FindFirstChild("StatusFrame")
			if sf then
				local ico = sf:FindFirstChildOfClass("ImageLabel")
				if ico then
					ico.Image = vcbMicIcon.Image
					tween(ico, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {ImageColor3 = vcbMuted and C.DANGER or Color3.new(1, 1, 1)})
				end
			end
		end
	end)
	pcall(vcbPublishMute)
end)
end

