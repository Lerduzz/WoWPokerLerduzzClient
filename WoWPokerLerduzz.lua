local L = MyLocalization;

local ldb = LibStub:GetLibrary("LibDataBroker-1.1");
local FHS_LDBObject;

local UPDATEPERIOD, elapsed = 1, 0
local FHS_ldbIcon = true;

local FHS_DEBUGING = false;
local FHS_HOLDEM_version = "v4.1.7";
local FHS_COMMS_version = "v8.1.0";
local StuffLoaded = 0;
local FHS_DraggingIcon = 0;

------------Saved Variables------------------
local FHS_MapIconAngle = 0;
local FHS_SetSize = 0;
local minimapIcon = true;
-----------------

local lasttime = 0;
local timedelta = 0;

local BigBlindStart = 20;
local BlindIncrease = 0.25;
local StartChips = 500;

local NextRefresh = 0;

local WhosTurn = 0;
local HighestBet = 0;

local BetSize = BigBlindStart;

local Blinds = 0;

local RoundCount = 0;

local PokerLerduzz_options_panel;


local CardRank=
{
    "--",
    L['Two'],
    L['Three'],
    L['Four'],
    L['Five'],
    L['Six'],
    L['Seven'],
    L['Eight'],
    L['Nine'],
    L['Ten'],
    L['Jack'],
    L['Queen'],
    L['King'],
    L['Ace'],
};

local CardRanks=
{
    "--",
    L['Twos'],
    L['Threes'],
    L['Fours'],
    L['Fives'],
    L['Sixes'],
    L['Sevens'],
    L['Eights'],
    L['Nines'],
    L['Tens'],
    L['Jacks'],
    L['Queens'],
    L['Kings'],
    L['Aces'],
};


local Cards = 
{
    {object="FHS_Card_C0",	rank=14,	suit=1},
    {object="FHS_Card_C1",	rank=2,		suit=1},
    {object="FHS_Card_C2",	rank=3,		suit=1},
    {object="FHS_Card_C3",	rank=4,		suit=1},
    {object="FHS_Card_C4",	rank=5,		suit=1},
    {object="FHS_Card_C5",	rank=6,		suit=1},
    {object="FHS_Card_C6",	rank=7,		suit=1},
    {object="FHS_Card_C7",	rank=8,		suit=1},
    {object="FHS_Card_C8",	rank=9,		suit=1},
    {object="FHS_Card_C9",	rank=10,	suit=1},
    {object="FHS_Card_C10",	rank=11,	suit=1},
    {object="FHS_Card_C11",	rank=12,	suit=1},
    {object="FHS_Card_C12",	rank=13,	suit=1},

    {object="FHS_Card_D0",	rank=14,	suit=2},
    {object="FHS_Card_D1",	rank=2,		suit=2},
    {object="FHS_Card_D2",	rank=3,		suit=2},
    {object="FHS_Card_D3",	rank=4,		suit=2},
    {object="FHS_Card_D4",	rank=5,		suit=2},
    {object="FHS_Card_D5",	rank=6,		suit=2},
    {object="FHS_Card_D6",	rank=7,		suit=2},
    {object="FHS_Card_D7",	rank=8,		suit=2},
    {object="FHS_Card_D8",	rank=9,		suit=2},
    {object="FHS_Card_D9",	rank=10,	suit=2},
    {object="FHS_Card_D10",	rank=11,	suit=2},
    {object="FHS_Card_D11",	rank=12,	suit=2},
    {object="FHS_Card_D12",	rank=13,	suit=2},

    {object="FHS_Card_H0",	rank=14,	suit=3},
    {object="FHS_Card_H1",	rank=2,		suit=3},
    {object="FHS_Card_H2",	rank=3,		suit=3},
    {object="FHS_Card_H3",	rank=4,		suit=3},
    {object="FHS_Card_H4",	rank=5,		suit=3},
    {object="FHS_Card_H5",	rank=6,		suit=3},
    {object="FHS_Card_H6",	rank=7,		suit=3},
    {object="FHS_Card_H7",	rank=8,		suit=3},
    {object="FHS_Card_H8",	rank=9,		suit=3},
    {object="FHS_Card_H9",	rank=10,	suit=3},
    {object="FHS_Card_H10",	rank=11,	suit=3},
    {object="FHS_Card_H11",	rank=12,	suit=3},
    {object="FHS_Card_H12",	rank=13,	suit=3},

    {object="FHS_Card_S0",	rank=14,	suit=4},
    {object="FHS_Card_S1",	rank=2,		suit=4},
    {object="FHS_Card_S2",	rank=3,		suit=4},
    {object="FHS_Card_S3",	rank=4,		suit=4},
    {object="FHS_Card_S4",	rank=5,		suit=4},
    {object="FHS_Card_S5",	rank=6,		suit=4},
    {object="FHS_Card_S6",	rank=7,		suit=4},
    {object="FHS_Card_S7",	rank=8,		suit=4},
    {object="FHS_Card_S8",	rank=9,		suit=4},
    {object="FHS_Card_S9",	rank=10,	suit=4},
    {object="FHS_Card_S10",	rank=11,	suit=4},
    {object="FHS_Card_S11",	rank=12,	suit=4},
    {object="FHS_Card_S12",	rank=13,	suit=4},
    
    {object="FHS_Blank_1" },
    {object="FHS_Blank_2" },
    {object="FHS_Blank_3" },
    {object="FHS_Blank_4" },
    {object="FHS_Blank_5" },
    {object="FHS_Blank_6" },
    {object="FHS_Blank_7" },
    {object="FHS_Blank_8" },
    {object="FHS_Blank_9" },
    {object="FHS_Blank_10" },
    {object="FHS_Blank_11" },
    {object="FHS_Blank_12" },
    {object="FHS_Blank_13" },
    {object="FHS_Blank_14" },
    {object="FHS_Blank_15" },
    {object="FHS_Blank_16" },
    {object="FHS_Blank_17" },
    {object="FHS_Blank_18" },
    {object="FHS_Blank_19" },
    {object="FHS_Blank_20" },
    {object="FHS_Blank_21" },
    {object="FHS_Blank_22" },
    {object="FHS_Blank_23" },
};


local Seats	= {
    { object="FHS_Seat_1", name="", x=219,	y=120,	chips=0, bet=0, status="", seated=0, hole1=0, hole2=0, dealt=0, alpha=1, inout="", blank1=0, blank2 = 0 },
    { object="FHS_Seat_2", name="", x=360,  y=65,	chips=0, bet=0, status="", seated=0, hole1=0, hole2=0, dealt=0, alpha=1, inout="", blank1=0, blank2 = 0 },
    { object="FHS_Seat_3", name="", x=360,  y=-95,	chips=0, bet=0, status="", seated=0, hole1=0, hole2=0, dealt=0, alpha=1, inout="", blank1=0, blank2 = 0 },
    { object="FHS_Seat_4", name="", x=220,  y=-130,	chips=0, bet=0, status="", seated=0, hole1=0, hole2=0, dealt=0, alpha=1, inout="", blank1=0, blank2 = 0 },
    { object="FHS_Seat_5", name="", x=2,    y=-130,	chips=0, bet=0, status="", seated=0, hole1=0, hole2=0, dealt=0, alpha=1, inout="", blank1=0, blank2 = 0 },
    { object="FHS_Seat_6", name="", x=-220, y=-130,	chips=0, bet=0, status="", seated=0, hole1=0, hole2=0, dealt=0, alpha=1, inout="", blank1=0, blank2 = 0 },
    { object="FHS_Seat_7", name="", x=-360, y=-95,	chips=0, bet=0, status="", seated=0, hole1=0, hole2=0, dealt=0, alpha=1, inout="", blank1=0, blank2 = 0 },
    { object="FHS_Seat_8", name="", x=-355,	y=50,	chips=0, bet=0, status="", seated=0, hole1=0, hole2=0, dealt=0, alpha=1, inout="", blank1=0, blank2 = 0 },
    { object="FHS_Seat_9", name="", x=-220, y=120,	chips=0, bet=0, status="", seated=0, hole1=0, hole2=0, dealt=0, alpha=1, inout="", blank1=0, blank2 = 0 },
};

