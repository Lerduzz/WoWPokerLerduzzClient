local L = WPL_Locale;

local UPDATEPERIOD, elapsed = 1, 0;
local WPL_CLIENT_VERSION = "v1.0.0";
local WPL_SERVER_VERSION = "v1.0.0";
local StuffLoaded = 0;
local WPL_DraggingIcon = 0;

local WPL_SetSize = 0;

local lasttime = 0;
local timedelta = 0;

local NextRefresh = 0;
local WhosTurn = 0;
local HighestBet = 0;

local BetSize = 20;
local Blinds = 20;
local RoundCount = 0;

local Cards = {
    {object="WPL_Card_C0"},
    {object="WPL_Card_C1"},
    {object="WPL_Card_C2"},
    {object="WPL_Card_C3"},
    {object="WPL_Card_C4"},
    {object="WPL_Card_C5"},
    {object="WPL_Card_C6"},
    {object="WPL_Card_C7"},
    {object="WPL_Card_C8"},
    {object="WPL_Card_C9"},
    {object="WPL_Card_C10"},
    {object="WPL_Card_C11"},
    {object="WPL_Card_C12"},

    {object="WPL_Card_D0"},
    {object="WPL_Card_D1"},
    {object="WPL_Card_D2"},
    {object="WPL_Card_D3"},
    {object="WPL_Card_D4"},
    {object="WPL_Card_D5"},
    {object="WPL_Card_D6"},
    {object="WPL_Card_D7"},
    {object="WPL_Card_D8"},
    {object="WPL_Card_D9"},
    {object="WPL_Card_D10"},
    {object="WPL_Card_D11"},
    {object="WPL_Card_D12"},

    {object="WPL_Card_H0"},
    {object="WPL_Card_H1"},
    {object="WPL_Card_H2"},
    {object="WPL_Card_H3"},
    {object="WPL_Card_H4"},
    {object="WPL_Card_H5"},
    {object="WPL_Card_H6"},
    {object="WPL_Card_H7"},
    {object="WPL_Card_H8"},
    {object="WPL_Card_H9"},
    {object="WPL_Card_H10"},
    {object="WPL_Card_H11"},
    {object="WPL_Card_H12"},

    {object="WPL_Card_S0"},
    {object="WPL_Card_S1"},
    {object="WPL_Card_S2"},
    {object="WPL_Card_S3"},
    {object="WPL_Card_S4"},
    {object="WPL_Card_S5"},
    {object="WPL_Card_S6"},
    {object="WPL_Card_S7"},
    {object="WPL_Card_S8"},
    {object="WPL_Card_S9"},
    {object="WPL_Card_S10"},
    {object="WPL_Card_S11"},
    {object="WPL_Card_S12"},
    
    {object="WPL_Blank_1"},
    {object="WPL_Blank_2"},
    {object="WPL_Blank_3"},
    {object="WPL_Blank_4"},
    {object="WPL_Blank_5"},
    {object="WPL_Blank_6"},
    {object="WPL_Blank_7"},
    {object="WPL_Blank_8"},
    {object="WPL_Blank_9"},
    {object="WPL_Blank_10"},
    {object="WPL_Blank_11"},
    {object="WPL_Blank_12"},
    {object="WPL_Blank_13"},
    {object="WPL_Blank_14"},
    {object="WPL_Blank_15"},
    {object="WPL_Blank_16"},
    {object="WPL_Blank_17"},
    {object="WPL_Blank_18"},
    {object="WPL_Blank_19"},
    {object="WPL_Blank_20"},
    {object="WPL_Blank_21"},
    {object="WPL_Blank_22"},
    {object="WPL_Blank_23"},
};


local Seats	= {
    {object="WPL_Seat_1", name="", chips=0, bet=0, status="", seated=0, hole1=0, hole2=0, blank1=0, blank2 = 0, dealt=0, alpha=1, x=235,  y=118},
    {object="WPL_Seat_2", name="", chips=0, bet=0, status="", seated=0, hole1=0, hole2=0, blank1=0, blank2 = 0, dealt=0, alpha=1, x=365,  y=40},
    {object="WPL_Seat_3", name="", chips=0, bet=0, status="", seated=0, hole1=0, hole2=0, blank1=0, blank2 = 0, dealt=0, alpha=1, x=365,  y=-81},
    {object="WPL_Seat_4", name="", chips=0, bet=0, status="", seated=0, hole1=0, hole2=0, blank1=0, blank2 = 0, dealt=0, alpha=1, x=235,  y=-124},
    {object="WPL_Seat_5", name="", chips=0, bet=0, status="", seated=0, hole1=0, hole2=0, blank1=0, blank2 = 0, dealt=0, alpha=1, x=15,   y=-124},
    {object="WPL_Seat_6", name="", chips=0, bet=0, status="", seated=0, hole1=0, hole2=0, blank1=0, blank2 = 0, dealt=0, alpha=1, x=-205, y=-124},
    {object="WPL_Seat_7", name="", chips=0, bet=0, status="", seated=0, hole1=0, hole2=0, blank1=0, blank2 = 0, dealt=0, alpha=1, x=-335, y=-81},
    {object="WPL_Seat_8", name="", chips=0, bet=0, status="", seated=0, hole1=0, hole2=0, blank1=0, blank2 = 0, dealt=0, alpha=1, x=-335, y=40},
    {object="WPL_Seat_9", name="", chips=0, bet=0, status="", seated=0, hole1=0, hole2=0, blank1=0, blank2 = 0, dealt=0, alpha=1, x=-205, y=118},
};

local Flop = {};
local FlopBlank = {};

local CardWidth = 90;

local DealerX = 0;
local DealerY = 250;

local DealerDelay = 0.5;
local CardSpeed = 3;
local CC = 0;
local BlinkOn = 1;


function WPL_OnLoad()
    local fU = CreateFrame("frame");
    fU:SetScript("OnUpdate", function(self, elap) if (StuffLoaded == 1) then WPL_MapIconUpdate(); end; end);
    WPL_SetupFrames();
    WPL_RegisterEvents();
    WPL_ConsoleFeedback(L['WoW Poker Lerduzz'] .." ("..WPL_CLIENT_VERSION..").");
    for key, object in pairs(Cards) do 
        Cards[key].Artwork = _G[Cards[key].object];
        Cards[key].fraction = 0;
        Cards[key].fadeout = 0;
        Cards[key].fadetime = 0;
        Cards[key].x = 0;
        Cards[key].y = 0;
        Cards[key].startx = 0;
        Cards[key].starty = 0;
        Cards[key].visible = 0;
        Cards[key].high = 0;	
    end;
    WPL_ClearTable();
    StuffLoaded = 1;
end;


function WPL_SizeClick()
    PlaySound("ACTIONBARBUTTONDOWN", "SFX");
    WPL_SetSize = WPL_SetSize + 1;
    if (WPL_SetSize > 2) then WPL_SetSize = 0; end;
    if (WPL_SetSize == 0) then
        WPL_PokerFrame:SetScale(1);
    elseif (WPL_SetSize == 1) then
        WPL_PokerFrame:SetScale(0.75);
    elseif (WPL_SetSize == 2) then
        WPL_PokerFrame:SetScale(0.5);            
    end;
    WPL_PokerFrame:ClearAllPoints();
    WPL_PokerFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
end;


function WPL_ClearCards()
    CC = 0;
    for key, object in pairs(Cards) do WPL_SetCard(key, DealerX, DealerY, 0, 0, 0, 0, 0, 0); end;
    Flop = {};
    FlopBlank = {};
    BlankCard = 53;
end;


function WPL_InitializeSeat(j)
    Seats[j].name = "";
    Seats[j].HavePort = 0;
    Seats[j].seated = 0;
    Seats[j].dealt = 0;
    Seats[j].status = "";
    Seats[j].bet = 0;
    Seats[j].hole1 = 0;
    Seats[j].hole2 = 0;
    Seats[j].blank1 = 0;
    Seats[j].blank2 = 0;
    Seats[j].alpha = 1;
end;


function WPL_ClearTable()
    for j=1,9 do
        WPL_InitializeSeat(j);
        WPL_UpdateSeat(j);
    end;
    WPL_ClearCards();
    WPL_SelectPlayerRing(0);
    WPL_TotalPot();
    WPL_HideAllButtons(true);
    WPL_AutoButtons:Hide();
end;


function WPL_RegisterEvents()
    WPL_PokerFrame:RegisterEvent("ADDON_LOADED");
    WPL_PokerFrame:RegisterEvent("CHAT_MSG_ADDON");
end;


