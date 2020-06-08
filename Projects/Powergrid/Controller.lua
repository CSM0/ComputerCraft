--[[
Coded by Mac .G
https://leancoding.co/YS60ML
MacFireFly2600
Version: 1.0
]]--

--Vars
local ProtocolName = "Powergrid";

local ArrayIn1 = 306;
local ArrayIn2 = 304;
local ArrayIn3 = 305;
local ArrayIn4 = 307;
local ArrayIn5 = 308;
local ArrayIn6 = 309;

local ArrayOut1 = 300;
local ArrayOut2 = 288;
local ArrayOut3 = 292;
local ArrayOut4 = 301;
local ArrayOut5 = 303;


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
 
--Menus
function MainMenu()
    --https://soundcloud.com/queed-inc/sets/unstable
    while true do
        term.setCursorPos(1,1);
        term.clear();
        print("+=====Power Grid=====+");
        print("|        Home        |");
        print("+--------------------+");
        print("");
        print("1. Direct");
        print("2. Battery Arrays");
        print("3. Exit");
        print("4. Clear Screen")
        local RawData = io.read();
        if RawData == "1" then
            --GOTO Direct
            DirectPower(); --TODO
        elseif RawData == "2" then
            --GOTO BatteryArrays
            BatteryArrays(); --DONE
        elseif RawData == "3" then
            break;
        elseif RawData == "4" then
        else
            print("Unknown command");
            print("Press any key to continue");
            os.pullEvent("key");
        end--end if
    end--end while
end--end function

function DirectPower()
    while true do
        term.setCursorPos(1,1)
        term.clear()
        print("+=====Power Grid=====+");
        print("|       Direct       |");
        print("+--------------------+");
        print("");
        print("1. Send to power base");
        print("2. Send to machines");
        print("3. Return");
        print("4. Clear Screen")
        local RawData = io.read();
        if RawData == "1" then
            --Rednet Send to powerbase
            --TODO
        elseif RawData == "2" then
            --Rednet Send to machines
            --TODO
        elseif RawData == "3" then
            break;
        elseif RawData == "4" then
        else
            print("Unknown command");
            print("Press any key to continue");
            os.pullEvent("key");
        end--end if
    end--end while
end--end function

function BatteryArrays()
    while true do
        term.setCursorPos(1,1)
        term.clear()
        print("+=====Power Grid=====+");
        print("|       Arrays       |");
        print("+--------------------+");
        print("");
        print("1. Power Input");
        print("2. Power Output");
        print("3. Return");
        print("4. Clear Screen")
        local RawData = io.read();
        if RawData == "1" then
            --GOTO PowerInput
            PowerInputsOutputs(true); --DONE
        elseif RawData == "2" then
            --GOTO PowerOutput
            PowerInputsOutputs(false); --DONE
        elseif RawData == "3" then
            break;
        elseif RawData == "4" then
        else
            print("Unknown command");
            print("Press any key to continue");
            os.pullEvent("key");
        end--end if
    end--end while
end--End function

function PowerInputsOutputs(bool1)
    while true do
        term.setCursorPos(1,1)
        term.clear()
        print("+=====Power Grid=====+");
        if bool1 then
            print("|       Inputs       |");
        else
            print("|      Outputs       |");
        end--end if
        print("+--------------------+");
        print("");
        print("1. Array1");
        print("2. Array2");
        print("3. Array3");
        print("4. Array4");
        print("5. Array5");
        print("6. Array6");
        print("7. All Arrays");
        print("8. Return");
        print("9. Clear Screen")
        local RawData = io.read();
        if RawData == "1" then
            --GOTO SetArrayInput
            SetArray(1, bool1);
        elseif RawData == "2" then
            --GOTO SetArrayInput
            SetArray(2, bool1);
        elseif RawData == "3" then
            --GOTO SetArrayInput
            SetArray(3, bool1);
        elseif RawData == "4" then
            --GOTO SetArrayInput
            SetArray(4, bool1);
        elseif RawData == "5" then
            --GOTO SetArrayInput
            SetArray(5, bool1);
        elseif RawData == "6" then
            --GOTO SetArrayInput
            SetArray(6, bool1);
        elseif RawData == "7" then
            SetArray(0, bool1);
        elseif RawData == "8" then
            break;
        elseif RawData == "9" then
        else
            print("Unknown command");
            print("Press any key to continue");
            os.pullEvent("key");
        end--end if
    end--end while
end--end function

function SetArray(Num, bool)
    while true do
        term.setCursorPos(1,1)
        term.clear()
        print("+=====Power Grid=====+");        
        if bool then
            if Num == 0 then
                print("|  Array All Inputs  |");
            else
                print("|    Array"..Num.." Input    |");
            end--end if
        else
            if Num == 0 then
                print("| Array All Outputs  |");
            else
                print("|    Array"..Num.." Output   |");
            end--end if
        end--end if
        print("+--------------------+");
        print("");
        print("1. Enable");
        print("2. Disable");
        print("3. Return");
        local RawData = io.read();
        if RawData == "1" then
            --GOTO Enable
            if Num == 0 then
                for i=1,6 do
                    rednet.send(GetID(bool, i), "|enable|", ProtocolName);
                end--end for
            else
                rednet.send(GetID(bool, Num), "|enable|", ProtocolName);
            end
        elseif RawData == "2" then
            --GOTO Disable
            if Num == 0 then
                for i=1,6 do
                    rednet.send(GetID(bool, i), "|disable|", ProtocolName);
                end--end for
            else
                rednet.send(GetID(bool, Num), "|disable|", ProtocolName);
            end
        elseif RawData == "3" then
            break;
        else
            print("Unknown command");
            print("Press any key to continue");
            os.pullEvent("key");
        end--end if

    end--end while
end--end function



function GetID(bool, int1)
    --Input Arrays
    if int1 == 1 then
        if bool == true then
            return ArrayIn1;
        else
            return ArrayOut1;
        end--end if
    elseif int1 == 2 then
        if bool == true then
            return ArrayIn2;
        else
            return ArrayOut2;
        end--end if
    elseif int1 == 3 then
        if bool == true then
            return ArrayIn3;
        else
            return ArrayOut3;
        end--end if
    elseif int1 == 4 then
        if bool == true then
            return ArrayIn4;
        else
            return ArrayOut4;
        end--end if
    elseif int1 == 5 then
        if bool == true then
            return ArrayIn5;
        else
            return ArrayOut5;
        end--end if
    elseif int1 == 6 then
        if bool == true then
            return ArrayIn6;
        else
            return ArrayOut6;
        end--end if
    end--end if
end--end function
--Starting program
function bootstrap()
    OpenModem();
    MainMenu();
end--end function
bootstrap();