local Flop = {};
local FlopBlank = {};

local CardWidth = 80;

local DealerX = 0;
local DealerY = 250;

local DealerDelay = 0.5;
local CardSpeed = 3;
local CC = 0;
local BlinkOn = 1;


function FHSPoker_OnLoad()
    StaticPopupDialogs["FHS_DEALER"] = 
    {
        text = L["Do you want to start the game?"],
        button1 = L['Start Dealing'],
        button2 = L['Cancel'],
        button3 = L['Options'],
        OnAccept = function() FHS_SendMessage("!seat", UnitName("player")); end,
        OnAlt = function() InterfaceOptionsFrame_OpenToCategory(PokerLerduzz_options_panel) end,
        timeout = 0,
        whileDead = 1,
        hideOnEscape = 1
    };
    FHS_Setup_LDB();
    FHS_SetupFrames();
    FHSPoker_registerEvents();
    FHS_Console_Feedback("::  "..L['WoW Poker Lerduzz'] .." ".. FHS_HOLDEM_version);
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
    FHS_ClearTable();
    StuffLoaded = 1;
end;


function FHS_SizeClick()
    FHS_SetSize = FHS_SetSize + 1;
    if (FHS_SetSize > 2) then FHS_SetSize = 0; end;
    if (FHS_SetSize == 0) then
        FHSPokerFrame:SetScale(1);
    elseif (FHS_SetSize == 1) then
        FHSPokerFrame:SetScale(0.75);
    elseif (FHS_SetSize == 2) then
        FHSPokerFrame:SetScale(0.5);            
    end;
    FHSPokerFrame:ClearAllPoints();
    FHSPokerFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
end;


function FHS_ClearCards()
    CC = 0;
    for key, object in pairs(Cards) do FHS_SetCard(key, DealerX, DealerY, 0, 0, 0, 0, 0, 0); end;
    Flop = {};
    FlopBlank = {};
    BlankCard = 53;
end;


function FHS_InitializeSeat(j)
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
    Seats[j].inout = "IN";
end;


function FHS_ClearTable()
    for j=1,9 do
        FHS_InitializeSeat(j);
        FHS_UpdateSeat(j);
    end;
    FHS_ClearCards();
    FHS_SelectPlayerRing(0);
    FHS_Status_Text:SetText("");
    FHS_Pot_Text:SetText(L['WoW Poker Lerduzz'])
    FHS_HideAllButtons(true);
end;


function FHSPoker_registerEvents()    
    FHSPokerFrame:RegisterEvent("ADDON_LOADED");
    FHSPokerFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
    FHSPokerFrame:RegisterEvent("CHAT_MSG_ADDON");
end;


function FHSPoker_OnEvent(self, event, ...)
    -- prefix = arg1;
    -- msg = arg2;
    -- distrib = arg3;
    -- sender = arg4;
    if (event == "PLAYER_ENTERING_WORLD") then
        FHS_Debug_Feedback("PLAYER_ENTERING_WORLD" );
    elseif (event == "ADDON_LOADED") then
        arg1 = ...;
        if (arg1 == "WoWPokerLerduzz") then
            if (FHS_StartChips) then StartChips = FHS_StartChips; end;
            if (FHS_BlindIncrease) then FHS_SetBlindIncr(FHS_BlindIncrease); end;
            if (FHS_BigBlindStart) then BigBlindStart = FHS_BigBlindStart; end;
            if (FHS_minimapIcon) then
                minimapIcon = FHS_minimapIcon;
                FHSPoker_MapIconFrame:Show();
            else
                FHSPoker_MapIconFrame:Hide();
            end;
            FHS_SetupOptionsPanel();
            FHS_SetupXMLButtons();
        end
    elseif (event == "CHAT_MSG_ADDON") then
        arg1, arg2, arg3, arg4 = ...;
        FHS_Debug_Feedback("CHAT_MSG_ADDON "..arg1);
        if (arg1 == "PokerLerduzz") then FHS_HandleAddonComms(arg2, arg3, arg4); end;
    end;
end;


function FHSPoker_Update(arg1)	
    --Animation is handled here
    if (StuffLoaded==1) then
--		SetPortraitTexture(FHS_Seat_Port_9, "player");
        local time=GetTime();

        timedelta=time-lasttime;
        
        if (lasttime==0) then
            timedelta=0;
        end -- initialization
        
        lasttime=time;
    
        for key, object in pairs(Cards) do 
    
            -- This is nice, just increase fraction until it hits 1			
            if (Cards[key].fraction<1) then
                Cards[key].fraction=Cards[key].fraction+(timedelta*CardSpeed);
            else
                if (Cards[key].fadeout>0) then  --Track how many ms we've been faded
                    Cards[key].fadetime=Cards[key].fadetime+(timedelta*1000);
                end;
            end
        
            if (Cards[key].fraction>1) then
                Cards[key].fraction=1;
            end

            -- And update it
            FHS_DrawCard(key);
        end

        if ( time>NextRefresh ) then
            NextRefresh=time+1;
            for j=1,9 do
                FHS_UpdateSeat(j);
            end
            
            if (WhosTurn>0) then
                FHS_BlinkWhosTurn();
            end;
        end;
    end
end;


function FHSPoker_MapIconUpdate()
    if (FHS_DraggingIcon == 1) then
        local xpos, ypos = GetCursorPosition();
        local xmin, ymin = Minimap:GetLeft(), Minimap:GetBottom();
        xpos = xmin - xpos / Minimap:GetEffectiveScale() + 70;
        ypos = ypos / Minimap:GetEffectiveScale() - ymin - 70;
        FHS_MapIconAngle = math.deg(math.atan2(ypos, xpos));
        FHS_IconPos(FHS_MapIconAngle);
    end;
    FHSPoker_MapIcon:Show();
    FHSPoker_MapIcon:SetAlpha(1);
    if ((5 == WhosTurn) and (Seats[5].seated == 1)) then
        var = (sin(GetTime() * 400 ) +1 ) / 2;
        FHSPoker_MapIcon:SetAlpha(var);
    end;
end;


function FHS_LDB_OnUpdate()
    if ((5 == WhosTurn) and (Seats[5].seated == 1)) then
        varR = (sin(GetTime() * 400) * 128);
        varG = (cos(GetTime() * 400) * 128);
        varB = (sin(GetTime() * 400) * -128);
        FHS_LDBObject.text = L['Your turn'];
        FHS_LDBObject.iconB = varB;
        FHS_LDBObject.iconG = varG;
        FHS_LDBObject.iconR = varR;
    else
        FHS_LDBObject.text = L['WoW Poker Lerduzz'];
        FHS_LDBObject.iconB = 255;
        FHS_LDBObject.iconG = 255;
        FHS_LDBObject.iconR = 255;
    end;
end;


function FHS_Hidden_frame_OnUpdate(self, elap)
    if (StuffLoaded == 1) then
        if (minimapIcon) then FHSPoker_MapIconUpdate(); end;
        if (FHS_ldbIcon) then FHS_LDB_OnUpdate(); end;
    end;
end;


function FHS_LauncherClicked(button)
    if (button == "RightButton") then
        InterfaceOptionsFrame_OpenToCategory(PokerLerduzz_options_panel);
    elseif (button == "LeftButton") then
        if (Seats[5].seated == 0) then
            StaticPopup_Show("FHS_DEALER");
            return;
        end;
        FHSPokerFrame:Show();
    end;
end;


function FHS_IconPos(angle)
    local xpos = cos(angle) * 81;
    local ypos = sin(angle) * 81;
    FHSPoker_MapIconFrame:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", 53 - xpos, -55 + ypos);
end;


function FHS_BlinkWhosTurn()	
    if (BlinkOn == 0) then
        BlinkOn = 1;
        if (WhosTurn > 0) then
            _G["FHS_Seat_"..WhosTurn.."_RingSelect"]:Show()
            _G["FHS_Seat_"..WhosTurn.."_Ring"]:Hide()
        end;
    else
        BlinkOn = 0;
        if (WhosTurn > 0) then
            _G["FHS_Seat_"..WhosTurn.."_RingSelect"]:Hide();
            _G["FHS_Seat_"..WhosTurn.."_Ring"]:Show();
        end;
    end;