function WPL_OnEvent(self, event, ...)
    if (event == "ADDON_LOADED") then
        arg1 = ...;
        if (arg1 == "WoWPokerLerduzz") then
            WPL_MapIconFrame:Show();
            WPL_SetupXMLButtons();
        end
    elseif (event == "CHAT_MSG_ADDON") then
        arg1, arg2, arg3, arg4 = ...;
        if (arg1 == "WoWPokerLerduzz") then WPL_HandleAddonComms(arg2, arg3, arg4); end;
    end;
end;


function WPL_OnUpdate(arg1)
    if (StuffLoaded == 1) then
        local time = GetTime();
        timedelta = time - lasttime;
        if (lasttime == 0) then timedelta = 0; end;
        lasttime = time;
        for key, object in pairs(Cards) do		
            if (Cards[key].fraction < 1) then
                Cards[key].fraction = Cards[key].fraction + (timedelta * CardSpeed);
            else
                if (Cards[key].fadeout > 0) then
                    Cards[key].fadetime = Cards[key].fadetime + (timedelta * 1000);
                end;
            end;
            if (Cards[key].fraction > 1) then Cards[key].fraction = 1; end;
            WPL_DrawCard(key);
        end;
        if (time > NextRefresh) then
            NextRefresh = time + 1;
            for j=1,9 do WPL_UpdateSeat(j); end;
            if (WhosTurn > 0) then WPL_BlinkWhosTurn(); end;
        end;
    end
end;


function WPL_MapIconUpdate()
    if (WPL_DraggingIcon == 1) then
        local xpos, ypos = GetCursorPosition();
        local xmin, ymin = Minimap:GetLeft(), Minimap:GetBottom();
        xpos = xmin - xpos / Minimap:GetEffectiveScale() + 70;
        ypos = ypos / Minimap:GetEffectiveScale() - ymin - 70;
        WPL_MapIconAngle = math.deg(math.atan2(ypos, xpos));
        WPL_IconPos(WPL_MapIconAngle);
    end;
    WPL_MapIcon:Show();
    WPL_MapIcon:SetAlpha(1);
    if ((5 == WhosTurn) and (Seats[5].seated == 1)) then
        var = (sin(GetTime() * 400 ) +1 ) / 2;
        WPL_MapIcon:SetAlpha(var);
    end;
end;


function WPL_LauncherClicked(button)
    if (Seats[5].seated == 0) then
        WPL_SendMessage("!init", UnitName("player"));
        return;
    end;
    WPL_PokerFrame:Show();
    PlaySound("GAMEDIALOGOPEN", "SFX");
end;


function WPL_IconPos(angle)
    local xpos = cos(angle) * 77;
    local ypos = sin(angle) * 77;
    WPL_MapIconFrame:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", 55 - xpos, -58 + ypos);
end;


function WPL_BlinkWhosTurn()
    if (BlinkOn == 0) then
        BlinkOn = 1;
        if (WhosTurn > 0) then
            _G["WPL_Seat_"..WhosTurn.."_RingSelect"]:Show();
            _G["WPL_Seat_"..WhosTurn.."_Ring"]:Hide();
        end;
    else
        BlinkOn = 0;
        if (WhosTurn > 0) then
            _G["WPL_Seat_"..WhosTurn.."_RingSelect"]:Hide();
            _G["WPL_Seat_"..WhosTurn.."_Ring"]:Show();
        end;
    end;
end;


function WPL_SetCard(index, dealerx, dealery, x, y, visible, fraction, fadeout, highlayer)
    Cards[index].x = x;
    Cards[index].y = y;
    Cards[index].startx = dealerx;
    Cards[index].starty = dealery;
    Cards[index].fraction = fraction;
    Cards[index].fadetime = 0;
    Cards[index].visible = visible;
    Cards[index].fadeout = fadeout;
    Cards[index].Artwork:SetAlpha(1);
    Cards[index].high = highlayer;
    WPL_DrawCard(index);
end;


function WPL_DrawCard(index)
    local dx;
    local dy;
    local card = Cards[index];
    local frac = card.fraction;
    local mfrac = 1 - frac;
    if (frac < 0) then
        card.Artwork:Hide();
        return;
    else
        dx = (card.startx * mfrac) + (card.x * frac);
        dy = (card.starty * mfrac) + (card.y * frac);
    end;
    if (card.visible == 1) then
        card.Artwork:SetPoint("CENTER", "WPL_PokerFrame", "CENTER", dx + 29, dy);
        if (card.high == 1) then card.Artwork:SetDrawLayer("OVERLAY"); end;
        card.Artwork:Show();
        if (card.fadeout > 0) and (card.fadetime > 0) then
            delta = card.fadeout - card.fadetime;
            if (delta < 0) then
                card.Artwork:Hide();
            else
                delta = (delta / card.fadeout);
                card.Artwork:SetAlpha(delta);
            end;
        end;
    else
        card.Artwork:SetDrawLayer("ARTWORK");
        card.Artwork:SetPoint("CENTER", "WPL_PokerFrame", "CENTER", 0, 0);
        card.Artwork:Hide();
    end;
end;


function WPL_UpdateSeat(j)
    local seat = "WPL_Seat_"..j;
    if (Seats[j].seated == 0) then
        _G[seat.."_Name"]:SetText("");
        _G[seat.."_Gold"]:SetText("0");
        _G[seat.."_Status"]:SetText("");
        _G[seat.."_Port"]:Hide();
        _G[seat.."_PortWho"]:Hide();
        _G[seat]:Hide();
    else
        _G[seat]:Show();
        _G[seat]:SetAlpha(Seats[j].alpha);
        _G[seat.."_Name"]:SetText(Seats[j].name);
        _G[seat.."_Gold"]:SetText(Seats[j].chips);
        local tempStatus = Seats[j].status;
        _G[seat.."_Status"]:SetText(L[Seats[j].status]);
        _G[seat.."_PortWho"]:Hide();
        local portraitObj = _G[seat.."_Port"];
        portraitObj:Show();
        if (UnitName("player") == Seats[j].name) then
            SetPortraitTexture(portraitObj, "player");
            Seats[j].HavePort = 1;
        elseif (UnitName("target") == Seats[j].name) then
            SetPortraitTexture(portraitObj,"target");
            Seats[j].HavePort = 1;
        else
            for n=1,5 do
                if (UnitName("party"..n) == Seats[j].name) then
                    SetPortraitTexture(portraitObj, "party"..n);
                    Seats[j].HavePort = 1;
                    break;
                end
            end;
            if (UnitInRaid("player") )then
                for n=1,40 do
                    if (UnitName("raid"..n) == Seats[j].name) then
                        SetPortraitTexture(portraitObj, "raid"..n);
                        Seats[j].HavePort = 1;
                        break;
                    end;
                end;
            end;
        end;
        if (Seats[j].HavePort == 0) then
            portraitObj:Hide();	
            _G[seat.."_PortWho"]:Show();
        end;
    end;
end;


function WPL_StopClient()
    WhosTurn = 0;
    WPL_ClearTable();
    WPL_PokerFrame:Hide();
    PlaySound("GAMEDIALOGCLOSE", "SFX");
end;


function WPL_QuitClick()
    WPL_SendMessage("quit", UnitName("player"));
    WPL_StopClient();
    WPL_HideAllButtons(true);
end;


function WPL_HideAllButtons(fold)
    if (fold) then WPL_Fold:Hide(); end;
    WPL_Call:Hide();
    WPL_Raise:Hide();
    WPL_RaiseSlider:Hide();
end;


function WPL_FoldClick()
    PlaySound("ACTIONBARBUTTONDOWN", "SFX");
    if (Seats[5].dealt == 1) then
        WPL_SendMessage("fold_5", UnitName("player"));
        Seats[5].dealt = 0;	
        WPL_ShowCard(5, "Folded");
        WPL_Fold:SetText(L['Show Cards']);
        WPL_Fold:Hide();
    else
        WPL_SendMessage("showcards", UnitName("player"));
        WPL_Fold:Hide();
    end;
    WPL_UpdateSeat(5);
    WPL_HideAllButtons(false);
end;


function WPL_RaiseClick()
    PlaySound("ACTIONBARBUTTONDOWN", "SFX");
    if (Seats[5].seated == 0) then return; end;
    local delta = HighestBet - Seats[5].bet;
    if (BetSize < delta + Blinds) then BetSize = delta + Blinds; end;
    if (BetSize >= Seats[5].chips) then BetSize = Seats[5].chips; end;
    WPL_SendMessage("call_"..BetSize, UnitName("player"));
end;


