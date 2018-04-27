szVulanLib = system.GetScriptFolder() .. "\\LIB\\VulanLib.lua"
IncludeFile(szVulanLib)
globalTime = os.clock()
timeSuDoThiep = os.clock()
function useTHP()
  tbVulanLib.UseItemName("Th\199n H\181nh Ph\239")
end
function clickMenu(_ARG_0_)
  echo("\167\183 ch\228n: " .. menu.GetText(getMenuType(), _ARG_0_))
  menu.ClickIndex(getMenuType(), _ARG_0_)
end
function clickMenuNext(_ARG_0_)
  clickMenu(_ARG_0_)
  tbVulanLib.WaitMenuTimeOut(getMenuType(), 3)
end
function getMenuType()
  if menu.GetText(1, 0) == "" then
    return 0
  end
  return 1
end
function clickText(_ARG_0_)
  echo("\167\183 ch\228n: " .. _ARG_0_)
  menu.ClickText(nType, _ARG_0_)
end
function x2_sudothiep()
  if player.GetLevel() > 79 then
    return
  end
  if os.clock() - timeSuDoThiep < 30 then
    return
  end
  if player.IsFightMode() == 0 then
    return
  end
  if player.IsActiveState(76) == 1 then
    return
  end
  timeSuDoThiep = os.clock()
  echo("B\203t " .. szSuDoThiep)
  tbVulanLib.UseItemName(szSuDoThiep)
  echo("B\203t " .. szSuDoThiep .. " k\213t th\243c")
end
function check_state()
  for _FORV_3_ = 1, 500 do
    if player.IsActiveState(_FORV_3_) == 1 then
      system.Print(_FORV_3_)
    end
  end
end
function echo(_ARG_0_)
  system.Print(_ARG_0_)
end
function bat_heal()
  if player.GetMana() > 50 then
    return
  end
  if player.GetLevel() > 80 then
    return
  end
  echo("Nh\203n v\223ng s\184ng")
  tbVulanLib.UseItemName("C\200m nang \174\229ng h\181nh")
  tbVulanLib.WaitMenuTimeOut(0, 2)
  clickMenu(0, 0)
end
function checkVar(_ARG_0_)
  for _FORV_4_, _FORV_5_ in pairs(_ARG_0_) do
    echo(_FORV_4_)
  end
end
function getFreeHanhTrang(_ARG_0_)
  for _FORV_5_ = 0, 255 do
    if item.GetPos(_FORV_5_) == 3 then
      nWidth, nHeight = item.GetSize(item.GetPos(_FORV_5_))
    end
  end
  if _ARG_0_ then
    _ARG_0_("H\181nh trang c\223n tr\232ng: " .. 60 - nWidth * nHeight .. " ch\231")
  end
  return 60 - nWidth * nHeight
end
function box(_ARG_0_)
  system.MessageBox(_ARG_0_)
end
function checkNPC1(_ARG_0_, _ARG_1_)
end
function checkNPC()
  for _FORV_3_ = 0, 255 do
    if npc.IsExists(_FORV_3_) and 0 < string.len(npc.GetName(_FORV_3_)) then
      echo(npc.GetName(_FORV_3_) .. " kind: " .. npc.GetKind(_FORV_3_) .. " len:" .. string.len(npc.GetName(_FORV_3_)))
    end
  end
end
function showNpc()
  for _FORV_3_ = 0, 255 do
    if npc.GetKind(_FORV_3_) == 0 and npc.IsExists(_FORV_3_) and 0 < string.len(npc.GetName(_FORV_3_)) then
      echo(npc.GetName(_FORV_3_) .. " h\214 th\230 " .. npc.GetLife(_FORV_3_))
    end
  end
end
function writeNpcName()
  for _FORV_4_ = 0, 255 do
    if npc.GetKind(_FORV_4_) == 3 and npc.IsExists(_FORV_4_) and 0 < string.len(npc.GetName(_FORV_4_)) then
      io.open("E:/Games/vlTranhBa/auto/Scripts/text/npc.txt", "w"):write("npc_" .. toSlug(npc.GetName(_FORV_4_)) .. " = \"" .. npc.GetName(_FORV_4_) .. "\"", "\n")
    end
  end
  _FOR_(_FOR_)
end
function writeMapPath()
  io.open("E:/Games/AutoVLBS16/Scripts/text/mapPath.txt", "w+"):write("local mapPath = {")
  while 0 < 20 do
    io.open("E:/Games/AutoVLBS16/Scripts/text/mapPath.txt", "w+"):write("{" .. player.GetMapPos(i) .. "," .. player.GetMapPos(i) .. "}")
    if player.GetDoingStatus() == 1 then
      echo(0 + 1)
    end
    timer.Sleep(200)
  end
  io.open("E:/Games/AutoVLBS16/Scripts/text/mapPath.txt", "w+"):close()