end;


function FHS_SetCard(index,dealerx,dealery,x,y,visible,fraction,fadeout,highlayer)
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
    FHS_DrawCard(index);
end;


function FHS_DrawCard(index)
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
        card.Artwork:SetPoint("CENTER", "FHSPokerFrame", "CENTER", dx + 29, dy);
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
        card.Artwork:SetPoint("CENTER", "FHSPokerFrame", "CENTER", 0, 0);
        card.Artwork:Hide();
    end;
end;


function FHS_UpdateSeat(j)	
    local seat = "FHS_Seat_"..j
    
    -- If no player at position then hide/clear all data
    if (Seats[j].seated==0) then
        _G[seat.."_Name"]:SetText("")
        _G[seat.."_Chips"]:SetText(L["Empty"])
        _G[seat.."_Status"]:SetText("")
        _G[seat.."_Port"]:Hide()
        _G[seat.."_PortWho"]:Hide()
        _G[seat]:Hide()
    else
        _G[seat]:Show()
        _G[seat]:SetAlpha(Seats[j].alpha)
        _G[seat.."_Name"]:SetText(Seats[j].name)
        _G[seat.."_Chips"]:SetText(L['Chips']..": "..Seats[j].chips)
        
        -- Pull Blinds data if we aren't the dealer and we receive info on a bet
        -- Setting Blinds for a client sets the Min Bet
        if ( Dealer == 0 and (Seats[j].status == "Big Blind" or Seats[j].status == "Blinds")) then
            Blinds = Seats[j].bet;
            Betsize = Seats[j].bet;
        end
        
        -- Translate status to local language. Cannot be done at source as source my not be playing in the same language!
        local tempStatus = Seats[j].status;
        if (tempStatus ~= "" and tempStatus ~= "Default" and tempStatus ~= "Playing") then
            tempStatus = L[Seats[j].status]..": "..Seats[j].bet;
        else
            tempStatus = L[Seats[j].status];
        end
        _G[seat.."_Status"]:SetText(tempStatus);
        _G[seat.."_PortWho"]:Hide();
        
        --Portrait
        local portraitObj = _G[seat.."_Port"]
        portraitObj:Show()
        
        if ( UnitName("player")==Seats[j].name) then --Visible
            SetPortraitTexture(portraitObj,"player");
            Seats[j].HavePort=1;
            
        elseif ( UnitName("target")==Seats[j].name) then --Visible
            SetPortraitTexture(portraitObj,"target");
            Seats[j].HavePort=1;
            
        else
            for n=1,5 do
                if ( UnitName("party"..n)==Seats[j].name) then --Visible
                    SetPortraitTexture(portraitObj, "party"..n);
                    Seats[j].HavePort=1;
                    break
                end
            end;
            
            if ( UnitInRaid("player") )then
                for n=1,40 do
                    if ( UnitName("raid"..n)==Seats[j].name) then --Visible
                        SetPortraitTexture(portraitObj, "raid"..n);
                        Seats[j].HavePort=1;
                        break
                    end
                end
            end
        end
    
        if (Seats[j].HavePort==0) then
            portraitObj:Hide();	
            _G[seat.."_PortWho"]:Show()
        end		
    end
end


function FHS_StopClient()
    WhosTurn = 0;
    FHS_ClearTable();
end;


function FHS_QuitClick()
    FHS_SendMessage("q_5", UnitName("player"));
    FHS_StopClient();
    FHS_HideAllButtons(true);
    FHSPokerFrame:Hide();
end;


function FHS_SitOutInClick()
    if(Seats[5].inout == "IN") then
        FHS_FoldClick();
        FHS_SendMessage("inout_5_OUT", UnitName("player"));
        Seats[5].inout = "OUT";
        FHSPoker_SitInOutIcon:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\botones\\sentarse");
    else			
        FHS_SendMessage("inout_5_IN", UnitName("player"));
        Seats[5].inout = "IN";
        FHSPoker_SitInOutIcon:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\botones\\pararse");
    end;
end;


function FHS_HideAllButtons(fold)
    if (fold) then FHS_Fold:Hide(); end;
    FHS_Call:Hide();
    FHS_Raise:Hide();
    FHS_Raise_Higher:Hide();
    FHS_Raise_Lower:Hide();
    FHS_AllIn:Hide();
end;


function FHS_FoldClick()
    if (Seats[5].dealt == 1) then
        FHS_SendMessage("fold_5", UnitName("player"));
        Seats[5].dealt = 0;	
        FHS_ShowCard(5, "Folded");
        FHS_Fold:SetText(L['Show Cards']);
        FHS_Fold:Hide();
    else
        FHS_SendMessage("showcards_5_"..RoundCount, UnitName("player"));
        FHS_Fold:Hide()
    end;
    FHS_UpdateSeat(5);
    FHS_HideAllButtons(false);
end;


function FHS_RaiseClick()
    if (Seats[5].seated == 0) then return; end;
    delta = -1;
    delta = HighestBet - Seats[5].bet;
    delta = delta + BetSize;
    if (HighestBet+BetSize >= Seats[5].chips) then delta=Seats[5].chips; end;
    FHS_SendMessage("call_5_"..delta, UnitName("player"));
end;


function FHS_AllInClick()
    if (Seats[5].seated == 0) then return; end;
    delta = -1;
    delta = Seats[5].chips;	
    if (delta == 0) then return; end;
    FHS_SendMessage("call_5_"..delta, UnitName("player"));
end;


function FHS_CallClick()	
    if (Seats[5].seated == 0) then return; end;
    delta = -1;
    if (Seats[5].bet < HighestBet) then
        delta = HighestBet-Seats[5].bet;
        if (delta > Seats[5].chips) then delta = -1; end;
    end;
    if (Seats[5].bet == HighestBet) then delta = 0; end;
    if (delta > -1) then FHS_SendMessage("call_5_"..delta, UnitName("player")); end;
end;


function FHS_StartClient()
    FHS_ClearTable();
    FHSPokerFrame:Show();
end;


-- Enable or disable the buttons based on whats going on
function FHS_UpdateWhosTurn()	
    if (Seats[5].seated == 0) then return; end;

    --Fold Button, available while we still have cards
    if (Seats[5].dealt==1) then
        FHS_Fold:SetText(L['Fold']);
        FHS_Fold:Show();
    end;

    FHS_SelectPlayerRing(WhosTurn);

    if (WhosTurn == 5) then
        --Its our turn!
        
        FHS_Call:Show();
        FHS_AllIn:Show();
        FHS_Raise:Show();
        FHS_Raise_Higher:Show();
        FHS_Raise_Lower:Show();
        
        Call=1;
        
        --Set the text based on the action required
        delta = HighestBet - Seats[5].bet;
        FHS_Debug_Feedback("Delta:"..delta)
        FHS_Call:SetText(L["Call"].." "..delta)

        if (Seats[5].bet==HighestBet) then
            FHS_Call:SetText(L['Check']);
            delta=0;
            Call=0;
        end
        
-- ******************
-- Need to change the raise ammount to be ateast the last raise instead of the blind
-- ******************
        -- Make sure we have enough chips
        if (Call==1) then
            FHS_Raise:SetText(L['Raise'].." "..delta.."+"..BetSize);
        else
            FHS_Raise:SetText(L['Raise'].." "..BetSize);
        end;


        if ( Seats[5].chips <= delta ) then
            delta=-1;			
            if (Call==1) then
                FHS_Raise:SetText(L['Call'].." "..L['All In']);
                FHS_Call:Hide();
            else
                FHS_Raise:SetText(L['All In']);
            end;		
        end;
        
        --Check for automatic play
        if ( FHS_AutoBetCheck:GetChecked() ) then
            if ( not FHS_AutoStickyCheck:GetChecked() ) then
                FHS_AutoBetCheck:SetChecked(false);
            end;
            FHS_CallClick();
        end;
        
        if ( FHS_AutoCheckCheck:GetChecked() and Call==0 ) then
            if ( not FHS_AutoStickyCheck:GetChecked() ) then
                FHS_AutoCheckCheck:SetChecked(false);
            end;
            FHS_CallClick();
        end;
        
        if ( FHS_AutoFoldCheck:GetChecked() ) then
            if ( not FHS_AutoStickyCheck:GetChecked() ) then
                FHS_AutoFoldCheck:SetChecked(false);
            end;
            FHS_FoldClick();
        end;

    else
        --Its not our turn!
        FHS_HideAllButtons(false)
    end;