function WPL_CallClick()
    PlaySound("ACTIONBARBUTTONDOWN", "SFX");
    if (Seats[5].seated == 0) then return; end;
    delta = -1;
    if (Seats[5].bet < HighestBet) then
        delta = HighestBet - Seats[5].bet;
        if (delta > Seats[5].chips) then delta = -1; end;
    end;
    if (Seats[5].bet == HighestBet) then delta = 0; end;
    if (delta > -1) then WPL_SendMessage("call_"..delta, UnitName("player")); end;
end;

function WPL_RaiseSlider_OnValueChange()
    local minValue, maxValue = WPL_RaiseSlider:GetMinMaxValues();
    local value = WPL_RaiseSlider:GetValue();
    if (value == maxValue) then
        WPL_Raise:SetText(L["All In"]);
    else
        WPL_Raise:SetText(L["Raise"].." "..WPL_RaiseSlider:GetValue());
    end;
    BetSize = value;
end;


function WPL_RaiseSlider_Setup(min, max)
    WPL_RaiseSlider:SetMinMaxValues(min, max);
    WPL_RaiseSlider:SetValue(min, false);
    WPL_Raise:SetText(L['Raise'].." "..min);
end;


function WPL_StartClient()
    WPL_ClearTable();
    WPL_PokerFrame:Show();
    PlaySound("GAMEDIALOGOPEN", "SFX");
end;


function WPL_UpdateWhosTurn()
    if (Seats[5].seated == 0) then return; end;
    if (HighestBet < Blinds) then HighestBet = Blinds; end;
    if (Seats[5].dealt == 1) then
        WPL_Fold:SetText(L['Fold']);
        WPL_Fold:Show();
    end;
    WPL_SelectPlayerRing(WhosTurn);
    if (WhosTurn == 5) then
        PlaySound("RaidWarning", "SFX");
        WPL_Call:Show();
        WPL_RaiseSlider:Show();
        WPL_Raise:Show();
        WPL_Buttons:Show();
        WPL_AutoButtons:Hide();
        Call = 1;
        local delta = HighestBet - Seats[5].bet;
        WPL_Call:SetText(L["Call"].." "..delta);
        if (Seats[5].bet == HighestBet) then
            WPL_Call:SetText(L['Check']);
            delta = 0;
            Call = 0;
        end;
        BetSize = delta + Blinds;
        if (Seats[5].chips <= delta) then
            delta = -1;
            WPL_Call:Hide();
            WPL_RaiseSlider:Hide();
            WPL_Raise:SetText(L['All In']);
        else
            if (Seats[5].chips <= BetSize) then
                WPL_RaiseSlider:Hide();
                WPL_Raise:SetText(L['All In']);
            else
                WPL_RaiseSlider_Setup(BetSize, Seats[5].chips);
            end;
        end;
        if (WPL_AutoBetCheck:GetChecked()) then
            if (not WPL_AutoStickyCheck:GetChecked()) then
                WPL_AutoBetCheck:SetChecked(false);
            end;
            if (delta == -1) then
                WPL_RaiseClick();
            else
                WPL_CallClick();
            end;
        end;
        if (WPL_AutoCheckCheck:GetChecked() and Call == 0) then
            if (not WPL_AutoStickyCheck:GetChecked()) then
                WPL_AutoCheckCheck:SetChecked(false);
            end;
            WPL_CallClick();
        end;
        if (WPL_AutoFoldCheck:GetChecked()) then
            if (not WPL_AutoStickyCheck:GetChecked()) then
                WPL_AutoFoldCheck:SetChecked(false);
            end;
            if (Call == 1) then
                WPL_FoldClick();
            else
                WPL_CallClick();
            end;
        end;
    else
        WPL_HideAllButtons(false);
        WPL_Buttons:Hide();
        WPL_AutoButtons:Show();
    end;
    for j=1,9 do
        _G["WPL_Seat_"..j.."_Countdown"]:Hide();
    end;
    _G["WPL_Seat_"..WhosTurn.."_Countdown"]:Show();
    _G["WPL_Seat_"..WhosTurn.."_Countdown"]:SetText("?");
end;


function WPL_SelectPlayerRing(j)
    for r=1,9 do
        _G["WPL_Seat_"..r.."_RingSelect"]:Hide();
        _G["WPL_Seat_"..r.."_Ring"]:Show();
    end;
    if (j > 0) then
        _G["WPL_Seat_"..j.."_RingSelect"]:Show();
        _G["WPL_Seat_"..j.."_RingSelect"]:SetAlpha(1);
        _G["WPL_Seat_"..j.."_Ring"]:Hide();
    end;
end;


function WPL_SelectPlayerButton(j)
    for r=1,9 do _G["WPL_Seat_"..r.."_Button"]:Hide(); end;
    if (j > 0) then _G["WPL_Seat_"..j.."_Button"]:Show(); end;
end;


function WPL_HandleAddonComms(msg, channel, sender)
    local tab = {strsplit( "_", msg)};
    if (table.getn(tab) < 3) then return; end;
    if (tab[1] ~= "WPL" or tab[2] ~= WPL_SERVER_VERSION) then return; end;
    if (UnitName("player") ~= sender) then return; end;    
    if (tab[3] == "init!") then
        local gold = tonumber(tab[4]);
        if (gold < 500) then gold = 500; end;
        if (gold > 200000) then gold = 200000; end;
        if (not WPL_StartGold or WPL_StartGold < 500 or WPL_StartGold > gold) then WPL_StartGold = 500; end;
        WPL_JoinFrame_Slider:SetMinMaxValues(500, gold);
        WPL_JoinFrame_Slider:SetValue(WPL_StartGold);
        WPL_JoinFrame_Gold:SetText(WPL_StartGold);
        WPL_JoinFrame:Show();
        PlaySound("GAMEDIALOGOPEN", "SFX");
    elseif (tab[3] == "ping!") then
        WPL_SendMessage("join_"..WPL_StartGold, UnitName("player"));
    elseif (tab[3]=="noplayer!") then
        WPL_ErrorFrame_Text:SetText(L["Player not found!"]);
        WPL_ErrorFrame:Show();
        PlaySound("GAMEDIALOGOPEN", "SFX");
    elseif (tab[3]=="nogold!") then
        WPL_ErrorFrame_Text:SetText(L["Not enough gold!"]);
        WPL_ErrorFrame:Show();
        PlaySound("GAMEDIALOGOPEN", "SFX");
    elseif (tab[3]=="goldrange!") then
        WPL_ErrorFrame_Text:SetText(L["Gold out of range!"]);
        WPL_ErrorFrame:Show();
        PlaySound("GAMEDIALOGOPEN", "SFX");
    elseif (tab[3]=="tablegold!") then
        WPL_ErrorFrame_Text:SetText(L["Table is full of gold!"]);
        WPL_ErrorFrame:Show();
        PlaySound("GAMEDIALOGOPEN", "SFX");
    elseif (tab[3]=="noseats!") then
        WPL_ErrorFrame_Text:SetText(L["There are no seats available at this time!"]);
        WPL_ErrorFrame:Show();
        PlaySound("GAMEDIALOGOPEN", "SFX");
    elseif (tab[3]=="s") then
        WPL_ClientSit(tonumber(tab[4]), tab[5], tonumber(tab[6]), tonumber(tab[7]), tab[8]);
    elseif (tab[3]=="st") then
        WPL_ClientStatusUpdate(tonumber(tab[4]), tab[5], tab[6], tab[7], tab[8])
    elseif (tab[3]=="b") then
        WPL_SelectPlayerButton(tonumber(tab[4]))
    elseif (tab[3]=="round0") then
        WPL_ClientRound0(tonumber(tab[4]));
    elseif (tab[3]=="hole") then
        WPL_ClientHole(tonumber(tab[4]), tonumber(tab[5]), tab[6]);
    elseif (tab[3]=="deal") then
        WPL_ClientDeal( tonumber(tab[4]))
    elseif (tab[3]=="flop0") then
        WPL_ClientFlop0()
    elseif (tab[3]=="flop1") then
        WPL_ClientFlop1(tonumber(tab[4]), tonumber(tab[5]), tonumber(tab[6]))
    elseif (tab[3]=="turn") then
        Flop[4]=tonumber(tab[4]);
        WPL_SetCard(Flop[4], DealerX, DealerY, CardWidth * 1 + 3, 0, 1, 0, 0, 0);
    elseif (tab[3]=="river") then
        Flop[5]=tonumber(tab[4]);
        WPL_SetCard(Flop[5], DealerX, DealerY, CardWidth * 2 + 3, 0, 1, 0, 0, 0);
    elseif (tab[3]=="show") then
        WPL_ClientShow(tonumber(tab[4]), tonumber(tab[5]), tonumber(tab[6]), tab[7])
    elseif (tab[3]=="go") then
        local j = tonumber(tab[4]);
        HighestBet = tonumber(tab[5]);
        WhosTurn = j;
        WPL_UpdateWhosTurn();
    elseif (tab[3]=="betsize") then
        Blinds = tonumber(tab[4]);
        BetSize = Blinds;
    elseif (tab[3]=="seat") then
        WPL_StartClient();
    elseif (tab[3]=="q") then
        WPL_ReceiveQuit( sender, tonumber(tab[4]))
    elseif (tab[3]=="showdown") then
        WPL_ReceiveShowdown(tonumber(tab[4]), tab[5]);
    elseif (tab[3]=="hand") then
        Seats[5].status = tab[4];
        WPL_UpdateSeat(5);
    elseif (tab[3]=="countdown") then
        _G["WPL_Seat_"..WhosTurn.."_Countdown"]:SetText(tab[4]);
    end;
