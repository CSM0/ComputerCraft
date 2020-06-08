--[[
Coded my Mac .G
https://leancoding.co/YS60ML
MacFireFly2600
]]--



--Vars
local Value1 = true;
local ProtocolName = "Powergrid";
--Networking
function OpenModem()
    local lstSides = {"left","right","top","bottom","front","back"};
    for i, side in pairs(lstSides) do
      if (peripheral.isPresent(side)) then
       if (peripheral.getType(side) == string.lower("modem")) then
           rednet.open(side);
        end
      end
    end
end--end function
function SocksListener()
    while true do
        ClientID, ClientMsg, protocol = rednet.receive()
        if protcol ~= nil then
            if protcol == ProtocolName then
                if string.find(ClientMsg, "|") then
                    if sep == nil then
                        sep = "|";
                    end
                    sep = tostring(sep)
                    local t={} ; i=1;
                    for str in string.gmatch(ClientMsg, "([^"..sep.."]+)") do
                        t[i] = str;
                        i = i + 1;
                    end
                    if string.lower(t[1])=="ping" then --|ping|
                        rednet.send(ClientID, "|pong|", ProtocolName);
                    elseif string.lower(t[1])=="enable" then --|enable|
                        EnableRS();
                        Value1 = true;
                        UpdateConfig();
                    elseif string.lower(t[1])=="disable" then --|disable|
                        DisableRS();
                        Value1 = false;
                        UpdateConfig();
                    elseif string.lower(t[1])=="toggle" then --|toggle|
                        if Value1 == true then
                            DisableRS();
                            Value1 = false;
                            UpdateConfig();
                        else
                            EnableRS();
                            Value1 = true;
                            UpdateConfig();
                        end--end if
                    end--end if
                end--end if
            end--end if
        end--end if
    end--end while
end--end function

--Redstone
function EnableRS()
    local lstSides = {"left","right","top","bottom","front","back"};
    for i, side in pairs(lstSides) do
        redstone.setOutput(side, true);
    end--end for
end--end if
function DisableRS()
    local lstSides = {"left","right","top","bottom","front","back"};
    for i, side in pairs(lstSides) do
        redstone.setOutput(side, false);
    end--end for
end--end if

--Configuring
function CheckConfig()
    if fs.exists("settings.conf") then
        LoadConfig();
    else
        CreateConfig();
    end
end--end function
function CreateConfig()
    local f1 = fs.open("settings.conf","w");
    f1.writeLine("false");
    f1.flush();
    f1.close();
end--end function
function UpdateConfig()
    local f1 = fs.open("settings.conf","w");
    f1.writeLine(tostring(Value1));
    f1.flush();
    f1.close();
end--end function
function LoadConfig()
    local f1 = io.open("settings.conf","r");
    if f1 then
        for line in f1:lines() do
            if string.lower(line)=="true" then
                Value1 = true;
            else
                Value1 = false;
            end--end if
        end--end for
    end--end if
end--end function
 

--Table handler
function CheckTable(Table1, CompareData)
    var1 = false;
    if #Table1 > 0 then
        for i=1, #Table1 do
            if Table1[i] ~= nil then
                if Table1[i].."" == ""..CompareData then
                    return true;
                end
            end
            i=i + 1;
        end
    end
    return var1;
end--end function
function RemoveFromTable(Table1, RemoveData)
    NewTable = {};
    if #Table1 > 0 then
        for i=1, #Table1 do
            if Table1[i] ~= nil then
                if Table1[i].."" == ""..RemoveData then
                    table.remove(Table1, i);
                end
            end
            i=i + 1;
        end
    end
end--end function
function Add2Table(Table1, Data1)
    table.insert(Table1, Data1);
end--end function


--Starting program
function bootstrap()
    OpenModem();
    CheckConfig();
    SocksListener();
end--end function
bootstrap();