end;


function FHS_RaiseChange(dir)
    local CallAmount = 0;
    CallAmount = HighestBet-Seats[5].bet;
    BetSize = BetSize + (dir * 20);
    if (BetSize < Blinds) then BetSize = Blinds; end;
    if (BetSize > (Seats[5].chips - CallAmount)) then BetSize=Seats[5].chips - CallAmount; end;
    FHS_UpdateWhosTurn();
end;


function FHS_SelectPlayerRing(j)
    for r=1,9 do
        _G["FHS_Seat_"..r.."_RingSelect"]:Hide();
        _G["FHS_Seat_"..r.."_Ring"]:Show();
    end;
    if (j > 0) then
        _G["FHS_Seat_"..j.."_RingSelect"]:Show();
        _G["FHS_Seat_"..j.."_RingSelect"]:SetAlpha(1);
        _G["FHS_Seat_"..j.."_Ring"]:Hide();
    end;
end;


function FHS_SelectPlayerButton(j)
    for r=1,9 do _G["FHS_Seat_"..r.."_Button"]:Hide(); end;
    if (j > 0) then _G["FHS_Seat_"..j.."_Button"]:Show(); end;
end;


function FHS_HandleAddonComms(msg, channel, sender)
    local tab = { strsplit( "_", msg) };
    if (table.getn(tab) < 3) then return; end;
    if (tab[1] ~= "FHS" or tab[2] ~= FHS_COMMS_version) then return; end;
    if (UnitName("player") ~= sender) then return; end;
    
    if (tab[3] == "ping!") then
        FHS_SendMessage("pong!", UnitName("player"));
    elseif (tab[3]=="NoSeats") then
        FHS_Console_Feedback(string.format(L['%s has no seat available for you'], sender));
    elseif (tab[3]=="s") then
        FHS_Client_Sit(tonumber(tab[4]), tab[5], tonumber(tab[6]), tonumber(tab[7]))
    elseif (tab[3]=="st") then
        FHS_Client_Status_Update(tonumber(tab[4]), tab[5], tab[6], tab[7], tab[8])
    elseif (tab[3]=="b") then
        FHS_SelectPlayerButton(tonumber(tab[4]))
    elseif (tab[3]=="forceout") then
        FHS_Console_Feedback(L['You did not act in time. Press I\'m Back to continue playing.'])
        FHS_SitOutInClick()
    elseif (tab[3]=="round0") then  --PRE FLOP
        FHS_Client_Round0( tonumber(tab[4]) )
    elseif (tab[3]=="hole") then
        FHS_Client_Hole( tonumber(tab[4]), tonumber(tab[5]) )
    elseif (tab[3]=="deal") then
        FHS_Client_Deal( tonumber(tab[4]))
    elseif (tab[3]=="flop0") then
        FHS_Client_Flop0()
    elseif (tab[3]=="flop1") then
        FHS_Client_Flop1(tonumber(tab[4]), tonumber(tab[5]), tonumber(tab[6]))
    elseif (tab[3]=="turn") then
        Flop[4]=tonumber(tab[4]);
        FHS_SetCard(Flop[4],DealerX,DealerY, CardWidth*1,0,1,0,0,0)
    elseif (tab[3]=="river") then
        Flop[5]=tonumber(tab[4]);
        FHS_SetCard(Flop[5],DealerX,DealerY, CardWidth*2,0,1,0,0,0)
    elseif (tab[3]=="show") then
        FHS_Client_Show(tonumber(tab[4]), tonumber(tab[5]), tonumber(tab[6]), tab[7])
    elseif (tab[3]=="go") then
        local j=tonumber(tab[4])
        HighestBet=tonumber(tab[5])
        WhosTurn=j
        FHS_UpdateWhosTurn()
    elseif (tab[3]=="betsize") then
        Blinds=tonumber(tab[4])
        BetSize=Blinds			
    elseif (tab[3]=="seat") then
        FHS_StartClient();
    elseif (tab[3]=="inout") then
        FHS_Receive_InOut( tonumber(tab[4]), tab[5], sender)
    elseif (tab[3]=="q") then
        FHS_Receive_Quit( sender, tonumber(tab[4]))
    elseif (tab[3]=="showdown" and sender == UnitName("player")) then
        FHS_Receive_Showdown( tonumber(tab[4]), tab[5])
    end
end


function FHS_Receive_InOut(j, inout, sender)
    Seats[j].inout = inout;
    if (sender == UnitName("player") and inout=="OUT") then
        Seats[j].alpha = 0.5;
        Seats[j].status = "Sitting Out";
        FHS_UpdateSeat(j);
    end;
end;


function FHS_Receive_Showdown(j, status)
    FHS_HideAllButtons(false);
    FHS_Fold:SetText(L["Show Cards"]);
    Seats[5].dealt = 0;
    FHS_Status_Text:SetText(status);
    if (5 == j) then
        Seats[5].dealt = 0;
        FHS_Fold:SetText(L['Show Cards']);
        FHS_Fold:Show();
    end;
end;


function FHS_Receive_Quit(sender, j)
    if (sender == UnitName("player")) then
        Seats[j].seated = 0;
        Seats[j].HavePort = 0;
        if (IsPlaying(sender) == 1) then								
            FHS_UpdateSeat(j);
            FHS_Console_Feedback(Seats[j].name.." "..L['has left the table.']);
        end;
        if (j == 5) then			
            FHS_Console_Feedback(L['The dealer booted you.']);
            FHS_StopClient();
        end;
    end;
end;


function FHS_Client_Sit(j, name, chips, bet)
    Seats[j].seated = 1;
    Seats[j].name = name;
    Seats[j].chips = chips;
    Seats[j].bet = bet;
    FHS_UpdateSeat(j);
end;


function FHS_Client_Status_Update(j, chips, bet, status, alpha)
    Seats[j].chips = tonumber(chips);
    Seats[j].bet = tonumber(bet);
    Seats[j].status = status;
    Seats[j].alpha = alpha;
    FHS_UpdateSeat(j);
    FHS_TotalPot();
end;


function FHS_Client_Show(hole1, hole2, j, status)
    Seats[j].hole1 = hole1;
    Seats[j].hole2 = hole2;
    Seats[j].status = status;
    Seats[j].dealt = 0;
    FHS_SetCard(Seats[j].blank1, 0, 0, 0, 0, 0, 0, 0, 0);
    FHS_SetCard(Seats[j].blank2, 0, 0, 0, 0, 0, 0, 0, 0);
    FHS_SetCard(hole1, DealerX, DealerY, Seats[j].x, Seats[j].y, 1, 1, 0, 1);
    FHS_SetCard(hole2, DealerX, DealerY, Seats[j].x - 12, Seats[j].y + 12, 1, 1, 0, 0);
    FHS_UpdateSeat(j);
end;

                
function FHS_Client_Flop1(flop1, flop2, flop3)				
    Flop = {};
    Flop[1] = flop1;
    Flop[2] = flop2;
    Flop[3] = flop3;
    for i=1,3 do
        FHS_SetCard(Flop[i], DealerX, DealerY, -CardWidth * (3 - i), 0, 1, 1, 0, 0);
        if (getn(FlopBlank) > 0) then FHS_SetCard(FlopBlank[i], 0, 0, 0, 0, 0, 0, 0, 0); end;
    end;
    FlopBlank = {};
end;


function FHS_Client_Flop0()	
    for i=1,3 do
        FlopBlank[i] = BlankCard;
        FHS_SetCard(BlankCard, DealerX, DealerY, -CardWidth * (3 - i), 0, 1, CC * DealerDelay, 0, 0);
        BlankCard = BlankCard + 1;
        CC = CC - 1;
    end;