end
function toSlug(_ARG_0_)
  return _ARG_0_:gsub(" I$", "1"):gsub(" II$", "2"):gsub(" III$", "3"):gsub(" IV$", "4"):gsub(" V$", "5"):gsub("[^%w]", ""):lower()
end
function talkNPC(_ARG_0_)
  for _FORV_4_ = 2, 255 do
    if npc.GetKind(_FORV_4_) == 3 and npc.GetName(_FORV_4_) == _ARG_0_ then
      echo(npc.GetMapPos(_FORV_4_) / 256 .. " " .. npc.GetMapPos(_FORV_4_) / 512)
      player.DialogNpc(_FORV_4_)
      break
    end
  end
end
function testLength()
  for _FORV_3_ = 0, 255 do
    if npc.IsExists(_FORV_3_) and npc.GetKind(_FORV_3_) == 3 and 0 < string.len(npc.GetName(_FORV_3_)) then
      echo(npc.GetName(_FORV_3_))
      echo(tbVulanLib.GetLengthPlayer(npc.GetMapPos(_FORV_3_)))
    end
  end
end
function LocDo(options)
  found = false
  while item.GetFirst() ~= 0 do
    if item.GetFirst() == 3 and item.GetKey(item.GetFirst()) == 0 then
      for _FORV_12_ = 0, 5 do
      end
      if 0 + 1 ~= tablelength(options) then
        ShopItem(item.GetFirst())
      else
        echo("Trong h\181nh trang c\227 \174\229 v\221p")
        tbVulanLib.Chat("CH_NEARBY", "<color=green>Trong h\181nh trang c\227 \174\229 v\221p!")
        found = true
      end
    end
  end
  return found
end
function writeThuocTinh()
  echo("Ghi thuoc tinh")
  while item.GetFirst() ~= 0 do
    system.Print((item.GetName(item.GetFirst())))
    if item.GetFirst() == 3 and item.GetKey(item.GetFirst()) == 0 and 0 < item.GetPrice(item.GetFirst()) then
      system.Print((item.GetName(item.GetFirst())))
      io.open("D:/Games/AutoVLBS16/Scripts/text/zz.txt", "w+"):write(item.GetName(item.GetFirst()) .. "\n")
      for _FORV_12_ = 0, 5 do
        system.Print("D\223ng " .. _FORV_12_ + 1 .. ": " .. item.GetMagicAttrib(item.GetFirst()) .. " - " .. item.GetMagicAttrib(item.GetFirst()))
        io.open("D:/Games/AutoVLBS16/Scripts/text/zz.txt", "w+"):write("[" .. item.GetMagicAttrib(item.GetFirst()) .. "] = " .. item.GetMagicAttrib(item.GetFirst()) .. "," .. "\n")
      end
    end
  end
  io.open("D:/Games/AutoVLBS16/Scripts/text/zz.txt", "w+"):close((io.open("D:/Games/AutoVLBS16/Scripts/text/zz.txt", "w+")))
end
function layHKMP()
  tbVulanLib.UseItemName(szLenhBai)
  tbVulanLib.WaitMenuTimeOut(0, 3)
  clickMenuNext(2)
  clickMenuNext(5)
  clickMenu(0, 4)
  tbVulanLib.WaitMenuTimeOut(1, 3)
  clickMenu(1, 1)
end
function layDoXanh()
  tbVulanLib.UseItemName(szLenhBai)
  tbVulanLib.WaitMenuTimeOut(0, 3)
  clickMenuNext(1)
  clickMenuNext(2)
  clickMenuNext(0)
  clickMenu(3)
  nhapso(2)
  nhapso(9)
  enter()
end
function enter()
  timer.Sleep(350)
  system.SendKey(13, 1)
end
function nhapso(_ARG_0_)
  timer.Sleep(350)
  system.SendKey(48 + _ARG_0_, 0)
end
function tablelength(_ARG_0_)
  for _FORV_5_ in pairs(_ARG_0_) do
  end
  return 0 + 1
end
function ShopItem(_ARG_0_)
  while getFreeHanhTrang(false) == getFreeHanhTrang(false) do
    shop.Buy(_ARG_0_)
    timer.Sleep(100)
  end
end
function writeMenu()
  for _FORV_5_ = 0, menu.GetCount(0) do
    echo(menu.GetText(0, _FORV_5_))
    io.open("D:/Games/AutoVLBS16/Scripts/text/zz.txt", "w+"):write(menu.GetText(0, _FORV_5_) .. "\n")
  end
  io.open("D:/Games/AutoVLBS16/Scripts/text/zz.txt", "w+"):close((io.open("D:/Games/AutoVLBS16/Scripts/text/zz.txt", "w+")))
end
