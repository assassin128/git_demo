szVulanLib = system.GetScriptFolder().."\\LIB\\chung.lua"
IncludeFile(szVulanLib)

--Script Chuyen vat pham
-- Include file chua cac bien cau hinh chuong trinh chinh
---------------------------------------------------------------------------------------
-- Chon noi chuyen di, noi chuyen den va ten vat pham can chuyen tai day
-- 3 : Hanh trang;   4 : Ruong;   9 : Ruong 1;	  10 : Ruong 2;     23 : Ruong bang hoi
nStartBox 		= 3 	-- Noi chuyen di
nDestinationBox = 4 	-- Noi chuyen den
szItemName = ""			-- Ten vat pham can chuyen (szItemName = "" se chuyen tat ca)
-- szItemName = "Thæ ®Þa phï "
---------------------------------------------------------------------------------------

Chat = function(szChatChannel, szContent)
	local szTemp = ""
	szTemp = "Chat('"..szChatChannel.."', '"..szContent.."')"
	player.ExecuteScript(szTemp)
end

-- Chuyen nPlace thanh RoomType de su dung cho ham player.FindRoom()
MapToRoomType = function(nPlace)	
	if nPlace == 3  then return 0 end	-- Hanh trang
	if nPlace == 4  then return 1 end	-- Ruong 
	if nPlace == 9  then return 7 end	-- Ruong 1
	if nPlace == 10 then return 8 end	-- Ruong 2
	if nPlace == 23 then return 14 end	-- Ruong bang hoi
end

-- Ham chuyen vat pham
MoveItem = function(nStartBox, nDestinationBox, szItemName)
	--if nStoreItemPlace  < 1 then return end
	local nRoomType = 0 
	local bRoomExist, nFreeX, nFreeY, nWidth, nHeight = 0, 0, 0, 0, 0
	local bMoveOk = 0
	
	local nItemIndex,nPlace,nX,nY = item.GetFirst()
	while nItemIndex ~= 0 do
		bMoveOk = 0
		if nPlace == nStartBox and (item.GetName(nItemIndex) == szItemName or szItemName == "")then
			nWidth,nHeight = item.GetSize(nItemIndex)
			nRoomType = MapToRoomType(nDestinationBox)
			bRoomExist, nFreeX, nFreeY = player.FindRoom(nWidth, nHeight, nRoomType)
			if bRoomExist == 1 then
				-- Cam item len tay
				while item.IsHold()==0 do
					item.Move(nStartBox,nX,nY,0,0,0)
					timer.Sleep(10)
				end
				-- Chuyen den noi thiet lap
				while item.IsHold()==1 do
					item.Move(nDestinationBox, nFreeX, nFreeY, nDestinationBox, nFreeX, nFreeY)
					timer.Sleep(10)
				end	
				bMoveOk = 1
			end
		end
		
		if bMoveOk == 0 then nItemIndex, nPlace, nX, nY = item.GetNext()
		else nItemIndex, nPlace, nX, nY = item.GetFirst() end
	end	
	Chat("CH_NEARBY","<color=green> Move item done!")
end

tbThuocTinh = {
	[43] = 1, -- khong the pha huy
	[58] = 2, -- bo qua ne tranh
	[85] = 200, -- sinh luc
	[89] = 200, -- noi luc
	[93] = 200, -- the luc
	[97] = 20, -- suc manh
	[98] = 20, --than phap
	[99] = 20, -- sinh khi
	[88] = 6, -- phuc hoi sinh luc moi nua giay
	[92] = 6, -- phuc hoi noi luc moi nua giay
	[96] = 9, -- phuc hoi the luc moi nua giay
	[101] = 25, -- khang doc
	[102] = 25, -- khang hoa
	[103] = 30, -- khang loi
	[104] = 25, -- ptvl
	[105] = 25, -- khang bang
	[106] = 40, -- tg lam cham
	[108] = 40, -- tg trung doc
	[110] = 40, -- tg lam choang
	[111] = 40, -- toc do di chuyen
	[113] = 40, -- thoi gian phuc hoi
	[115] = 30, -- toc do danh (ngoai cong)
	[116] = 40, -- toc do danh (noi cong)
	[114] = 20, -- khang tat ca
	[117] = 20, -- phan don can chien
	[135] = 10, -- may man %
	[121] = 50, -- stvl diem (dong an)
	[122] = 100, -- hoa sat ngoai cong
	[123] = 100, -- bang sat ngoai cong
	[124] = 100, -- loi sat sat ngoai cong
	[125] = 50, -- doc sat ngoai cong
	[126] = 100, -- stvl % (dong hien)
	[134] = 15, -- chsttnl
	[136] = 10, -- hut sinh luc
	[137] = 10, -- hut noi
	[139] = 3, -- ky nang cua phai do duoc cong them
	[166] = 500, -- ti le cong kich chinh xac
	[168] = 200, -- stvl noi cong
	[169] = 200, -- bang sat noi cong
	[170] = 200, -- hoa sat noi cong
	[171] = 200, -- loi sat noi cong
	[172] = 50,  -- doc sat noi cong
	
}