end;


function FHS_Client_Deal(j)
    Seats[j].blank1 = BlankCard;
    FHS_SetCard(BlankCard, DealerX, DealerY, Seats[j].x - 12, Seats[j].y + 12, 1, CC * DealerDelay, 0, 0);
    BlankCard = BlankCard + 1;
    CC = CC - 1;
    Seats[j].blank2 = BlankCard;
    FHS_SetCard(BlankCard, DealerX, DealerY, Seats[j].x, Seats[j].y, 1, CC * DealerDelay, 0, 1);
    BlankCard = BlankCard + 1;
    CC = CC - 1;
    Seats[j].dealt = 1;
    Seats[j].status = "Playing";
    Seats[j].alpha = 1;
    FHS_UpdateSeat(j);
end;


function FHS_Client_Hole( hole1, hole2)
    local ThisSeat = Seats[5];
    ThisSeat.hole1 = hole1;
    ThisSeat.hole2 = hole2;
    FHS_SetCard(hole2, DealerX, DealerY, ThisSeat.x - 12, ThisSeat.y + 12, 1, CC * DealerDelay, 0, 0);
    CC = CC - 1;
    FHS_SetCard(hole1, DealerX, DealerY, ThisSeat.x, ThisSeat.y, 1, CC * DealerDelay, 0, 1);
    CC = CC - 1;
    ThisSeat.status = L["Playing"];
    ThisSeat.dealt = 1;
    ThisSeat.alpha = 1;
    FHS_UpdateSeat(5);
    FHS_Fold:SetText(L["Fold"]);
    FHS_Fold:Show();
end;


function FHS_Client_Round0(thisRoundCount)
    FHS_HideAllButtons(true);
    FHS_ClearCards();
    RoundCount = thisRoundCount;
    for j=1,9 do
        Seats[j].bet = 0;
        if(Seats[j].inout=="OUT") then
            Seats[j].status = "Sitting Out";
            Seats[j].alpha = 0.5;
        else
            Seats[j].status = "";
            Seats[j].alpha = 0;
        end;
        FHS_UpdateSeat(j);
    end;
    BetSize = Blinds;
    FHS_TotalPot();
    FHS_Status_Text:SetText("");
end;


function IsPlaying(name)
    for j=1,9 do
        if (Seats[j].seated == 1 and Seats[j].name == name) then return 1; end;
    end;
    return 0;
end;


function FHS_SendMessage(msg, username)
    FHS_Debug_Feedback("addon whisper "..msg.." to "..username);
    SendAddonMessage("PokerLerduzz", "FHS_".. FHS_COMMS_version.."_"..msg, "WHISPER", username);
end;


function FHS_BroadcastMessage(msg, channel)
    -- "PARTY", "RAID", "GUILD", "BATTLEGROUND".
    FHS_Debug_Feedback("broadcast "..msg.." on "..channel);
    SendAddonMessage("PokerLerduzz", "FHS_".. FHS_COMMS_version.."_broadcast_"..msg, channel);
end;


function FHS_Console_Feedback(msg)
    DEFAULT_CHAT_FRAME:AddMessage(msg);
end;


function FHS_Debug_Feedback(msg)
    if (FHS_DEBUGING) then
        if DLAPI then
            DLAPI.DebugLog("WoWPokerLerduzz", msg);
        else
            DEFAULT_CHAT_FRAME:AddMessage(msg);
        end;
    end;
end;


function FHS_TotalPot()
    local total = 0;
    for j=1,9 do
        if (Seats[j].seated==1) then total = total + Seats[j].bet; end;
    end;
    if (total == 0) then
        FHS_Pot_Text:SetText(L['WoW Poker Lerduzz']);
    else
        FHS_Pot_Text:SetText(L['Total Pot']..": "..total);
    end;
    return total;
end;


function FHS_ShowCard(j, status)
    if ((Seats[j].seated==1)) then
        Seats[j].status=status;
        if ((Seats[j].hole1 == 0) or (Seats[j].hole2 == 0)) then return; end;
        FHS_SetCard(Seats[j].hole2, DealerX, DealerY, Seats[j].x - 12, Seats[j].y + 12, 1, 1, 0, 0);
        FHS_SetCard(Seats[j].hole1, DealerX, DealerY, Seats[j].x, Seats[j].y, 1, 1, 0, 1);
        FHS_UpdateSeat(j);
    end;
end;


function FHS_Set_BigBlindStart(value)
    if ( StartChips < value ) then value = StartChips; end;
    BigBlindStart = value;
    FHS_BigBlindStart = value;
end;


function FHS_SetBlindIncr(value)	
    value = tonumber(('%g'):format(value));
    BlindIncrease = value;
    FHS_BlindIncrease = value;
end;


function FHS_Set_StartChips(value)
    StartChips = value;
    FHS_StartChips = value;
    if ( StartChips < BigBlindStart ) then FHS_Set_BigBlindStart(value); end;
end;


function FHS_SetupOptionsPanel()
    PokerLerduzz_options_panel = LibStub("LibSimpleOptions-1.0").AddOptionsPanel(L['WoW Poker Lerduzz'],function()  end)

    local PokerLerduzz_Options_Minimap_toggle = PokerLerduzz_options_panel:MakeToggle(
        'name', L['Minimap Icon'],
        'description', L['Turn minimap icon on/off'],
        'default', true,
        'getFunc', function() return FHS_minimapIcon; end,
        'setFunc', function(value) FHS_Toggle_MiniMap(value); end
    );

    local PokerLerduzz_Options_Blind_slider = PokerLerduzz_options_panel:MakeSlider(
        'name', L['Starting Blind'],
        'description', L['Set the starting Blind'],
        'minText', '10',
        'maxText', ('%.0f'):format(StartChips),
        'minValue', 10,
        'maxValue', StartChips,
        'step', 10,
        'default', 20,
        'current', BigBlindStart,
        'setFunc', function(value) FHS_Set_BigBlindStart(value) end,
        'currentTextFunc', function(value) return ("%.0f"):format(value) end
    )

    local PokerLerduzz_Options_Increment_slider = PokerLerduzz_options_panel:MakeSlider(
        'name', L['Blind increase percent per round'],
        'description', L['Set the by what percent the Blind increases each round'],
        'minText', '0%',
        'maxText', '100%',
        'minValue', 0,
        'maxValue', 1,
        'step', 0.05,
        'default', 0.25,
        'current', BlindIncrease,
        'setFunc', function(value) FHS_SetBlindIncr(value) end,
        'currentTextFunc', function(value) return ("%.0f%%"):format(value*100) end
    )

    local PokerLerduzz_Options_Chips_slider = PokerLerduzz_options_panel:MakeSlider(
        'name', L['Starting Chips'],
        'description', L['Set the starting Chips'],
        'minText', '500',
        'maxText', '5000',
        'minValue', 500,
        'maxValue', 5000,
        'step', 100,
        'default', 500,
        'current', StartChips,
        'setFunc', function(value)
                FHS_Set_StartChips(value);
                PokerLerduzz_Options_Blind_slider:SetMinMaxValues(10, StartChips);
                _G[PokerLerduzz_Options_Blind_slider:GetName() .. "High"]:SetText(('%.0f'):format(StartChips))
                PokerLerduzz_options_panel:Refresh();
            end,
        'currentTextFunc', function(value) return ("%.0f"):format(value) end
    )

    local title, subText = PokerLerduzz_options_panel:MakeTitleTextAndSubText(
        L['WoW Poker Lerduzz Options'], 
        L['These options are saved between sessions']
    )

    PokerLerduzz_Options_Chips_slider:SetPoint("TOPLEFT", 50, -100)
    PokerLerduzz_Options_Blind_slider:SetPoint("TOPLEFT", 50, -175)
    PokerLerduzz_Options_Increment_slider:SetPoint("TOPLEFT", 50, -250)
    PokerLerduzz_Options_Minimap_toggle:SetPoint("TOPLEFT", 250, -100)	
end