end


function WPL_ReceiveShowdown(j, status)
    Seats[5].dealt = 0;
    if (5 == j) then
        WPL_HideAllButtons(false);
        WPL_Buttons:Show();
        WPL_AutoButtons:Hide();
        WPL_Fold:SetText(L['Show Cards']);
        WPL_Fold:Show();
    else
        WPL_HideAllButtons(true);
        WPL_Buttons:Hide();
        WPL_AutoButtons:Show();
    end;
end;


function WPL_ReceiveQuit(sender, j)
    if (sender == UnitName("player")) then
        Seats[j].seated = 0;
        Seats[j].HavePort = 0;
        if (WPL_IsPlaying(sender) == 1) then
            WPL_UpdateSeat(j);
            WPL_ConsoleFeedback(Seats[j].name.." "..L['has left the table.']);
        end;
        if (j == 5) then WPL_StopClient(); end;
    end;
end;


function WPL_ClientSit(j, name, chips, bet, faction)
    Seats[j].seated = 1;
    Seats[j].name = name;
    Seats[j].chips = chips;
    Seats[j].bet = bet;
    if (faction == "A" or faction == "H") then
        local seat = "WPL_Seat_"..j;
        if (j == 1 or j == 9) then
            _G[seat.."_Ring"]:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\marcos\\"..faction.."UN");
            _G[seat.."_RingSelect"]:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\marcos\\"..faction.."UE");
        elseif (j == 2 or j == 3) then
            _G[seat.."_Ring"]:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\marcos\\"..faction.."RN");
            _G[seat.."_RingSelect"]:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\marcos\\"..faction.."RE");
        elseif (j == 7 or j == 8) then
            _G[seat.."_Ring"]:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\marcos\\"..faction.."LN");
            _G[seat.."_RingSelect"]:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\marcos\\"..faction.."LE");
        else
            _G[seat.."_Ring"]:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\marcos\\"..faction.."DN");
            _G[seat.."_RingSelect"]:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\marcos\\"..faction.."DE");
        end;
    end;
    WPL_UpdateSeat(j);
end;


function WPL_ClientStatusUpdate(j, chips, bet, status, alpha)
    if (status == "Winner!") then
        if (j == 5) then PlaySound("QUESTCOMPLETED", "SFX"); end;
        _G["WPL_Seat_"..j.."_Winner"]:Show();
    end;
    Seats[j].chips = tonumber(chips);
    local newBet = tonumber(bet);
    if (newBet > Seats[j].bet) then PlaySound("LOOTWINDOWCOINSOUND", "SFX"); end;
    Seats[j].bet = newBet;
    if (j ~= 5) then Seats[j].status = status; end;
    Seats[j].alpha = alpha;
    WPL_UpdateSeat(j);
    WPL_TotalPot();
end;


function WPL_ClientShow(hole1, hole2, j, status)
    Seats[j].hole1 = hole1;
    Seats[j].hole2 = hole2;
    Seats[j].status = status;
    Seats[j].dealt = 0;
    WPL_SetCard(Seats[j].blank1, 0, 0, 0, 0, 0, 0, 0, 0);
    WPL_SetCard(Seats[j].blank2, 0, 0, 0, 0, 0, 0, 0, 0);
    WPL_SetCard(hole1, DealerX, DealerY, Seats[j].x, Seats[j].y, 1, 1, 0, 1);
    WPL_SetCard(hole2, DealerX, DealerY, Seats[j].x - 24, Seats[j].y + 4, 1, 1, 0, 0);
    WPL_UpdateSeat(j);
end;

                
function WPL_ClientFlop1(flop1, flop2, flop3)
    Flop = {};
    Flop[1] = flop1;
    Flop[2] = flop2;
    Flop[3] = flop3;
    for i=1,3 do
        WPL_SetCard(Flop[i], DealerX, DealerY, -CardWidth * (3 - i) + 3, 0, 1, 1, 0, 0);
        if (getn(FlopBlank) > 0) then WPL_SetCard(FlopBlank[i], 0, 0, 0, 0, 0, 0, 0, 0); end;
    end;
    FlopBlank = {};
end;


function WPL_ClientFlop0()
    for i=1,3 do
        FlopBlank[i] = BlankCard;
        WPL_SetCard(BlankCard, DealerX, DealerY, -CardWidth * (3 - i) + 3, 0, 1, CC * DealerDelay, 0, 0);
        BlankCard = BlankCard + 1;
        CC = CC - 1;
    end;
end;


function WPL_ClientDeal(j)
    Seats[j].blank1 = BlankCard;
    WPL_SetCard(BlankCard, DealerX, DealerY, Seats[j].x - 24, Seats[j].y + 4, 1, CC * DealerDelay, 0, 0);
    BlankCard = BlankCard + 1;
    CC = CC - 1;
    Seats[j].blank2 = BlankCard;
    WPL_SetCard(BlankCard, DealerX, DealerY, Seats[j].x, Seats[j].y, 1, CC * DealerDelay, 0, 1);
    BlankCard = BlankCard + 1;
    CC = CC - 1;
    Seats[j].dealt = 1;
    Seats[j].status = "Playing";
    Seats[j].alpha = 1;
    WPL_UpdateSeat(j);
end;


function WPL_ClientHole(hole1, hole2, hand)
    local ThisSeat = Seats[5];
    ThisSeat.hole1 = hole1;
    ThisSeat.hole2 = hole2;
    WPL_SetCard(hole2, DealerX, DealerY, ThisSeat.x - 24, ThisSeat.y + 4, 1, CC * DealerDelay, 0, 0);
    CC = CC - 1;
    WPL_SetCard(hole1, DealerX, DealerY, ThisSeat.x, ThisSeat.y, 1, CC * DealerDelay, 0, 1);
    CC = CC - 1;
    ThisSeat.status = hand;
    ThisSeat.dealt = 1;
    ThisSeat.alpha = 1;
    WPL_UpdateSeat(5);
    WPL_Fold:SetText(L["Fold"]);
    WPL_Fold:Show();
end;


function WPL_ClientRound0(thisRoundCount)
    WPL_HideAllButtons(true);
    WPL_AutoButtons:Hide();
    WPL_ClearCards();
    RoundCount = thisRoundCount;
    for j=1,9 do
        _G["WPL_Seat_"..j.."_Winner"]:Hide();
        Seats[j].bet = 0;
        if(Seats[j].dealt == 0) then
            Seats[j].status = "Default";
            Seats[j].alpha = 0.5;
        else
            Seats[j].status = "Playing";
            Seats[j].alpha = 1;
        end;
        WPL_UpdateSeat(j);
    end;
    BetSize = Blinds;
    WPL_TotalPot();
end;


function WPL_IsPlaying(name)
    for j=1,9 do
        if (Seats[j].seated == 1 and Seats[j].name == name) then return 1; end;
    end;
    return 0;
end;


function WPL_SendMessage(msg, username)
    SendAddonMessage("WoWPokerLerduzz", "WPL_".. WPL_SERVER_VERSION.."_"..msg, "WHISPER", username);
end;


function WPL_ConsoleFeedback(msg)
    DEFAULT_CHAT_FRAME:AddMessage(msg);
end;


function WPL_TotalPot()
    local total = 0;
    for j=1,9 do
        if (Seats[j].dealt == 1) then total = total + Seats[j].bet; end;
    end;
    WPL_Pot_Text:SetText(total);
    WPL_SetPotIcon(total)
    return total;
end;


function WPL_SetPotIcon(total)
    if (total == 0) then
        WPL_Pot:Hide();
        return;
    end;
    local potSize = 1;
    if (total >= 100 and total < 1000) then potSize = 2;
    elseif (total >= 1000 and total < 10000) then potSize = 3;
    elseif (total >= 10000) then potSize = 4; end;
    WPL_Pot_Icon:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\monedas\\"..potSize);
    WPL_Pot:Show();