tbHKMP = {
	[134] = 15, -- chsttnl
	[106] = 40, -- tg lam cham
	[104] = 25, -- ptvl
}

function NhanDo()
	local szLenhBai = 'LÖnh bµi T©n Thñ'
	tbVulanLib.UseItemName(szLenhBai) -- mo lenh bai
	timer.Sleep(500) -- doi 0,5 giay
end

-- index = 1: do xanh || 3: do hkmp
function NhanDoGi(index)
	clickMenuNext(index) -- chon nhan do xanh, hkmp
	timer.Sleep(500) -- khoang nghi 0.5 giay giua cac buoc
end	
	--clickMenuNext(2) -- chon quan ao
	--timer.Sleep(500)
	--clickMenuNext(0) -- chon nam nu
	--timer.Sleep(500)
	--clickMenu(3) -- chon he
	-- nhap so
	--nhapso(1) 
	--nhapso(0) -- 1 voi 0 la = 10
	--enter()
	--timer.Sleep(500) -- doi 0,5 giay cho auto loc do
--end

-- sex = 1: nam || 0: nu
-- element = 5 hanh (kim: 0, moc: 1, thuy: 2, hoa: 3, tho: 4)
-- group = phai (0: tl, 1: tv, 2: nm, 3: ty, 4: dm, 5: 5d, 6: cb, 7: tn, 8: vd, 9: cl)
-- branch = nhanh
-- tl: 0, 1, 2
-- tv: 0, 1, 2
-- nm: 0, 1, 2
-- ty: 0, 1
-- dm: 0, 1, 2, 3
-- 5d: 0, 1, 2
-- cb: 0, 1
-- tn: 0, 1, 2
-- vd: 0, 1
-- cl: 0, 1, 2
function getItem(index, sex, element, group, branch)
	if index == 0 then
		getAo(sex, element)
	elseif index == 1 then
		getNon(sex, element)
	elseif index == 2 then
		getGiay(sex, element)
	elseif index == 3 then
		getBaoTay(sex, element)
	elseif index == 4 then
		getDaiLung(sex, element)
	elseif index == 5 then
		getNhan(sex, element)
	elseif index == 6 then
		getNgocBoi(sex, element)
	elseif index == 7 then
		getDayChuyen(sex, element)
	elseif index == 8 then
		getHKMP(group, branch)
	else
		return false					
	end
	return getOptions()
end

function getItemsDM(index, sex, group, branch)
	if index == 0 then
		getAo(sex, 3)
	elseif index == 1 then
		getNon(sex, 4)
	elseif index == 2 then
		getGiay(sex, 2)
	elseif index == 3 then
		getBaoTay(sex, 3)
	elseif index == 4 then
		getDaiLung(sex, 3)
	elseif index == 8 then
		getHKMP(group, branch)	
	else
		return false					
	end
	return getOptionsDM(index)
end

function getOptionsDM(index)
	if index == 0 then
		options = {
			[85] = 20, ---0, -- sinh luc
			[104] = 2, ---5, -- ptvl
			[89] = 20, ---0, -- noi luc
			[106] = 4, ---0, -- tg lam cham
			[113] = 4, ---0, -- thoi gian phuc hoi
			[98] = 2, ---0, --than phap
		}
	elseif index == 1 then
		options = {
			[85] = 20, ---0, -- sinh luc
			[105] = 2, ---5, -- khang bang
			[89] = 20, ---0, -- noi luc
			[108] = 4, ---0, -- tg trung doc
		}
	elseif index == 2 then
		options = {
			[85] = 20, ---0, -- sinh luc
			[102] = 2, ---5, -- khang hoa
			[89] = 20, ---0, -- noi luc
			[110] = 4, ---0, -- tg lam choang
			[111] = 4, ---0, -- toc do di chuyen
			[99] = 2, ---0, -- sinh khi
		}
	elseif index == 3 then
		options = {
			[85] = 20, ---0, -- sinh luc
			[104] = 2, ---5, -- ptvl
			[89] = 20, ---0, -- noi luc
			[106] = 4, ---0, -- tg lam cham
			[88] = 6, -- phuc hoi sinh luc moi nua giay
			[98] = 2, ---0, --than phap
		}
	elseif index == 4 then
		options = {
			[85] = 20, ---0, -- sinh luc
			[104] = 2, ---5, -- ptvl
			[89] = 20, ---0, -- noi luc
			[106] = 4, ---0, -- tg lam cham
			[98] = 2, ---0, --than phap
		}
	elseif index == 8 then
		options = {
			[89] = 20, ---0, -- noi luc
			[115] = 4, ---0, -- toc do danh (ngoai cong)
			[126] = 15, ---0, -- stvl % (dong hien)
			[121] = 6, ---0, -- stvl diem (dong an)
			[137] = 4, -- hut noi
			[139] = 3, -- ky nang cua phai do duoc cong them
		}
	end
	return options