function FHS_SetupXMLButtons()
    _G["FHS_Fold"]:SetText(L['Fold']);
    _G["FHS_Call"]:SetText(L['Call']);
    _G["FHS_AllIn"]:SetText(L['All In']);
    _G["FHS_Raise"]:SetText(L['Raise']);
    _G["FHS_Pot_Text"]:SetText(L['WoW Poker Lerduzz']);
end;
        

function FHS_Setup_LDB()
    if ( FHS_ldbIcon ) then
        FHS_LDBObject = ldb:NewDataObject(
            "WoWPokerLerduzz",
            {
                type = "data source",
                text = L['WoW Poker Lerduzz'],
                label = "WoWPokerLerduzz",
                icon = "interface\\addons\\wowpokerlerduzz\\textures\\mapicon",
                OnClick  = function(clickedframe, button) FHS_LauncherClicked(button); end,
                iconCoords = {0.25, .75, 0.25, .75},
            }
        );
    end;
    local f = CreateFrame("frame");
    f:SetScript("OnUpdate", function(self, elap) FHS_Hidden_frame_OnUpdate(self, elap); end);
end;

            
function FHS_SetupFrames()
    FHS_SetupTableFrame();
    FHS_SetupTopButtons();
    FHS_SetupButtonsFrame();
    FHS_SetupStatusFrame();
    FHS_SetupPotFrame();
    FHS_SetupSeatFrames();
    FHS_SetupCardFrames();
    FHS_SetupMiniMapButton();
    FHS_SetupAutoButtonsFrame();
end;


function FHS_SetupTableFrame()
    local tableFrame = CreateFrame("Frame", "FHSPokerFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate");
    tableFrame:Hide();
    tableFrame:SetMovable(true);
    tableFrame:EnableMouse();
    tableFrame:RegisterForDrag("LeftButton");
    tableFrame:SetScript("OnDragStart", tableFrame.StartMoving);
    tableFrame:SetScript("OnDragStop", tableFrame.StopMovingOrSizing);
    tableFrame:SetFrameStrata("TOOLTIP");
    
    tableFrame:SetScript("OnEvent",FHSPoker_OnEvent);

    tableFrame:SetScript("OnUpdate",function() FHSPoker_Update(arg1); end);
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
    tableFrame:SetHeight(627);
    tableFrame:SetPoint("CENTER",UIParent,"CENTER",0,0);
    
    local circleTexture = tableFrame:CreateTexture("FHS_CCirc", "OVERLAY");
    circleTexture:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\mesa");
    circleTexture:SetTexCoord(0, 1, 0, 1);
    circleTexture:SetWidth(1024);
    circleTexture:SetHeight(1024);
    circleTexture:SetPoint("TOPLEFT", tableFrame, "TOPLEFT", 0, 0)	
end


function FHS_Toggle_MiniMap(toggle)
    if ( toggle ) then
        minimapIcon = true;
        FHS_minimapIcon = true;
        FHSPoker_MapIconFrame:Show();
    else
        minimapIcon = false;
        FHS_minimapIcon = false;
        FHSPoker_MapIconFrame:Hide();
    end
end


function FHS_SetupMiniMapButton()
    local miniMapButton = CreateFrame("Button", "FHSPoker_MapIconFrame", Minimap)
    
    miniMapButton:SetFrameStrata("MEDIUM");
    miniMapButton:SetMovable(true);
    miniMapButton:EnableMouse(true);
    miniMapButton:SetWidth(32);miniMapButton:SetHeight(32);
    miniMapButton:SetPoint("TOPLEFT",Minimap,"TOPLEFT",-25,-80);
    
    local miniMapButtonTexture = miniMapButton:CreateTexture("FHSPoker_MapIcon", "BACKGROUND")
    
    miniMapButtonTexture:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\mapicon");
    miniMapButtonTexture:SetWidth(32);miniMapButtonTexture:SetHeight(32);
    miniMapButtonTexture:SetPoint("CENTER",miniMapButton,"CENTER",0,0);
    
    miniMapButton:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight","ADD");
    
    miniMapButton:SetScript("OnLoad",function() this:RegisterForClicks("LeftButtonUp","RightButtonUp"); this:RegisterForDrag("RightButton"); end);
    miniMapButton:SetScript("OnMouseDown",function(self, button) if (button=="RightButton") then FHS_DraggingIcon = 1; self:StartMoving() end end);
    miniMapButton:SetScript("OnMouseUp",function(self, button) if (button=="RightButton") then FHS_DraggingIcon = 0; self:StopMovingOrSizing() end end);
    miniMapButton:SetScript("OnClick",function(self, button, down) FHS_LauncherClicked(button); end);

    if ( not minimapIcon ) then
        FHSPoker_MapIconFrame:Hide();
    end
end


function FHS_SetupTopButtons()
    local minimizeButton = CreateFrame("Button", "FHSPoker_MinimizeButton", FHSPokerFrame);
    minimizeButton:SetHeight(32);
    minimizeButton:SetWidth(32);
    minimizeButton:SetPoint("CENTER", FHSPokerFrame, "CENTER", -18, 217);	
    local minimizeIconButton = minimizeButton:CreateTexture("FHSPoker_MinimizeIcon", "BACKGROUND")
    minimizeIconButton:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\botones\\minimizar");
    minimizeIconButton:SetHeight(32);
    minimizeIconButton:SetWidth(32);
    minimizeIconButton:SetPoint("CENTER", minimizeButton, "CENTER", 0, 0);	
    minimizeButton:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight","ADD");	
    minimizeButton:SetScript("OnClick", function() FHSPokerFrame:Hide(); end);

    local setSizeButton = CreateFrame("Button", "FHSPoker_SetSizeButton", FHSPokerFrame);
    setSizeButton:SetHeight(32);
    setSizeButton:SetWidth(32);
    setSizeButton:SetPoint("CENTER", FHSPokerFrame, "CENTER", 0, 217);	
    local setSizeIconButton = setSizeButton:CreateTexture("FHSPoker_SetSizeIcon", "BACKGROUND")
    setSizeIconButton:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\botones\\maximizar");
    setSizeIconButton:SetHeight(32);
    setSizeIconButton:SetWidth(32);
    setSizeIconButton:SetPoint("CENTER", setSizeButton, "CENTER", 0, 0);	
    setSizeButton:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", "ADD");	
    setSizeButton:SetScript("OnClick", function() FHS_SizeClick(); end);
    
    local closeButton = CreateFrame("Button", "FHSPoker_CloseButton", FHSPokerFrame);
    closeButton:SetHeight(32);
    closeButton:SetWidth(32);
    closeButton:SetPoint("CENTER", FHSPokerFrame, "CENTER", 18, 217);	
    local closeIconButton = closeButton:CreateTexture("FHSPoker_CloseIcon", "BACKGROUND")
    closeIconButton:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\botones\\cerrar");
    closeIconButton:SetHeight(32);
    closeIconButton:SetWidth(32);
    closeIconButton:SetPoint("CENTER", closeButton, "CENTER", 0, 0);	
    closeButton:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", "ADD");	
    closeButton:SetScript("OnClick", function() FHS_QuitClick(); end);

    local sitInOutButton = CreateFrame("Button", "FHSPoker_SitInOutButton", FHSPokerFrame);
    sitInOutButton:SetHeight(32);
    sitInOutButton:SetWidth(32);
    sitInOutButton:SetPoint("CENTER", FHSPokerFrame, "CENTER", 36, 217);	
    local sitInOutIconButton = sitInOutButton:CreateTexture("FHSPoker_SitInOutIcon", "BACKGROUND")
    sitInOutIconButton:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\botones\\pararse");
    sitInOutIconButton:SetHeight(32);
    sitInOutIconButton:SetWidth(32);
    sitInOutIconButton:SetPoint("CENTER", sitInOutButton, "CENTER", 0, 0);	
    sitInOutButton:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", "ADD");	
    sitInOutButton:SetScript("OnClick", function() FHS_SitOutInClick(); end);
end