end;


function WPL_ShowCard(j, status)
    if ((Seats[j].seated == 1)) then
        Seats[j].status = status;
        if ((Seats[j].hole1 == 0) or (Seats[j].hole2 == 0)) then return; end;
        WPL_SetCard(Seats[j].hole2, DealerX, DealerY, Seats[j].x - 24, Seats[j].y + 4, 1, 1, 0, 0);
        WPL_SetCard(Seats[j].hole1, DealerX, DealerY, Seats[j].x, Seats[j].y, 1, 1, 0, 1);
        WPL_UpdateSeat(j);
    end;
end;


function WPL_SetupXMLButtons()
    _G["WPL_Fold"]:SetText(L['Fold']);
    _G["WPL_Call"]:SetText(L['Call']);
    _G["WPL_Raise"]:SetText(L['Raise']);
end;
        

function WPL_SetupFrames()
    WPL_SetupErrorFrame();
    WPL_SetupJoinFrame();
    WPL_SetupTableFrame();
    WPL_SetupTopButtons();
    WPL_SetupButtonsFrame();
    WPL_SetupPotFrame();
    WPL_SetupSeatFrames();
    WPL_SetupCardFrames();
    WPL_SetupMiniMapButton();
    WPL_SetupAutoButtonsFrame();
end;


function WPL_SetupErrorFrame()
    local errorFrame = CreateFrame("Frame", "WPL_ErrorFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate");
    errorFrame:Hide();
    errorFrame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true, tileSize = 32, edgeSize = 32,
        insets = {left = 5, right = 5, top = 5, bottom = 5}
    });
    errorFrame:SetFrameStrata("TOOLTIP");
    errorFrame:SetWidth(360);
    errorFrame:SetHeight(140);
    errorFrame:SetPoint("CENTER", UIParent, "CENTER", 0, UIParent:GetHeight() / 4);

    local errorFrameTitle = errorFrame:CreateFontString(errorFrame:GetName().."_Title", "BACKGROUND", "GameFontNormal");
    errorFrameTitle:SetText(L["Error joining poker table"]);
    errorFrameTitle:SetTextColor(1, .5, 0, 1);
    errorFrameTitle:SetFont("Fonts\\MORPHEUS.ttf", 18, "");
    errorFrameTitle:SetPoint("CENTER", errorFrame, "CENTER", 0, 45);

    local errorFrameText = errorFrame:CreateFontString(errorFrame:GetName().."_Text", "BACKGROUND", "GameFontNormal");
    errorFrameText:SetText(L["There are no seats available at this time!"]);
    errorFrameText:SetTextColor(1, 0, 0, 1);
    errorFrameText:SetFont("Fonts\\MORPHEUS.ttf", 15, "");
    errorFrameText:SetPoint("CENTER", errorFrame, "CENTER", 0, 5);

    CreateFont("WPL_ErrorButtonFont");
    WPL_ErrorButtonFont:SetFont("Fonts\\MORPHEUS.ttf", 16, "");

    local okButton = CreateFrame("Button", "WPL_Ok", errorFrame, "UIPanelButtonTemplate");
    okButton:SetText(L["Ok"]);
    okButton:SetHeight(30);
    okButton:SetWidth(120);
    okButton:SetNormalFontObject(WPL_ErrorButtonFont);
    okButton:SetHighlightFontObject(WPL_ErrorButtonFont);
    okButton:SetDisabledFontObject(WPL_ErrorButtonFont);
    okButton:SetPoint("CENTER", errorFrame, "CENTER", 0, -42)
    okButton:SetScript("OnClick", function() WPL_ErrorFrame:Hide(); PlaySound("GAMEDIALOGCLOSE", "SFX"); end);
end;


function WPL_SetupJoinFrame()
    local joinFrame = CreateFrame("Frame", "WPL_JoinFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate");
    joinFrame:Hide();
    joinFrame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true, tileSize = 32, edgeSize = 32,
        insets = {left = 5, right = 5, top = 5, bottom = 5}
    });
    joinFrame:SetFrameStrata("TOOLTIP");
    joinFrame:SetWidth(360);
    joinFrame:SetHeight(140);
    joinFrame:SetPoint("CENTER", UIParent, "CENTER", 0, UIParent:GetHeight() / 4);

    local joinFrameTitle = joinFrame:CreateFontString(joinFrame:GetName().."_Title", "BACKGROUND", "GameFontNormal");
    joinFrameTitle:SetText(L["Do you want to start a game of poker?"]);
    joinFrameTitle:SetFont("Fonts\\MORPHEUS.ttf", 18, "");
    joinFrameTitle:SetPoint("CENTER", joinFrame, "CENTER", 0, 45);

    local joinFrameSlider = CreateFrame("Slider", joinFrame:GetName().."_Slider", joinFrame, "OptionsSliderTemplate");
    joinFrameSlider:SetHeight(30);
    joinFrameSlider:SetWidth(320);
    joinFrameSlider:SetOrientation('HORIZONTAL');
    _G[joinFrame:GetName().."_SliderLow"]:SetText("");
    _G[joinFrame:GetName().."_SliderHigh"]:SetText("");
    joinFrameSlider:SetMinMaxValues(500, 200000);
    joinFrameSlider:SetValueStep(1);
    joinFrameSlider:SetValue(500);
    joinFrameSlider:SetPoint("CENTER", joinFrame, "CENTER", 0, 10);
    joinFrameSlider:SetScript("OnValueChanged", function(self, event, arg1) WPL_StartGold = WPL_JoinFrame_Slider:GetValue(); WPL_JoinFrame_Gold:SetText(WPL_StartGold); end);

    local joinFrameGoldIcon = joinFrame:CreateTexture(joinFrame:GetName().."_GoldIcon", "OVERLAY");
    joinFrameGoldIcon:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\monedas\\0");
    joinFrameGoldIcon:SetWidth(26);
    joinFrameGoldIcon:SetHeight(26);
    joinFrameGoldIcon:SetTexCoord(0, 1, 0, 1);
    joinFrameGoldIcon:SetPoint("CENTER", joinFrame, "CENTER", 156, -18);
    local joinFrameGold = joinFrame:CreateFontString(joinFrame:GetName().."_Gold", "OVERLAY", "GameFontNormal");
    joinFrameGold:SetFont("Fonts\\ARIALN.ttf", 17, "");
    joinFrameGold:SetPoint("TOPRIGHT", joinFrameGoldIcon, "TOPLEFT", -2, 0);
    joinFrameGold:SetText("500");

    CreateFont("WPL_JoinButtonFont");
    WPL_JoinButtonFont:SetFont("Fonts\\MORPHEUS.ttf", 16, "");

    local startButton = CreateFrame("Button", "WPL_Start", joinFrame, "UIPanelButtonTemplate");
    startButton:SetText(L["Start"]);
    startButton:SetHeight(30);
    startButton:SetWidth(120);
    startButton:SetNormalFontObject(WPL_JoinButtonFont);
    startButton:SetHighlightFontObject(WPL_JoinButtonFont);
    startButton:SetDisabledFontObject(WPL_JoinButtonFont);
    startButton:SetPoint("CENTER", joinFrame, "CENTER", -60, -42)
    startButton:SetScript("OnClick", function() WPL_SendMessage("!seat", UnitName("player")); WPL_JoinFrame:Hide(); PlaySound("GAMEDIALOGCLOSE", "SFX"); end);

    local cancelButton = CreateFrame("Button", "WPL_Cancel", joinFrame, "UIPanelButtonTemplate");
    cancelButton:SetText(L["Cancel"]);
    cancelButton:SetHeight(30);
    cancelButton:SetWidth(120);
    cancelButton:SetNormalFontObject(WPL_JoinButtonFont);
    cancelButton:SetHighlightFontObject(WPL_JoinButtonFont);
    cancelButton:SetDisabledFontObject(WPL_JoinButtonFont);
    cancelButton:SetPoint("CENTER", joinFrame, "CENTER", 60, -42)
    cancelButton:SetScript("OnClick", function() WPL_JoinFrame:Hide(); PlaySound("GAMEDIALOGCLOSE", "SFX"); end);
end;