end

function getOptions()
	-- options for any item
	options = {
		[85] = 200, -- sinh luc
		[89] = 200, -- noi luc
	}
end

function getHKMP(group, branch)
	NhanDo()
	NhanDoGi(3)
	clickMenuNext(group) -- chon phai
	timer.Sleep(500)
	clickMenuNext(branch) -- chon he
	timer.Sleep(500)
end

function getAo(sex, element)
	index = 10
	if sex == 1 then
		index = 4 -- duong nghe giap
	else
		index = 10 -- hon tich lich phi phung giap
	end
	NhanDo()
	NhanDoGi(1)
	clickMenuNext(1) -- chon menu lay ao
	timer.Sleep(500)
	clickMenuNext(index) -- chon ao
	timer.Sleep(500)
	clickMenu(element) -- chon he
	nhapso(9)
	timer.Sleep(500)
end

function getGiay(sex, element)
	index = 0
	if sex == 1 then
		index = 0 -- duong nghe giap
	else
		index = 1 -- hon tich lich phi phung giap
	end
	NhanDo()
	NhanDoGi(1)
	clickMenuNext(2) -- chon menu lay giay
	timer.Sleep(500)
	clickMenuNext(index) -- chon giay
	timer.Sleep(500)
	clickMenu(element) -- chon he
	nhapso(1)
	nhapso(0)
	timer.Sleep(500)
end

function getDaiLung(sex, element)
	index = 0
	if sex == 1 then
		index = 0 -- duong nghe giap
	else
		index = 1 -- hon tich lich phi phung giap
	end
	NhanDo()
	NhanDoGi(1)
	clickMenuNext(3) -- chon menu lay dai lung
	timer.Sleep(500)
	clickMenuNext(index) -- chon dai lung
	timer.Sleep(500)
	clickMenu(element) -- chon he
	nhapso(1)
	nhapso(0)
	timer.Sleep(500)
end

function getBaoTay(sex, element)
end

function getNon(sex, element)
end

function getDayChuyen(sex, element)
end

function getNhan(sex, element)
end

function getNgocBoi(sex, element)
end

function mainItems(index, sex, group, branch)
	condition = true
	while condition do
		if index < 9 then
			options = getItemsDM(index, sex, group, branch)	
			if options ~= false then
				f = LocDo(options)
				if f == true then 
					-- cat do
					MoveItem(3, 4, "")
		 			timer.Sleep(1000)
		 			MoveItem(4, 3, 'LÖnh bµi T©n Thñ')
		 			timer.Sleep(500)
					index++
					mainItems(index, sex, group, branch)
				end
			else
				index++
				mainItems(index, sex, group, branch)
			end
		else
			condition = false		
		end	
		timer.Sleep(250)
		Chat("CH_NEARBY","<color=green> Get items done!")
	end
end

function mainGetItem(index, sex, element, group, branch)
	condition = true
	while condition do
		options = getItem(index, sex, element, group, branch) -- get one item: tra ve options
		f = LocDo(options)
		if f == true then
		 	-- cat do
		 	MoveItem(3, 4, "")
		 	timer.Sleep(1000)
		 	MoveItem(4, 3, 'LÖnh bµi T©n Thñ')
		 	timer.Sleep(500)
			condition = false 
		end
		timer.Sleep(250)
	end
end

function main()
	-- mainGetItem(0, 0, 3) -- ao nu he hoa
	-- mainGetItem(8, '', '', 0, 0) -- dao thieu lam
	mainItems(0, 0, 4, 2) -- set DM nu Bao vu
end