function FHS_SetupButtonsFrame()	
    local buttonsFrame = CreateFrame("Frame", "FHS_Buttons", FHSPokerFrame, BackdropTemplateMixin and "BackdropTemplate");
    buttonsFrame:SetHeight(30);
    buttonsFrame:SetWidth(540);
    buttonsFrame:SetPoint("CENTER", FHSPokerFrame, "CENTER", 0, -183);
    buttonsFrame:SetBackdrop( { 
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", 
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = false, tileSize = 16, edgeSize = 16, 
        insets = { left = 5, right = 5, top = 5, bottom = 5 }
    });
    buttonsFrame:SetBackdropColor(0, 0, 0, .5);
    
    local foldButton = CreateFrame("Button", "FHS_Fold", buttonsFrame, "UIPanelButtonTemplate");
    foldButton:Hide();
    foldButton:SetHeight(20);
    foldButton:SetWidth(120);
    foldButton:SetPoint("CENTER", buttonsFrame, "CENTER", -205, 0)
    foldButton:SetScript("OnClick", function() FHS_FoldClick(); end);
    
    local callButton = CreateFrame("Button", "FHS_Call", buttonsFrame, "UIPanelButtonTemplate");
    callButton:Hide();
    callButton:SetHeight(20);
    callButton:SetWidth(120);
    callButton:SetPoint("CENTER", buttonsFrame, "CENTER", -80, 0)
    callButton:SetScript("OnClick", function() FHS_CallClick(); end);
    
    local raiseButton = CreateFrame("Button", "FHS_Raise", buttonsFrame, "UIPanelButtonTemplate");
    raiseButton:Hide();
    raiseButton:SetHeight(20);
    raiseButton:SetWidth(120);
    raiseButton:SetPoint("CENTER", buttonsFrame, "CENTER", 45, 0)
    raiseButton:SetScript("OnClick", function() FHS_RaiseClick(); end);
    
    local lowerButton = CreateFrame("Button", "FHS_Raise_Lower", buttonsFrame, "UIPanelButtonTemplate");
    lowerButton:Hide();
    lowerButton:SetText("-");
    lowerButton:SetHeight(20);
    lowerButton:SetWidth(20);
    lowerButton:SetPoint("CENTER", buttonsFrame, "CENTER", 115, 0)
    lowerButton:SetScript("OnClick", function() FHS_RaiseChange(-1); end);
    
    local higherButton = CreateFrame("Button", "FHS_Raise_Higher", buttonsFrame, "UIPanelButtonTemplate");
    higherButton:Hide();
    higherButton:SetText("+");
    higherButton:SetHeight(20);
    higherButton:SetWidth(20);
    higherButton:SetPoint("CENTER", buttonsFrame, "CENTER", 135, 0)
    higherButton:SetScript("OnClick", function() FHS_RaiseChange(1); end);

    local allInButton = CreateFrame("Button", "FHS_AllIn", buttonsFrame, "UIPanelButtonTemplate");
    allInButton:Hide();
    allInButton:SetText(L['All In']);
    allInButton:SetHeight(20);
    allInButton:SetWidth(120);
    allInButton:SetPoint("CENTER", buttonsFrame, "CENTER", 205, 0)
    allInButton:SetScript("OnClick", function() FHS_AllInClick(); end);
end


function FHS_SetupAutoButtonsFrame()
    local autoButtonsFrame = CreateFrame("Frame", "FHS_AutoButtons", FHSPokerFrame, BackdropTemplateMixin and "BackdropTemplate");
    autoButtonsFrame:SetHeight(40);
    autoButtonsFrame:SetWidth(245);
    autoButtonsFrame:SetPoint("CENTER", FHSPokerFrame, "CENTER", 0, 177);
    autoButtonsFrame:SetBackdrop( { 
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", 
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = false, tileSize = 16, edgeSize = 16, 
        insets = { left = 5, right = 5, top = 5, bottom = 5 }
    });
    autoButtonsFrame:SetBackdropColor(0, 0, 0, 0.5);
    
    local AutoText = autoButtonsFrame:CreateFontString("FHS_AutoText", "BACKGROUND", "GameTooltipText");
    AutoText:SetText(L['Autoplay']);
    AutoText:SetPoint("TOPLEFT", autoButtonsFrame, "TOPLEFT", 7, -6);
    
    local AutoStickyCheck = CreateFrame("CheckButton", "FHS_AutoStickyCheck", autoButtonsFrame, "UICheckButtonTemplate");
    AutoStickyCheck:SetHeight(15);
    AutoStickyCheck:SetWidth(15);
    AutoStickyCheck:SetPoint("TOPRIGHT", autoButtonsFrame, "TOPRIGHT", -8, -6)
    local AutoStickyText = autoButtonsFrame:CreateFontString("FHS_AutoStickyText", "BACKGROUND", "GameTooltipText");
    AutoStickyText:SetText(L['Sticky']);
    AutoStickyText:SetPoint("TOPRIGHT", AutoStickyCheck, "TOPLEFT", -1, 0);
    
    local AutoBetCheck = CreateFrame("CheckButton", "FHS_AutoBetCheck", autoButtonsFrame, "UICheckButtonTemplate");
    AutoBetCheck:SetHeight(15);AutoBetCheck:SetWidth(15);
    AutoBetCheck:SetPoint("BOTTOMRIGHT",autoButtonsFrame, "BOTTOMRIGHT", -145, 6)
    AutoBetCheck:SetScript("OnClick",function() if ( FHS_AutoBetCheck:GetChecked() )then FHS_AutoFoldCheck:SetChecked(false); FHS_AutoCheckCheck:SetChecked(false); end; end);
    local AutoBetText = autoButtonsFrame:CreateFontString("FHS_AutoBetText","BACKGROUND","GameTooltipText");
    AutoBetText:SetText(L['Call any']);
    AutoBetText:SetPoint("TOPRIGHT", AutoBetCheck, "TOPLEFT", -1, 0);
    
    local AutoFoldCheck = CreateFrame("CheckButton", "FHS_AutoFoldCheck", autoButtonsFrame, "UICheckButtonTemplate");
    AutoFoldCheck:SetHeight(15);
    AutoFoldCheck:SetWidth(15);
    AutoFoldCheck:SetPoint("BOTTOMRIGHT", autoButtonsFrame, "BOTTOMRIGHT", -70, 6)
    AutoFoldCheck:SetScript("OnClick",function() if ( FHS_AutoFoldCheck:GetChecked() )then FHS_AutoBetCheck:SetChecked(false); FHS_AutoCheckCheck:SetChecked(false); end; end);
    local AutoFoldText = autoButtonsFrame:CreateFontString("FHS_AutoFoldText", "BACKGROUND", "GameTooltipText");
    AutoFoldText:SetText(L['Fold']);
    AutoFoldText:SetPoint("TOPRIGHT", AutoFoldCheck, "TOPLEFT", -1, 0);
    
    local AutoCheckCheck = CreateFrame("CheckButton", "FHS_AutoCheckCheck", autoButtonsFrame, "UICheckButtonTemplate");
    AutoCheckCheck:SetHeight(15);
    AutoCheckCheck:SetWidth(15);
    AutoCheckCheck:SetPoint("BOTTOMRIGHT", autoButtonsFrame, "BOTTOMRIGHT", -8, 6)
    AutoCheckCheck:SetScript("OnClick",function() if ( FHS_AutoCheckCheck:GetChecked() )then FHS_AutoFoldCheck:SetChecked(false); FHS_AutoBetCheck:SetChecked(false); end; end);
    local AutoCheckText = autoButtonsFrame:CreateFontString("FHS_AutoCheckText", "BACKGROUND", "GameTooltipText");
    AutoCheckText:SetText(L['Check']);
    AutoCheckText:SetPoint("TOPRIGHT", AutoCheckCheck, "TOPLEFT", -1, 0);
end


function FHS_SetupPotFrame()
    local potFrame = CreateFrame("Frame", "FHS_Pot", FHSPokerFrame, BackdropTemplateMixin and "BackdropTemplate");
    potFrame:SetHeight(30);
    potFrame:SetWidth(180);
    potFrame:SetPoint("CENTER", FHSPokerFrame, "CENTER", 0, 135);
    potFrame:SetBackdrop( { 
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", 
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = false, tileSize = 16, edgeSize = 16, 
        insets = { left = 5, right = 5, top = 5, bottom = 5 }
    });
    potFrame:SetBackdropColor(0, 0, 0, .5);
    local potFrameString = potFrame:CreateFontString("FHS_Pot_Text", "BACKGROUND", "GameTooltipText");
    potFrameString:SetPoint("CENTER", potFrame, "CENTER", 0, 2);