function WPL_SetupTableFrame()
    local tableFrame = CreateFrame("Frame", "WPL_PokerFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate");
    tableFrame:Hide();
    tableFrame:SetMovable(true);
    tableFrame:EnableMouse();
    tableFrame:RegisterForDrag("LeftButton");
    tableFrame:SetScript("OnDragStart", tableFrame.StartMoving);
    tableFrame:SetScript("OnDragStop", tableFrame.StopMovingOrSizing);
    tableFrame:SetFrameStrata("TOOLTIP");
    
    tableFrame:SetScript("OnEvent",WPL_OnEvent);

    tableFrame:SetScript("OnUpdate",function() WPL_OnUpdate(arg1); end);
    tableFrame:SetScript("OnMouseDown",
        function()
            if ( arg1 == "LeftButton" ) then
                this:StartMoving();
            end
        end);
    tableFrame:SetScript("OnMouseUp",
        function()
            if ( arg1 == "LeftButton" ) then
                this:StopMovingOrSizing();
            end
        end);
        
    tableFrame:SetWidth(1024);
    tableFrame:SetHeight(640);
    tableFrame:SetPoint("CENTER",UIParent,"CENTER",0,0);
    
    local circleTexture = tableFrame:CreateTexture("WPL_CCirc", "OVERLAY");
    circleTexture:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\mesa");
    circleTexture:SetTexCoord(0, 1, 0, 1);
    circleTexture:SetWidth(1024);
    circleTexture:SetHeight(1024);
    circleTexture:SetPoint("TOPLEFT", tableFrame, "TOPLEFT", 0, 0)	
end;


function WPL_SetupMiniMapButton()
    local miniMapButton = CreateFrame("Button", "WPL_MapIconFrame", Minimap)    
    miniMapButton:SetFrameStrata("MEDIUM");
    miniMapButton:SetMovable(true);
    miniMapButton:EnableMouse(true);
    miniMapButton:SetWidth(27);
    miniMapButton:SetHeight(27);
    miniMapButton:SetPoint("TOPLEFT", Minimap, "TOPLEFT", -25, -80);
    
    local miniMapButtonTexture = miniMapButton:CreateTexture("WPL_MapIcon", "BACKGROUND")    
    miniMapButtonTexture:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\icono");
    miniMapButtonTexture:SetWidth(27);
    miniMapButtonTexture:SetHeight(27);
    miniMapButtonTexture:SetPoint("CENTER", miniMapButton, "CENTER", 0, 0);    
    miniMapButton:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", "ADD");
    
    miniMapButton:SetScript("OnLoad",function() this:RegisterForClicks("LeftButtonUp","RightButtonUp"); this:RegisterForDrag("RightButton"); end);
    miniMapButton:SetScript("OnMouseDown",function(self, button) if (button=="RightButton") then WPL_DraggingIcon = 1; self:StartMoving() end end);
    miniMapButton:SetScript("OnMouseUp",function(self, button) if (button=="RightButton") then WPL_DraggingIcon = 0; self:StopMovingOrSizing() end end);
    miniMapButton:SetScript("OnClick",function(self, button, down) WPL_LauncherClicked(button); end);
end;


function WPL_SetupTopButtons()
    local minimizeButton = CreateFrame("Button", "WPL_MinimizeButton", WPL_PokerFrame);
    minimizeButton:SetHeight(32);
    minimizeButton:SetWidth(32);
    minimizeButton:SetPoint("CENTER", WPL_PokerFrame, "CENTER", -25, 219);	
    local minimizeIconButton = minimizeButton:CreateTexture("WPL_MinimizeIcon", "BACKGROUND")
    minimizeIconButton:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\botones\\minimizar");
    minimizeIconButton:SetHeight(32);
    minimizeIconButton:SetWidth(32);
    minimizeIconButton:SetPoint("CENTER", minimizeButton, "CENTER", 0, 0);	
    minimizeButton:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight","ADD");	
    minimizeButton:SetScript("OnClick", function() WPL_PokerFrame:Hide(); PlaySound("GAMEDIALOGCLOSE", "SFX"); end);

    local setSizeButton = CreateFrame("Button", "WPL_SetSizeButton", WPL_PokerFrame);
    setSizeButton:SetHeight(32);
    setSizeButton:SetWidth(32);
    setSizeButton:SetPoint("CENTER", WPL_PokerFrame, "CENTER", 0, 219);	
    local setSizeIconButton = setSizeButton:CreateTexture("WPL_SetSizeIcon", "BACKGROUND")
    setSizeIconButton:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\botones\\maximizar");
    setSizeIconButton:SetHeight(32);
    setSizeIconButton:SetWidth(32);
    setSizeIconButton:SetPoint("CENTER", setSizeButton, "CENTER", 0, 0);	
    setSizeButton:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", "ADD");	
    setSizeButton:SetScript("OnClick", function() WPL_SizeClick(); end);
    
    local closeButton = CreateFrame("Button", "WPL_CloseButton", WPL_PokerFrame);
    closeButton:SetHeight(32);
    closeButton:SetWidth(32);
    closeButton:SetPoint("CENTER", WPL_PokerFrame, "CENTER", 25, 219);	
    local closeIconButton = closeButton:CreateTexture("WPL_CloseIcon", "BACKGROUND")
    closeIconButton:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\botones\\cerrar");
    closeIconButton:SetHeight(32);
    closeIconButton:SetWidth(32);
    closeIconButton:SetPoint("CENTER", closeButton, "CENTER", 0, 0);	
    closeButton:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", "ADD");	
    closeButton:SetScript("OnClick", function() WPL_QuitClick(); end);
end;


function WPL_SetupButtonsFrame()
    local buttonsFrame = CreateFrame("Frame", "WPL_Buttons", WPL_PokerFrame, BackdropTemplateMixin and "BackdropTemplate");
    buttonsFrame:SetHeight(30);
    buttonsFrame:SetWidth(560);
    buttonsFrame:SetPoint("CENTER", WPL_PokerFrame, "CENTER", 0, -183);

    CreateFont("WPL_ButtonFont");
    WPL_ButtonFont:SetFont("Fonts\\MORPHEUS.ttf", 16, "");

    local foldButton = CreateFrame("Button", "WPL_Fold", buttonsFrame, "UIPanelButtonTemplate");
    foldButton:Hide();
    foldButton:SetHeight(30);
    foldButton:SetWidth(140);
    foldButton:SetNormalFontObject(WPL_ButtonFont);
    foldButton:SetHighlightFontObject(WPL_ButtonFont);
    foldButton:SetDisabledFontObject(WPL_ButtonFont);
    foldButton:SetPoint("TOPLEFT", buttonsFrame, "TOPLEFT", 0, 0)
    foldButton:SetScript("OnClick", function() WPL_FoldClick(); end);

    local callButton = CreateFrame("Button", "WPL_Call", buttonsFrame, "UIPanelButtonTemplate");
    callButton:Hide();
    callButton:SetHeight(30);
    callButton:SetWidth(140);
    callButton:SetNormalFontObject(WPL_ButtonFont);
    callButton:SetHighlightFontObject(WPL_ButtonFont);
    callButton:SetDisabledFontObject(WPL_ButtonFont);
    callButton:SetPoint("TOPLEFT", foldButton, "TOPRIGHT", 0, 0)
    callButton:SetScript("OnClick", function() WPL_CallClick(); end);

    local raiseButton = CreateFrame("Button", "WPL_Raise", buttonsFrame, "UIPanelButtonTemplate");
    raiseButton:Hide();
    raiseButton:SetHeight(30);
    raiseButton:SetWidth(140);
    raiseButton:SetNormalFontObject(WPL_ButtonFont);
    raiseButton:SetHighlightFontObject(WPL_ButtonFont);
    raiseButton:SetDisabledFontObject(WPL_ButtonFont);
    raiseButton:SetPoint("TOPRIGHT", buttonsFrame, "TOPRIGHT", 0, 0)
    raiseButton:SetScript("OnClick", function() WPL_RaiseClick(); end);

    local raiseSlider = CreateFrame("Slider", "WPL_RaiseSlider", buttonsFrame, "OptionsSliderTemplate");
    raiseSlider:SetHeight(30);
    raiseSlider:SetWidth(140);
    raiseSlider:SetOrientation('HORIZONTAL');
    WPL_RaiseSliderLow:SetText("");
    WPL_RaiseSliderHigh:SetText("");
    raiseSlider:SetValueStep(1);
    raiseSlider:SetPoint("TOPRIGHT", raiseButton, "TOPLEFT", 0, 0);
    raiseSlider:SetScript("OnValueChanged", function(self, event, arg1) WPL_RaiseSlider_OnValueChange(); end);
    WPL_RaiseSlider_Setup(Blinds, Blinds * 50);
    raiseSlider:Show();

    WPL_Buttons:Hide();
end;


