if not IsAddOnLoaded("FreeUI") and not IsAddOnLoaded("Aurora") then return end

local F, C = unpack(Aurora or FreeUI)

local mog = MogIt
local frame = mog.frame
local filt = mog.filt

local function styleMenuButton(menuButton)
	menuButton.nt:SetAlpha(0)
	menuButton:SetHighlightFontObject(GameFontHighlight)
end

for i = 5, 9 do
	styleMenuButton(select(i, frame:GetChildren()))
end

do
	local scroll = filt.scroll.ScrollBar
	scroll.top:Hide()
	scroll.middle:Hide()
	scroll.bottom:Hide()
end

filt:SetPoint("TOPLEFT", mog.frame, "TOPRIGHT", 1, 0)

hooksecurefunc(mog, "FilterUpdate", function()
	if mog.active and mog.active.filters then
		for k, v in ipairs(mog.active.filters) do
			if mog.filters[v] then
				mog.filters[v].bg:Hide()
			end
		end
	end
end)

hooksecurefunc(mog, "CreatePreview", function()
	local f = mog.previews[#mog.previews]
	if not f.styled then
		f.model.bg:SetTexture("")

		for _, slot in pairs(f.slots) do
			slot:SetNormalTexture("")
			slot:SetPushedTexture("")
			slot.icon:SetTexCoord(.08, .92, .08, .92)

			slot.bg = F.CreateBG(slot)
		end

		local num = f:GetNumChildren()
		for i = num, num-3, -1 do
			styleMenuButton(select(i, f:GetChildren()))
		end

		F.ReskinPortraitFrame(f, true)
		F.Reskin(f.activate)

		f.styled = true
	end
end)

F.ReskinPortraitFrame(frame, true)
F.ReskinPortraitFrame(filt, true)
select(filt:GetNumChildren(), MogItFilters:GetChildren()):Hide()
F.Reskin(filt.defaults)
F.ReskinScroll(mog.scroll)
F.ReskinScroll(filt.scroll.ScrollBar)
F.ReskinInput(mog.filters["name"].edit)
F.ReskinInput(mog.filters["itemLevel"].min)
F.ReskinInput(mog.filters["itemLevel"].max)
F.ReskinInput(mog.filters["level"].min)
F.ReskinInput(mog.filters["level"].max)
F.ReskinDropDown(mog.filters["bind"].dd)
F.ReskinDropDown(mog.filters["class"].dd)
F.ReskinDropDown(mog.filters["slot"].dd)
F.ReskinDropDown(mog.filters["source"].dd)
F.ReskinDropDown(mog.filters["quality"].dd)
F.ReskinCheck(mog.filters["faction"].Alliance)
F.ReskinCheck(mog.filters["faction"].Horde)
F.ReskinCheck(mog.filters["hasItem"].hasItem)