end


function FHS_SetupStatusFrame()
    local statusFrame = CreateFrame("Frame", "FHS_Status", FHSPokerFrame, BackdropTemplateMixin and "BackdropTemplate");
    statusFrame:SetHeight(30);
    statusFrame:SetWidth(340);
    statusFrame:SetPoint("CENTER", FHSPokerFrame, "CENTER", 0, 85);
    statusFrame:SetBackdrop( { 
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", 
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = false, tileSize = 16, edgeSize = 16, 
        insets = { left = 5, right = 5, top = 5, bottom = 5 }
    });
    -- alpha appears to have changed from 0-255 to 0-1 a while back, but in API 10 it started erroring
    statusFrame:SetBackdropColor(0,0,0,0.5);
    local statusFrameString = statusFrame:CreateFontString("FHS_Status_Text","BACKGROUND","GameTooltipText");
    statusFrameString:SetPoint("CENTER",statusFrame,"CENTER",0,2);
end
    

function FHS_SetupSeatFrames()
    local seatFrame;
    local seatlocations =
    {
        {x=219,  y=296},
        {x=441,  y=201},
        {x=450,  y=-190},
        {x=220,  y=-295},
        {x=2,    y=-295},
        {x=-220, y=-295},
        {x=-435, y=-201},
        {x=-445, y=193},
        {x=-220, y=296},
    }	
    
    for seat=1,9 do
        seatFrame = CreateFrame("Frame", "FHS_Seat_"..seat, FHSPokerFrame, BackdropTemplateMixin and "BackdropTemplate");
        seatFrame:SetHeight(35);
        seatFrame:SetWidth(175);
        seatFrame:SetPoint("CENTER", FHSPokerFrame, "CENTER", seatlocations[seat].x, seatlocations[seat].y);
        seatFrame:SetBackdrop({ 
            bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", 
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            tile = false, tileSize = 16, edgeSize = 16, 
            insets = { left = 5, right = 5, top = 5, bottom = 5 }
        });
        seatFrame:SetBackdropColor(0, 0, 0,.5);

        local seatFrameButton = seatFrame:CreateTexture(seatFrame:GetName().."_Button", "BACKGROUND");
        seatFrameButton:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\boton");
        seatFrameButton:Hide();
        seatFrameButton:SetWidth(12);
        seatFrameButton:SetHeight(12);
        seatFrameButton:SetTexCoord(0, 1, 0, 1);
        seatFrameButton:SetPoint("CENTER", seatFrame, "CENTER", -73, -6);

        local seatFrameName = seatFrame:CreateFontString(seatFrame:GetName().."_Name", "BACKGROUND", "GameTooltipTextSmall");
        seatFrameName:SetPoint("TOPLEFT", seatFrame, "CENTER", -80, 12);
        
        local seatFrameChips = seatFrame:CreateFontString(seatFrame:GetName().."_Chips", "BACKGROUND", "GameTooltipTextSmall");
        seatFrameChips:SetPoint("TOPRIGHT", seatFrame, "CENTER", 80, 12);
        
        local seatFrameStatus = seatFrame:CreateFontString(seatFrame:GetName().."_Status", "BACKGROUND", "GameTooltipTextSmall");
        seatFrameStatus:SetPoint("BOTTOMRIGHT", seatFrame, "CENTER", 80, -10);
        
        local seatFramePort = seatFrame:CreateTexture(seatFrame:GetName().."_Port", "BACKGROUND");
        seatFramePort:SetWidth(60);
        seatFramePort:SetHeight(60);
        seatFramePort:SetTexCoord(0, 1, 0, 1);
        if seat > 2 and seat < 8 then
            seatFramePort:SetPoint("CENTER", seatFrame, "CENTER", 0, 55);
        else
            seatFramePort:SetPoint("CENTER", seatFrame, "CENTER", 0, -52);
        end
        
        local seatFramePortWho = seatFrame:CreateTexture(seatFrame:GetName().."_PortWho", "BACKGROUND");
        seatFramePortWho:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\unknown");
        seatFramePortWho:SetWidth(60);
        seatFramePortWho:SetHeight(60);
        seatFramePortWho:SetTexCoord(0, 1, 0, 1);
        if seat > 2 and seat < 8 then
            seatFramePortWho:SetPoint("CENTER", seatFrame, "CENTER", 0, 55);
        else
            seatFramePortWho:SetPoint("CENTER", seatFrame, "CENTER", 0, -52);
        end
        
        local seatFrameRing = seatFrame:CreateTexture(seatFrame:GetName().."_Ring", "BORDER");
        seatFrameRing:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\ring");
        seatFrameRing:SetWidth(128);
        seatFrameRing:SetHeight(128);
        seatFrameRing:SetTexCoord(0, 1, 0, 1);
        if seat > 2 and seat < 8 then
            seatFrameRing:SetPoint("CENTER", seatFrame, "CENTER", 16, 33);
        else
            seatFrameRing:SetPoint("CENTER", seatFrame, "CENTER", 16, -74);
        end
        
        local seatFrameRingSelect = seatFrame:CreateTexture(seatFrame:GetName().."_RingSelect", "BORDER");
        seatFrameRingSelect:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\ring_select");
        seatFrameRingSelect:Hide();
        seatFrameRingSelect:SetWidth(128);
        seatFrameRingSelect:SetHeight(128);
        seatFrameRingSelect:SetTexCoord(0, 1, 0, 1);
        if seat > 2 and seat < 8 then
            seatFrameRingSelect:SetPoint("CENTER", seatFrame, "CENTER", 16, 33);
        else
            seatFrameRingSelect:SetPoint("CENTER", seatFrame, "CENTER", 16, -74);
        end
    end
end		


function FHS_SetupCardFrames()
    local cardFrame
    local thiscard
    
    cardFrame = CreateFrame("Frame", "FHS_CardFrame", FHSPokerFrame);
    cardFrame:SetHeight(560);
    cardFrame:SetWidth(860);
    cardFrame:SetPoint("CENTER", nil, nil, -330, 220);

    for card=0,12 do
        -- Picas
        thiscard = cardFrame:CreateTexture("FHS_Card_C"..card, "ARTWORK");
        thiscard:SetHeight(128);
        thiscard:SetWidth(128);
        thiscard:SetPoint("CENTER", nil, nil);
        thiscard:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\cartas\\picas\\"..card);
        
        -- Diamantes
        thiscard = cardFrame:CreateTexture("FHS_Card_D"..card, "ARTWORK");
        thiscard:SetHeight(128);
        thiscard:SetWidth(128);
        thiscard:SetPoint("CENTER", nil, nil);
        thiscard:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\cartas\\diamantes\\"..card);
        
        -- Corazones
        thiscard = cardFrame:CreateTexture("FHS_Card_H"..card, "ARTWORK");
        thiscard:SetHeight(128);
        thiscard:SetWidth(128);
        thiscard:SetPoint("CENTER", nil, nil);
        thiscard:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\cartas\\corazones\\"..card);
        
        -- Trevoles
        thiscard = cardFrame:CreateTexture("FHS_Card_S"..card, "ARTWORK");
        thiscard:SetHeight(128);
        thiscard:SetWidth(128);
        thiscard:SetPoint("CENTER", nil, nil);
        thiscard:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\cartas\\trevoles\\"..card);
        
    end
    
    -- Reverso de cartas
    for card=1,23 do
        thiscard = cardFrame:CreateTexture("FHS_Blank_"..card, "ARTWORK");
        thiscard:SetHeight(128);
        thiscard:SetWidth(128);
        thiscard:SetPoint("CENTER", nil, nil);
        thiscard:SetTexture("interface\\addons\\wowpokerlerduzz\\textures\\cartas\\reverso")
    end
end

FHSPoker_OnLoad();