function WPL_SetupAutoButtonsFrame()
    local autoButtonsFrame = CreateFrame("Frame", "WPL_AutoButtons", WPL_PokerFrame, BackdropTemplateMixin and "BackdropTemplate");
    autoButtonsFrame:Hide();
    autoButtonsFrame:SetHeight(30);
    autoButtonsFrame:SetWidth(560);
    autoButtonsFrame:SetPoint("CENTER", WPL_PokerFrame, "CENTER", 0, -183);
    autoButtonsFrame:SetBackdrop( { 
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", 
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = false, tileSize = 16, edgeSize = 16, 
        insets = { left = 3, right = 3, top = 3, bottom = 3 }
    });
    autoButtonsFrame:SetBackdropColor(0, 0, 0, .5);
    
    local AutoFoldCheck = CreateFrame("CheckButton", "WPL_AutoFoldCheck", autoButtonsFrame, "UICheckButtonTemplate");
    AutoFoldCheck:SetHeight(27);
    AutoFoldCheck:SetWidth(27);
    AutoFoldCheck:SetPoint("TOPLEFT", autoButtonsFrame, "TOPLEFT", 3, -2)
    AutoFoldCheck:SetScript("OnClick",function() if ( WPL_AutoFoldCheck:GetChecked() )then WPL_AutoBetCheck:SetChecked(false); WPL_AutoCheckCheck:SetChecked(false); end; end);
    local AutoFoldText = autoButtonsFrame:CreateFontString("WPL_AutoFoldText", "BACKGROUND", "GameFontNormal");
    AutoFoldText:SetText(L['Check/Fold']);
    AutoFoldText:SetFont("Fonts\\MORPHEUS.ttf", 18, "");
    AutoFoldText:SetPoint("TOPLEFT", AutoFoldCheck, "TOPRIGHT", 0, -3);

    local AutoCheckCheck = CreateFrame("CheckButton", "WPL_AutoCheckCheck", autoButtonsFrame, "UICheckButtonTemplate");
    AutoCheckCheck:SetHeight(27);
    AutoCheckCheck:SetWidth(27);
    AutoCheckCheck:SetPoint("TOPLEFT", AutoFoldText, "TOPRIGHT", 12, 3)
    AutoCheckCheck:SetScript("OnClick",function() if ( WPL_AutoCheckCheck:GetChecked() )then WPL_AutoFoldCheck:SetChecked(false); WPL_AutoBetCheck:SetChecked(false); end; end);
    local AutoCheckText = autoButtonsFrame:CreateFontString("WPL_AutoCheckText", "BACKGROUND", "GameFontNormal");
    AutoCheckText:SetText(L['Check']);
    AutoCheckText:SetFont("Fonts\\MORPHEUS.ttf", 18, "");
    AutoCheckText:SetPoint("TOPLEFT", AutoCheckCheck, "TOPRIGHT", 0, -3);

    local AutoBetCheck = CreateFrame("CheckButton", "WPL_AutoBetCheck", autoButtonsFrame, "UICheckButtonTemplate");
    AutoBetCheck:SetHeight(27);
    AutoBetCheck:SetWidth(27);
    AutoBetCheck:SetPoint("TOPLEFT", AutoCheckText, "TOPRIGHT", 12, 3);
    AutoBetCheck:SetScript("OnClick",function() if ( WPL_AutoBetCheck:GetChecked() )then WPL_AutoFoldCheck:SetChecked(false); WPL_AutoCheckCheck:SetChecked(false); end; end);
    local AutoBetText = autoButtonsFrame:CreateFontString("WPL_AutoBetText","BACKGROUND","GameFontNormal");
    AutoBetText:SetText(L['Call any']);
    AutoBetText:SetFont("Fonts\\MORPHEUS.ttf", 18, "");
    AutoBetText:SetPoint("TOPLEFT", AutoBetCheck, "TOPRIGHT", 0, -3);

    local AutoStickyCheck = CreateFrame("CheckButton", "WPL_AutoStickyCheck", autoButtonsFrame, "UICheckButtonTemplate");
    AutoStickyCheck:SetHeight(27);
    AutoStickyCheck:SetWidth(27);
    AutoStickyCheck:SetPoint("TOPRIGHT", autoButtonsFrame, "TOPRIGHT", -3, -2)
    local AutoStickyText = autoButtonsFrame:CreateFontString("WPL_AutoStickyText", "BACKGROUND", "GameFontNormal");
    AutoStickyText:SetText(L['Sticky']);
    AutoStickyText:SetFont("Fonts\\MORPHEUS.ttf", 18, "");
    AutoStickyText:SetPoint("TOPRIGHT", AutoStickyCheck, "TOPLEFT", 0, -3);
end;


function WPL_SetupPotFrame()
    local potFrame = CreateFrame("Frame", "WPL_Pot", WPL_PokerFrame, BackdropTemplateMixin and "BackdropTemplate");
    potFrame:SetHeight(30);
    potFrame:SetWidth(180);
    potFrame:SetPoint("CENTER", WPL_PokerFrame, "CENTER", 0, 129);

    local potFrameBox = potFrame:CreateTexture("WPL_Pot_Box", "ARTWORK");
    potFrameBox:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\marco");
    potFrameBox:SetWidth(256);
    potFrameBox:SetHeight(64);
    potFrameBox:SetTexCoord(0, 1, 0, 1);
    potFrameBox:SetPoint("CENTER", potFrame, "CENTER", 36, -17);

    local potFrameString = potFrame:CreateFontString("WPL_Pot_Text", "OVERLAY", "GameFontNormal");
    potFrameString:SetFont("Fonts\\ARIALN.ttf", 20, "");
    potFrameString:SetPoint("CENTER", potFrame, "CENTER", 0, 0);

    local potFrameIcon = potFrame:CreateTexture("WPL_Pot_Icon", "BORDER");
    potFrameIcon:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\monedas\\1");
    potFrameIcon:SetWidth(78);
    potFrameIcon:SetHeight(78);
    potFrameIcon:SetTexCoord(0, 1, 0, 1);
    potFrameIcon:SetPoint("CENTER", potFrame, "CENTER", 0, 30);
end;


