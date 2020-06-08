--Networking
function OpenModem()
    local lstSides = {"left","right","top","bottom","front","back"};
    for i, side in pairs(lstSides) do
      if (peripheral.isPresent(side)) then
       if (peripheral.getType(side) == string.lower("modem")) then
           rednet.open(side)
        end
      end
    end
  end--end function
 
--Table handler
function CheckTable(Table1, CompareData)
    var1 = false
    if #Table1 > 0 then
        for i=1, #Table1 do
            if Table1[i] ~= nil then
                if Table1[i].."" == ""..CompareData then
                    return true
                end
            end
            i=i + 1
        end
    end
    return var1
end--end function
function RemoveFromTable(Table1, RemoveData)
    NewTable = {}
    if #Table1 > 0 then
        for i=1, #Table1 do
            if Table1[i] ~= nil then
                if Table1[i].."" == ""..RemoveData then
                    table.remove(Table1, i)
                end
            end
            i=i + 1
        end
    end
end--end function
function Add2Table(Table1, Data1)
    table.insert(Table1, Data1)
end--end function




--Starting program
function bootstrap()
    OpenModem()
end--end function
bootstrap()