function WPL_SetupSeatFrames()
    local seatFrame;
    local seatlocations = {
        {x=272,  y=215},
        {x=497,  y=62},
        {x=497,  y=-226},
        {x=272,  y=-338},
        {x=50,   y=-338},
        {x=-172, y=-338},
        {x=-500, y=-226},
        {x=-500, y=62},
        {x=-172, y=215},
    }
    for seat=1,9 do
        seatFrame = CreateFrame("Frame", "WPL_Seat_"..seat, WPL_PokerFrame, BackdropTemplateMixin and "BackdropTemplate");
        seatFrame:SetHeight(256);
        seatFrame:SetWidth(256);
        seatFrame:SetPoint("CENTER", WPL_PokerFrame, "CENTER", seatlocations[seat].x, seatlocations[seat].y);

        local seatFramePort = seatFrame:CreateTexture(seatFrame:GetName().."_Port", "BORDER");
        seatFramePort:SetWidth(66);
        seatFramePort:SetHeight(66);
        seatFramePort:SetTexCoord(0, 1, 0, 1);
        if (seat == 1 or seat == 9) then seatFramePort:SetPoint("TOPLEFT", seatFrame, "TOPLEFT", 45, -55);
        elseif (seat == 7 or seat == 8) then seatFramePort:SetPoint("TOPLEFT", seatFrame, "TOPLEFT", 148, -12);
        else seatFramePort:SetPoint("TOPLEFT", seatFrame, "TOPLEFT", 45, -12); end;

        local seatFramePortWho = seatFrame:CreateTexture(seatFrame:GetName().."_PortWho", "BORDER");
        seatFramePortWho:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\desconocido");
        seatFramePortWho:SetWidth(66);
        seatFramePortWho:SetHeight(66);
        seatFramePortWho:SetTexCoord(0, 1, 0, 1);
        if (seat == 1 or seat == 9) then seatFramePortWho:SetPoint("TOPLEFT", seatFrame, "TOPLEFT", 45, -55);
        elseif (seat == 7 or seat == 8) then seatFramePortWho:SetPoint("TOPLEFT", seatFrame, "TOPLEFT", 148, -12);
        else seatFramePortWho:SetPoint("TOPLEFT", seatFrame, "TOPLEFT", 45, -12); end;
        
        local seatFrameRing = seatFrame:CreateTexture(seatFrame:GetName().."_Ring", "ARTWORK");
        if (seat == 1 or seat == 9) then seatFrameRing:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\marcos\\AUN");
        elseif (seat == 2 or seat == 3) then seatFrameRing:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\marcos\\ARN");
        elseif (seat == 7 or seat == 8) then seatFrameRing:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\marcos\\ALN");
        else seatFrameRing:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\marcos\\ADN"); end;
        seatFrameRing:SetWidth(400);
        seatFrameRing:SetHeight(200);
        seatFrameRing:SetTexCoord(0, 1, 0, 1);
        seatFrameRing:SetPoint("TOPLEFT", seatFrame, "TOPLEFT", 0, 0);

        local seatFrameRingSelect = seatFrame:CreateTexture(seatFrame:GetName().."_RingSelect", "ARTWORK");
        if (seat == 1 or seat == 9) then seatFrameRingSelect:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\marcos\\AUE");
        elseif (seat == 2 or seat == 3) then seatFrameRingSelect:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\marcos\\ARE");
        elseif (seat == 7 or seat == 8) then seatFrameRingSelect:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\marcos\\ALE");
        else seatFrameRingSelect:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\marcos\\ADE"); end;
        seatFrameRingSelect:Hide();
        seatFrameRingSelect:SetWidth(400);
        seatFrameRingSelect:SetHeight(200);
        seatFrameRingSelect:SetTexCoord(0, 1, 0, 1);
        seatFrameRingSelect:SetPoint("TOPLEFT", seatFrame, "TOPLEFT", 0, 0);

        local seatFrameButton = seatFrame:CreateTexture(seatFrame:GetName().."_Button", "OVERLAY");
        seatFrameButton:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\boton");
        seatFrameButton:Hide();
        seatFrameButton:SetWidth(20);
        seatFrameButton:SetHeight(20);
        seatFrameButton:SetTexCoord(0, 1, 0, 1);
        local dX = Seats[seat].x;
        local dY = Seats[seat].y;
        if (seat == 1 or seat == 4) then dX = dX - 82; end;
        if (seat == 1 or seat == 9) then dY = dY + 67; end;
        if (seat == 2 or seat == 8) then dY = dY + 92; end;
        if (seat == 2 or seat == 3) then dX = dX + 8; end;
        if (seat == 3 or seat == 7) then dY = dY - 50; end;
        if (seat == 4 or seat == 5 or seat == 6) then dY = dY - 25; end;
        if (seat == 5 or seat == 6 or seat == 9) then dX = dX + 50; end;
        if (seat == 7 or seat == 8) then dX = dX - 40; end;
        seatFrameButton:SetPoint("CENTER", WPL_PokerFrame, "CENTER", dX, dY);

        local seatFrameName = seatFrame:CreateFontString(seatFrame:GetName().."_Name", "OVERLAY", "GameFontNormal");
        seatFrameName:SetFont("Fonts\\MORPHEUS.ttf", 16, "");
        if (seat == 1 or seat == 9) then seatFrameName:SetPoint("CENTER", seatFrame, "TOPLEFT", 78, -11);
        elseif (seat == 2 or seat == 3) then seatFrameName:SetPoint("CENTER", seatFrame, "TOPLEFT", 185, -29);
        elseif (seat == 7 or seat == 8) then seatFrameName:SetPoint("CENTER", seatFrame, "TOPLEFT", 73, -29);
        else seatFrameName:SetPoint("CENTER", seatFrame, "TOPLEFT", 78, -92); end;

        local seatFrameGoldIcon = seatFrame:CreateTexture(seatFrame:GetName().."_GoldIcon", "OVERLAY");
        seatFrameGoldIcon:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\monedas\\0");
        seatFrameGoldIcon:SetWidth(19);
        seatFrameGoldIcon:SetHeight(19);
        seatFrameGoldIcon:SetTexCoord(0, 1, 0, 1);
        if (seat == 1 or seat == 9) then seatFrameGoldIcon:SetPoint("TOPRIGHT", seatFrame, "TOPLEFT", 151, -22);
        elseif (seat == 2 or seat == 3) then seatFrameGoldIcon:SetPoint("TOPRIGHT", seatFrame, "TOPLEFT", 260, -40);
        elseif (seat == 7 or seat == 8) then seatFrameGoldIcon:SetPoint("TOPRIGHT", seatFrame, "TOPLEFT", 146, -40);
        else seatFrameGoldIcon:SetPoint("TOPRIGHT", seatFrame, "TOPLEFT", 151, -103); end;
        local seatFrameGold = seatFrame:CreateFontString(seatFrame:GetName().."_Gold", "OVERLAY", "GameFontNormal");
        seatFrameGold:SetFont("Fonts\\ARIALN.ttf", 14, "");
        seatFrameGold:SetPoint("TOPRIGHT", seatFrameGoldIcon, "TOPLEFT", 0, 0);
        seatFrameGold:SetText("0");

        local seatFrameStatus = seatFrame:CreateFontString(seatFrame:GetName().."_Status", "OVERLAY", "GameFontNormal");
        seatFrameStatus:SetFont("Fonts\\MORPHEUS.ttf", 11, "");
        if (seat == 1 or seat == 9) then seatFrameStatus:SetPoint("CENTER", seatFrame, "TOPLEFT", 78, -43);
        elseif (seat == 2 or seat == 3) then seatFrameStatus:SetPoint("CENTER", seatFrame, "TOPLEFT", 185, -61);
        elseif (seat == 7 or seat == 8) then seatFrameStatus:SetPoint("CENTER", seatFrame, "TOPLEFT", 73, -61);
        else seatFrameStatus:SetPoint("CENTER", seatFrame, "TOPLEFT", 78, -123); end;

        local seatFrameWinner = seatFrame:CreateFontString(seatFrame:GetName().."_Winner", "OVERLAY", "GameFontNormal");
        seatFrameWinner:Hide();
        seatFrameWinner:SetFont("Fonts\\MORPHEUS.ttf", 30, "");
        seatFrameWinner:SetText(L["Winner!"]);
        seatFrameWinner:SetTextColor(.2, 1, .2, 1);
        seatFrameWinner:SetPoint("CENTER", WPL_PokerFrame, "CENTER", Seats[seat].x - 18, Seats[seat].y + 20);

        local seatFrameCountdown = seatFrame:CreateFontString(seatFrame:GetName().."_Countdown", "OVERLAY", "GameFontNormal");
        seatFrameCountdown:Hide();
        seatFrameCountdown:SetFont("Fonts\\ARIALN.ttf", 18, "");
        seatFrameCountdown:SetText("15");
        seatFrameCountdown:SetTextColor(1, 0, 0, 1);
        if (seat == 1 or seat == 9) then seatFrameCountdown:SetPoint("CENTER", seatFrame, "TOPLEFT", 49, -111);
        elseif (seat == 7 or seat == 8) then seatFrameCountdown:SetPoint("CENTER", seatFrame, "TOPLEFT", 208, -66);
        else seatFrameCountdown:SetPoint("CENTER", seatFrame, "TOPLEFT", 49, -66); end;
    end;
end;


function WPL_SetupCardFrames()
    local cardFrame;
    local thiscard;
    cardFrame = CreateFrame("Frame", "WPL_CardFrame", WPL_PokerFrame);
    cardFrame:SetHeight(560);
    cardFrame:SetWidth(860);
    cardFrame:SetPoint("CENTER", nil, nil, -330, 220);
    for card=0,12 do
        thiscard = cardFrame:CreateTexture("WPL_Card_C"..card, "ARTWORK");
        thiscard:SetHeight(150);
        thiscard:SetWidth(150);
        thiscard:SetPoint("CENTER", nil, nil);
        thiscard:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\cartas\\picas\\"..card);

        thiscard = cardFrame:CreateTexture("WPL_Card_D"..card, "ARTWORK");
        thiscard:SetHeight(150);
        thiscard:SetWidth(150);
        thiscard:SetPoint("CENTER", nil, nil);
        thiscard:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\cartas\\diamantes\\"..card);

        thiscard = cardFrame:CreateTexture("WPL_Card_H"..card, "ARTWORK");
        thiscard:SetHeight(150);
        thiscard:SetWidth(150);
        thiscard:SetPoint("CENTER", nil, nil);
        thiscard:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\cartas\\corazones\\"..card);

        thiscard = cardFrame:CreateTexture("WPL_Card_S"..card, "ARTWORK");
        thiscard:SetHeight(150);
        thiscard:SetWidth(150);
        thiscard:SetPoint("CENTER", nil, nil);
        thiscard:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\cartas\\trevoles\\"..card);
    end;
    for card=1,23 do
        thiscard = cardFrame:CreateTexture("WPL_Blank_"..card, "ARTWORK");
        thiscard:SetHeight(150);
        thiscard:SetWidth(150);
        thiscard:SetPoint("CENTER", nil, nil);
        thiscard:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\cartas\\reverso")
    end;
end;

WPL_OnLoad();
