--激活码认证卡
--孙多良
--2008.10.16
if not MODULE_GAMESERVER then
	return 0;
end

Require("\\script\\event\\presendcard\\presendcard_def.lua");


local TheNap = {
	[50000]={
		[1]={
			[1]="Trùng Sinh Đơn",
			[2]=4,
		},
		[2]={
			[1]="Tiền Xu",
			[2]=50,
		},
	},
	[100000]={
		[1]={
			[1]="Trùng Sinh Đơn",
			[2]=10,
		},
		[2]={
			[1]="Tiền Xu",
			[2]=120,
		},
	},
	[200000]={
		[1]={
			[1]="Trùng Sinh Đơn",
			[2]=22,
		},
		[2]={
			[1]="Tiền Xu",
			[2]=250,
		},
	},
	[500000]={
		[1]={
			[1]="Trùng Sinh Đơn",
			[2]=60,
		},
		[2]={
			[1]="Tiền Xu",
			[2]=650,
		},
	},
	[1]={
		[1]=string.format("%s,%s,%s,%s", 18, 1, 3044, 1),
	},
	[2]={
		[1]=string.format("%s,%s,%s,%s", 18, 1, 3045, 1),
	},
	[3]={
		[1]=string.format("%s,%s,%s,%s", 18, 1, 3045, 2),
	},
	[4]={
		[1]=string.format("%s,%s,%s,%s", 18, 1, 3045, 3),
	},
	[5]={
		[1]=string.format("%s,%s,%s,%s", 18, 1, 3045, 4),
	},
};


function PresendCard:GetItemMoi(szText)
	local rows = {};
	local itsat = 0;
	local tmp = szText;
	while itsat ~= nil do
		itsat = string.find(tmp,",",1);
		if itsat ~= nil then
			rows[#rows+1] = string.sub(tmp,1,itsat-1);
			tmp = string.sub(tmp,itsat+1);
		else
			rows[#rows+1] = tmp;
		end
	end
	local returnItem = {tonumber(rows[1]), tonumber(rows[2]), tonumber(rows[3]), tonumber(rows[4])};
	return unpack(returnItem);
end


function PresendCard:MyCoinCardCheck(nFlag, szCDKey)
	if not nFlag then
		Dialog:AskString("Hãy nhập mã: ", 32, self.MyCoinCardCheck, self, 1);
		return 0;
	end
	if (nFlag ~= 1) then
		return 0;
	end
	if not szCDKey or szCDKey == "" or string.len(szCDKey) > 30 then
		me.Msg(szCDKey);
		Dialog:Say("Mã nạp đồng của ngươi không đúng đừng lừa ta.");
		return 0;
	end

	local KTra = 0;
	local INPUT_FILE_PATH = "\\giftcode\\giftcode.txt";
	local tbFile = Lib:LoadTabFile(INPUT_FILE_PATH);
    if not tbFile then
        Dialog:Say("Hiện tại không phát Code!");
        return;
    end
    for _, tbRow in pairs(tbFile) do
        local szMaCode           = tbRow["MaCode"] or "";
        if szMaCode == szCDKey then
            self:KTraPhatCode(tbRow,szCDKey);
            KTra = 1;    --CO TIM THAY MA CODE
            return;
        end
    end
    if KTra == 0 then
        Dialog:Say("Mã khuyến mãi nhập không đúng hoặc không tồn tại!");
        return;
    end
	--End check file
end


function PresendCard:KTraPhatCode(tbRow, szCDKey)
    if (tbRow) then
    	local Macode = tbRow["MaCode"];
    	local LoginName = tostring(tbRow["LoginName"]);
    	local TimeStart = tonumber(tbRow["TimeStart"]);
    	local TimeEnd = tonumber(tbRow["TimeEnd"]);
    	local TimeUse = tonumber(tbRow["TimeUse"]);
    	local Type = tonumber(tbRow["Type"]);

    	-- Dialog:Say("Mã khuyến mãi này chưa tới hoặc đã hết hạn sử dụngccdscscd !  "..TimeUse);


		local KTraOut = 0;
		local OUTPUT_FILE_PATH = "\\giftcode\\logcode.txt";
		local tbFileOut = Lib:LoadTabFile(OUTPUT_FILE_PATH);
	    if not tbFileOut then
	        Dialog:Say("Hiện tại không phát Code!");
	        return;
	    end
	    for _, tbRowOut in pairs(tbFileOut) do
	        local szMaCode           = tbRowOut["MaCode"] or "";
	        if szMaCode == szCDKey then
	            KTraOut = 1;    --CO TIM THAY MA CODE
	        end
	    end
    	if KTraOut == 0 then
    		-- dc sd
    		if (LoginName == me.szAccount) then
    			local timeCur = GetTime();
	    		if (TimeStart <= timeCur and timeCur <= TimeEnd) then
	    			self:PhatCode(Type, szCDKey, OUTPUT_FILE_PATH);
	    			--self:AddLogCode(szCDKey, OUTPUT_FILE_PATH);
	    		else
	    			Dialog:Say("Mã khuyến mãi này chưa tới hoặc đã hết hạn sử dụng !");
	    			return ;
	    		end
    		else
    			Dialog:Say("Bạn không thể sử dụng Mã khuyến mãi này !");
    			return ;
    		end
    	else
    		Dialog:Say("Mã khuyến mãi này đã được sử dụng!");
    		return ;
    	end
    end
end

function PresendCard:AddLogCode(szCDKey, OUTPUT_FILE_PATH)
	--WRITE FILE
    local szTime = GetTime();
    local szOut = szCDKey .. "\t" .. me.szName .. "\t" .. me.szAccount .. "\t" .. szTime .. "\n";
    KFile.AppendFile(OUTPUT_FILE_PATH, szOut);
end

function PresendCard:PhatCode(Type, szCDKey, OUTPUT_FILE_PATH)

	if(Type == 20000) then
		me.AddStackItem(18,1,1193,1,nil,1);
		self:AddLogCode(szCDKey, OUTPUT_FILE_PATH);
	elseif(Type >= 50000) then
		local tbOpt = {};
		for i=1,#TheNap[Type] do
			local name = TheNap[Type][i][1];
			table.insert(tbOpt , {"<pic=135>  <color=green>"..name..".<color>",  self.AddItemGift, self, i, Type, szCDKey, OUTPUT_FILE_PATH});
		end
		table.insert(tbOpt , {"Kết thúc đối thoại"});
		local szMsg = "Chọn Vật Phẩm mà bạn muốn lấy.";
	   	Dialog:Say(szMsg, tbOpt);
	elseif (Type == 100) then
		if me.CountFreeBagCell() < 5 then
			Dialog:Say("Rương của bạn cần ít nhất 5 ô trống.");
			return 0;
		end
		local tbItemInfo = {bForceBind = 1};
		me.AddStackItem(18,1,1192,12,tbItemInfo,1000);
		me.AddStackItem(18, 1, 3028, 5,tbItemInfo,30);
		me.AddStackItem(18, 1, 3052, 1,tbItemInfo,5);
		self:AddLogCode(szCDKey, OUTPUT_FILE_PATH);
	else
		if me.CountFreeBagCell() < 1 then
			Dialog:Say("Rương của bạn cần ít nhất 1 ô trống.");
			return 0;
		end
		me.AddItem(self:GetItemMoi(TheNap[Type][1]));
		self:AddLogCode(szCDKey, OUTPUT_FILE_PATH);
	end

end

function PresendCard:AddItemGift(id, Type, szCDKey, OUTPUT_FILE_PATH)
    if(id == 1) then
    	self:AddGiftMG(id, Type, szCDKey, OUTPUT_FILE_PATH);
	else
		if me.CountFreeBagCell() < 1 then
			Dialog:Say("Rương của bạn cần ít nhất 1 ô trống.");
			return 0;
		end
		 --me.AddItem(18, 1, 3024, 1);
		me.AddStackItem(18, 1, 3024, 1, nil, TheNap[Type][2][2]);
		self:AddLogCode(szCDKey, OUTPUT_FILE_PATH);
		Dialog:Say("Bạn nhận được "..TheNap[Type][2][2].." "..KItem.GetNameById(18, 1, 3024, 1));
    end
end

function PresendCard:AddGiftMG(id , Type, szCDKey, OUTPUT_FILE_PATH)
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("Rương của bạn cần ít nhất 1 ô trống.");
		return 0;
	end
    --me.AddItem(18, 1, 1192, id);
    me.AddStackItem(18, 1, 1193, 1, nil, TheNap[Type][1][2]);
    self:AddLogCode(szCDKey, OUTPUT_FILE_PATH);
    Dialog:Say("Bạn nhận được "..TheNap[Type][1][2].." "..KItem.GetNameById(18, 1, 1193, id));
end



-------------------Do cuoi 1------------------------


local TB_AWARD = 
{ 	
	--Ao
	[1] = 
	{
		--Kim
		[1] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,3,931,10,3,16};
				--Noi
				[1] = {4,3,931,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,3,932,10,3,16};
				--Noi
				[1] = {4,3,932,10,3,16};
			}			
		},
		--Moc
		[2] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,3,933,10,3,16};
				--Noi
				[1] = {4,3,933,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,3,934,10,3,16};
				--Noi
				[1] = {4,3,934,10,3,16};
			}
		},
		--Thuy
		[3] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,3,935,10,3,16};
				--Noi
				[1] = {4,3,935,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,3,936,10,3,16};
				--Noi
				[1] = {4,3,936,10,3,16};
			}
		},
		--Hoa
		[4] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,3,937,10,3,16};
				--Noi
				[1] = {4,3,937,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,3,938,10,3,16};
				--Noi
				[1] = {4,3,938,10,3,16};
			}
		},
		--Tho
		[5] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,3,939,10,3,16};
				--Noi
				[1] = {4,3,939,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,3,940,10,3,16};
				--Noi
				[1] = {4,3,940,10,3,16};
			}
		},
	},	
	
	--Nh?n
	[2] = 
	{
		--Kim
		[1] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,4,1036,10,3,16};
				--Noi
				[1]= {4,4,1041,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,4,1036,10,3,16};
				--Noi
				[1] = {4,4,1041,10,3,16};
			},
		
		},
			--Moc
		[2] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,4,1037,10,3,16};
				--Noi
				[1]= {4,4,1042,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,4,1037,10,3,16};
				--Noi
				[1] = {4,4,1042,10,3,16};
			}
		},
		--Thuy
		[3] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,4,1038,10,3,16};
				--Noi
				[1] = {4,4,1043,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,4,1038,10,3,16};
				--Noi
				[1] = {4,4,1043,10,3,16};
			}
		},
		--Hoa
		[4] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,4,1039,10,3,16};
				--Noi
				[1] = {4,4,1044,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,4,1039,10,3,16};
				--Noi
				[1] = {4,4,1044,10,3,16};
			}
		},
		--Tho
		[5] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,4,1040,10,3,16};
				--Noi
				[1] = {4,4,1045,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,4,1040,10,3,16};
				--Noi
				[1] = {4,4,1045,10,3,16};
			}
		},	
	
	},	
	
	
	--Lien
	[3] = 
	{
		--Kim
		[1] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,5,950,10,3,16};
				--Noi
				[1] = {4,5,951,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,5,950,10,3,16};
				--Noi
				[1] = {4,5,951,10,3,16};
			}
		},
		--Moc
		[2] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,5,952,10,3,16};
				--Noi
				[1] = {4,5,953,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,5,952,10,3,16};
				--Noi
				[1] = {4,5,953,10,3,16};
			}
		},
		--Thuy
		[3] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,5,954,10,3,16};
				--Noi
				[1] = {4,5,955,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,5,954,10,3,16};
				--Noi
				[1] = {4,5,955,10,3,16};
			}
		},
		--Hoa
		[4] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,5,956,10,3,16};
				--Noi
				[1] = {4,5,957,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,5,956,10,3,16};
				--Noi
				[1] = {4,5,957,10,3,16};
			}
		},
		--Tho
		[5] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,5,958,10,3,16};
				--Noi
				[1] = {4,5,959,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,5,958,10,3,16};
				--Noi
				[1] = {4,5,959,10,3,16};
			}
		},
	},	
	--Phù
	[4] = 
	{
		--Kim
		[1] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,6,1016,10,3,16};
				--Noi
				[1] = {4,6,1016,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,6,1016,10,3,16};
				--Noi
				[1] = {4,6,1016,10,3,16};
			}
		},
		--Moc
		[2] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,6,1017,10,3,16};
				--Noi
				[1] = {4,6,1017,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,6,1017,10,3,16};
				--Noi
				[1] = {4,6,1017,10,3,16};
			}
		},
		--Thuy
		[3] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,6,1018,10,3,16};
				--Noi
				[1] = {4,6,1018,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,6,1018,10,3,16};
				--Noi
				[1] = {4,6,1018,10,3,16};
			}
		},
		--Hoa
		[4] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,6,1019,10,3,16};
				--Noi
				[1] = {4,6,1019,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,6,1019,10,3,16};
				--Noi
				[1] = {4,6,1019,10,3,16};
			}
		},
		--Tho
		[5] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,6,1020,10,3,16};
				--Noi
				[1] = {4,6,1020,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,6,1020,10,3,16};
				--Noi
				[1] = {4,6,1020,10,3,16};
			}
		},
	},	
	--giày
	[5] = 
	{
		--Kim
		[1] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,7,1066,10,3,16};
				--Noi
				[1] = {4,7,1066,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,7,1067,10,3,16};
				--Noi
				[1] = {4,7,1067,10,3,16};
			}
		},
		--Moc
		[2] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,7,1068,10,3,16};
				--Noi
				[1] = {4,7,1068,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,7,1069,10,3,16};
				--Noi
				[1] = {4,7,1069,10,3,16};
			}
		},
		--Thuy
		[3] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,7,1070,10,3,16};
				--Noi
				[1] = {4,7,1070,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,7,1071,10,3,16};
				--Noi
				[1] = {4,7,1071,10,3,16};
			}
		},
		--Hoa
		[4] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,7,1072,10,3,16};
				--Noi
				[1] = {4,7,1072,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,7,1073,10,3,16};
				--Noi
				[1] = {4,7,1073,10,3,16};
			}
		},
		--Tho
		[5] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,7,1074,10,3,16};
				--Noi
				[1] = {4,7,1074,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,7,1075,10,3,16};
				--Noi
				[1] = {4,7,1075,10,3,16};
			}
		},
	},	
	--Lung
	[6] = 
	{
		--Kim
		[1] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,8,1096,10,3,16};
				--Noi
				[1] = {4,8,1096,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,8,1097,10,3,16};
				--Noi
				[1] = {4,8,1097,10,3,16};
			}
		},
		--Moc
		[2] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,8,1098,10,3,16};
				--Noi
				[1] = {4,8,1098,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,8,1099,10,3,16};
				--Noi
				[1] = {4,8,1099,10,3,16};
			}
		},
		--Thuy
		[3] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,8,1100,10,3,16};
				--Noi
				[1] = {4,8,1100,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,8,1101,10,3,16};
				--Noi
				[1] = {4,8,1101,10,3,16};
			}
		},
		--Hoa
		[4] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,8,1102,10,3,16};
				--Noi
				[1] = {4,8,1102,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,8,1103,10,3,16};
				--Noi
				[1] = {4,8,1103,10,3,16};
			}
		},
		--Tho
		[5] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,8,1104,10,3,16};
				--Noi
				[1] = {4,8,1104,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,8,1105,10,3,16};
				--Noi
				[1] = {4,8,1105,10,3,16};
			}
		},
	
	
	},
	
	--Mu
	[7] = 
	{
	
		--Kim
		[1] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,9,1056,10,3,16};
				--Noi
				[1] = {4,9,1056,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,9,1057,10,3,16};
				--Noi
				[1] = {4,9,1057,10,3,16};
			}
		
		},
		--Moc
		[2] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,9,1058,10,3,16};
				--Noi
				[1] = {4,9,1058,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,9,1059,10,3,16};
				--Noi
				[1] = {4,9,1059,10,3,16};
			}
		},
		--Thuy
		[3] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,9,1060,10,3,16};
				--Noi
				[1] = {4,9,1060,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,9,1061,10,3,16};
				--Noi
				[1] = {4,9,1061,10,3,16};
			}
		},
		--Hoa
		[4] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,9,1062,10,3,16};
				--Noi
				[1] = {4,9,1062,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,9,1063,10,3,16};
				--Noi
				[1] = {4,9,1063,10,3,16};
			}
		},
		--Tho
		[5] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,9,1064,10,3,16};
				--Noi
				[1] = {4,9,1064,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,9,1065,10,3,16};
				--Noi
				[1] = {4,9,1065,10,3,16};
			}
		},
	},
	
	--Uy?n
	[8] = 
	{
		--Kim
		[1] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,10,1076,10,3,16};
				--Noi
				[1] = {4,10,1078,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,10,1077,10,3,16};
				--Noi
				[1] = {4,10,1078,10,3,16};
			}
		},
		--Moc
		[2] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,10,1080,10,3,16};
				--Noi
				[1] = {4,10,1082,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,10,1081,10,3,16};
				--Noi
				[1] = {4,10,1083,10,3,16};
			}
		},
		--Thuy
		[3] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,10,1084,10,3,16};
				--Noi
				[1] = {4,10,1086,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,10,1085,10,3,16};
				--Noi
				[1] = {4,10,1087,10,3,16};
			}
		},
		--Hoa
		[4] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,10,1088,10,3,16};
				--Noi
				[1] = {4,10,1090,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,10,1089,10,3,16};
				--Noi
				[1] = {4,10,1091,10,3,16};
			}
		},
		--Tho
		[5] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,10,1092,10,3,16};
				--Noi
				[1] = {4,10,1094,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,10,1093,10,3,16};
				--Noi
				[1] = {4,10,1095,10,3,16};
			}
		},
	
	
	},
	
	--B?i
	[9] = 
	{
		--Kim
		[1] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,11,1046,10,3,16};
				--Noi
				[1] = {4,11,1046,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,11,1047,10,3,16};
				--Noi
				[1] = {4,11,1047,10,3,16};
			}
		},
		--Moc
		[2] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,11,1048,10,3,16};
				--Noi
				[1] = {4,11,1048,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,11,1049,10,3,16};
				--Noi
				[1] = {4,11,1049,10,3,16};
			}
		},
		--Thuy
		[3] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,11,1050,10,3,16};
				--Noi
				[1] = {4,11,1050,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,11,1051,10,3,16};
				--Noi
				[1] = {4,11,1051,10,3,16};
			}
		},
		--Hoa
		[4] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,11,1052,10,3,16};
				--Noi
				[1] = {4,11,1052,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,11,1053,10,3,16};
				--Noi
				[1] = {4,11,1053,10,3,16};
			}
		},
		--Tho
		[5] = 
		{
			--Nam
			[0]=
			{
				--Ngoai
				[0] = {4,11,1054,10,3,16};
				--Noi
				[1] = {4,11,1054,10,3,16};
			},
			--Nu
			[1]=
			{
				--Ngoai
				[0] = {4,11,1055,10,3,16};
				--Noi
				[1] = {4,11,1055,10,3,16};
			}
		},
	
	},
};



function PresendCard:DoCuoi14()
	PresendCard:DoNam14()
end
function PresendCard:DoNam14()
	local szMsg = "Hay chon";
	local tbOpt = {
		{"He Kim",self.HeKim14,self},
		{"He Moc",self.HeMoc14,self},
		{"He Thuy",self.HeThuy14,self},
		{"He Hoa",self.HeHoa14,self},
		{"He Tho",self.HeTho14,self},
	}
	Dialog:Say(szMsg,tbOpt);
end

function PresendCard:DoNu14()
	local szMsg = "Hay chon";
	local tbOpt = {
		{"He Kim",self.HeKim141,self},
		{"He Moc",self.HeMoc141,self},
		{"He Thuy",self.HeThuy141,self},
		{"He Hoa",self.HeHoa141,self},
		{"He Tho",self.HeTho141,self},
	}
	Dialog:Say(szMsg,tbOpt);
end
function PresendCard:HeKim14()
	local szMsg = "Hay chon";
	local tbOpt ={
		{"Do Ngoai",self.KimNgoai14,self},
		{"Do Noi",self.KimNoi14,self},
	}
	Dialog:Say(szMsg,tbOpt);
end
function PresendCard:HeKim141()
	local szMsg = "Hay chon";
	local tbOpt ={
		{"Do Ngoai",self.KimNgoai141,self},
		{"Do Noi",self.KimNoi141,self},
	}
	Dialog:Say(szMsg,tbOpt);
end

function PresendCard:HeMoc14()
	local szMsg = "Hay chon";
	local tbOpt ={
		{"Do Ngoai",self.MocNgoai14,self},
		{"Do Noi",self.MocNoi14,self},
	}
	Dialog:Say(szMsg,tbOpt);
end
function PresendCard:HeMoc141()
	local szMsg = "Hay chon";
	local tbOpt ={
		{"Do Ngoai",self.MocNgoai141,self},
		{"Do Noi",self.MocNoi141,self},
	}
	Dialog:Say(szMsg,tbOpt);
end
function PresendCard:HeThuy14()
	local szMsg = "Hay chon";
	local tbOpt ={
		{"Do Ngoai",self.ThuyNgoai14,self},
		{"Do Noi",self.ThuyNoi14,self},
	}
	Dialog:Say(szMsg,tbOpt);
end
function PresendCard:HeThuy141()
	local szMsg = "Hay chon";
	local tbOpt ={
		{"Do Ngoai",self.ThuyNgoai141,self},
		{"Do Noi",self.ThuyNoi141,self},
	}
	Dialog:Say(szMsg,tbOpt);
end
function PresendCard:HeHoa14()
	local szMsg = "Hay chon";
	local tbOpt ={
		{"Do Ngoai",self.HoaNgoai14,self},
		{"Do Noi",self.HoaNoi14,self},
	}
	Dialog:Say(szMsg,tbOpt);
end
function PresendCard:HeHoa141()
	local szMsg = "Hay chon";
	local tbOpt ={
		{"Do Ngoai",self.HoaNgoai141,self},
		{"Do Noi",self.HoaNoi141,self},
	}
	Dialog:Say(szMsg,tbOpt);
end
function PresendCard:HeTho14()
	local szMsg = "Hay chon";
	local tbOpt ={
		{"Do Ngoai",self.ThoNgoai14,self},
		{"Do Noi",self.ThoNoi14,self},
	}
	Dialog:Say(szMsg,tbOpt);
end
function PresendCard:HeTho141()
	local szMsg = "Hay chon";
	local tbOpt ={
		{"Do Ngoai",self.ThoNgoai141,self},
		{"Do Noi",self.ThoNoi141,self},
	}
	Dialog:Say(szMsg,tbOpt);
end

function PresendCard:LoaiItem(nHe, nNoiNgoai)
	local szMsg = "Hay chon";
	local tbOpt ={
		{"Áo",self.GetItem,self, 1, nHe, nNoiNgoai},
		{"Nhẫn",self.GetItem,self, 2, nHe, nNoiNgoai},
		{"Liên",self.GetItem,self, 3, nHe, nNoiNgoai},
		{"Phù",self.GetItem,self, 4, nHe, nNoiNgoai},
		{"Giày",self.GetItem,self, 5, nHe, nNoiNgoai},
		{"Lưng",self.GetItem,self, 6, nHe, nNoiNgoai},
		{"Mũ",self.GetItem,self, 7, nHe, nNoiNgoai},
		{"Uyển",self.GetItem,self, 8, nHe, nNoiNgoai},
		{"Bội",self.GetItem,self, 9, nHe, nNoiNgoai},
	}
	Dialog:Say(szMsg,tbOpt);
end

function PresendCard:GetItem(nType, nHe, nNoiNgoai)
	local pItem = me.AddItem(unpack(TB_AWARD[nType][nHe][me.nSex][nNoiNgoai]));
	pItem.Bind(1); 
end

function PresendCard:KimNgoai14()
	PresendCard:LoaiItem(1,0);	
end

function PresendCard:KimNgoai141()
	PresendCard:LoaiItem(1,0);
end

function PresendCard:KimNoi14()
	PresendCard:LoaiItem(1,1);
end

function PresendCard:KimNoi141()
	PresendCard:LoaiItem(1,1);
end

function PresendCard:MocNgoai14()
	PresendCard:LoaiItem(2,0);
end

function PresendCard:MocNgoai141()
	PresendCard:LoaiItem(2,0);
end

function PresendCard:MocNoi14()
	PresendCard:LoaiItem(2,1);
end

function PresendCard:MocNoi141()
	PresendCard:LoaiItem(2,1);
end


function PresendCard:ThuyNgoai14()
	PresendCard:LoaiItem(3,0);
end

function PresendCard:ThuyNgoai141()
	PresendCard:LoaiItem(3,0);
end

function PresendCard:ThuyNoi14()
	PresendCard:LoaiItem(3,1);
end

function PresendCard:ThuyNoi141()
	PresendCard:LoaiItem(3,1);
end

function PresendCard:HoaNgoai14()
	PresendCard:LoaiItem(4,0);
end

function PresendCard:HoaNgoai141()
	PresendCard:LoaiItem(4,0);
end

function PresendCard:HoaNoi14()
	PresendCard:LoaiItem(4,1);
end

function PresendCard:HoaNoi141()
	PresendCard:LoaiItem(4,1);
end

function PresendCard:ThoNgoai14()
	PresendCard:LoaiItem(5,0);
end

function PresendCard:ThoNgoai141()
	PresendCard:LoaiItem(5,0);
end

function PresendCard:ThoNoi14()
	PresendCard:LoaiItem(5,1);
end

function PresendCard:ThoNoi141()
	PresendCard:LoaiItem(5,1);
end


------------------End do cuoi 1-----------------------

function PresendCard:ErrorCard(nResult)
	local szMsg = self.RESULT_DESC[nResult] or "Nạp thất bại";
	Dialog:Say(szMsg);
end

--nPresentType:类型
--nResult:1代表成功，2代表失败，3代表帐号不存在，1009代表传入的参数非法或为空，1500代表礼品序列号不存在，1501礼品已被使用,1502礼品已过期
function PresendCard:VerifyResult(nPresentType, nResult)
	me.AddWaitGetItemNum(-1);
	if self.PRESEND_TYPE[nPresentType] then
		if nResult ~= 1 then
			Lib:CallBack({self.PRESEND_TYPE[0][self.INDEX_CALLBACKFUNC], nResult})
		else
			if self.PRESEND_TYPE[nPresentType][self.INDEX_CALLBACKFUNC] then
				Lib:CallBack({self.PRESEND_TYPE[nPresentType][self.INDEX_CALLBACKFUNC], nResult});
			else
				self:OnCheckResult(nPresentType,nResult);
			end
		end
	end
	
end

function PresendCard:OnDialogCard(nFlag, szCDKey)
	if not nFlag then
		Dialog:AskString("Hãy nhập mã nạp đồng: ", 20, self.OnDialogCard, self, 1);
		return 0;
	end
	
	if (nFlag ~= 1) then
		return 0;
	end

	szCDKey = string.upper(szCDKey);

	local szKeyFlag = self:GetCDKeyFlag(szCDKey);
	
	local nPresentType = self:GetTypeByKeyFlag(szKeyFlag);	
	
	local tbInfo = self.PRESEND_TYPE[nPresentType];
	if (not tbInfo) then
		Dialog:Say(string.format("Mã nạp không hợp lệ."));
		return 0;
	end
	
	--增加网关判断
	if self:CmpGateWay(nPresentType) == 0 then
		Dialog:Say(string.format("Mã kích hoạt có thể không sử dụng được nữa, hãy thử lại."));
		return 0;
	end
	
	
	if (tbInfo[self.INDEX_STARTTIME]) then
		local nNowDay = tonumber(GetLocalDate("%Y%m%d"));
		if (nNowDay >= tbInfo[self.INDEX_STARTTIME]) then
			if (tbInfo[self.INDEX_ENDTIME] and tbInfo[self.INDEX_ENDTIME] > 0 and nNowDay > tbInfo[self.INDEX_ENDTIME]) then
				Dialog:Say(string.format("%s活动已经结束。", tbInfo[self.INDEX_NAME]));
				return 0;
			end
		elseif (nNowDay > 0 and nNowDay < tbInfo[self.INDEX_STARTTIME]) then
			Dialog:Say(string.format("%s活动还未开始！", tbInfo[self.INDEX_NAME]));
			return 0;
		end
	end	

	if (not tbInfo[self.INDEX_TASKGROUP] or not tbInfo[self.INDEX_TASKID]) then
		return 0;
	end

	--任务变量为0则表示不需要判断
	--如果该角色已经激活了
	if tbInfo[self.INDEX_TASKGROUP] ~= 0 or tbInfo[self.INDEX_TASKID] ~= 0 then
		if me.GetTask(tbInfo[self.INDEX_TASKGROUP], tbInfo[self.INDEX_TASKID]) > 0 then
			Dialog:Say(string.format("您已经激活过并领取过%s活动奖励", tbInfo[self.INDEX_NAME]));
			return 0;
		end
	end
	
	local nCount = tbInfo[self.INDEX_COUNT];
	if (me.CountFreeBagCell() < nCount) then
		Dialog:Say(string.format("Hành trang không đủ chỗ trống."));
		return 0;
	end

	local szMsg = string.format("您现在激活的是<color=yellow>%s<color>活动奖励，您确定要领取吗？", tbInfo[self.INDEX_NAME]);
	local tbOpt = {
		{"Tôi chắc chắn mã đúng", self.OnCheckKey, self, nPresentType, szCDKey},
		{"Để tôi xem lại."},
	}
	Dialog:Say(szMsg, tbOpt);
end

function PresendCard:GetTypeByKeyFlag(szKey)
	if (not szKey) then
		return -1;
	end
	for nType, tbInfo in pairs(self.PRESEND_TYPE) do
		if (tbInfo[self.INDEX_CDKEYFLAG] and tbInfo[self.INDEX_CDKEYFLAG] == szKey) then
			return nType;
		end
	end
	return -1;
end

function PresendCard:OnCheckKey(nPresentType, szCDKey)
	--检查激活码
	--if not szCDKey or szCDKey == "" or string.len(szCDKey) > 20 or string.len(szCDKey) < 10 then
	--	Dialog:Say("输入激活码的长度不符合要求。");
	--	return 1;
	--end
	
	--- todo 大小写转换
	szCDKey = string.upper(szCDKey);
	
	local tbInfo = self.PRESEND_TYPE[nPresentType];
	if (not tbInfo) then
		Dialog:Say("这个礼包不存在，请与系统管理员联系！");
		return 0;
	end

	if (not tbInfo[self.INDEX_CDKEYFLAG]) then
		return 0;
	end

	local szKeyFlag = self:GetCDKeyFlag(szCDKey);

	if (tbInfo[self.INDEX_CDKEYFLAG] and (not szKeyFlag or tbInfo[self.INDEX_CDKEYFLAG] ~= szKeyFlag)) then
		Dialog:Say("这个激活码不能验证，不是这个活动的激活码！");
		return 0;
	end

	if tbInfo[self.INDEX_OTHER] then
		Lib:CallBack({tbInfo[self.INDEX_OTHER], szCDKey});
	end

	-- test
	
--	self:VerifyResult(nPresentType, 1);
--	me.AddWaitGetItemNum(1);



	if (self._FLAG_TEST[nPresentType] and self._FLAG_TEST[nPresentType] == 1) then
		self:VerifyResult(nPresentType, 1);
		Dbg:WriteLog("PresendCard",  "OnCheckKey", me.szName, szCDKey, "目前的激活码机制状态是测试状态，不通过正常渠道走激活流程，请慎重使用！");		
		return 1;
	end


	if SendPresentKey(szCDKey) == 1 then
		me.AddWaitGetItemNum(1);
		return 1;
	end

	Dialog:Say("输入的激活码不符合要求。");
end

-- 这样有个缺陷，今后将会定死这个生成激活码规则
function PresendCard:GetCDKeyFlag(szCDKey)
	for i, tbInfo in pairs(self.PRESEND_TYPE) do
		if (i >= 2 and tbInfo) then
			local tbKeySer = tbInfo[self.INDEX_KEYINDEX];
			if (tbKeySer) then
				local szFlag = "";
				for _, nNum in ipairs(tbKeySer) do
					local szOneKey = string.sub(szCDKey, nNum, nNum);
					if (not szOneKey) then
						break;
					end
					szFlag = string.format("%s%s", szFlag, szOneKey);
				end
				if (szFlag ~= "" and szFlag == tbInfo[self.INDEX_CDKEYFLAG]) then
					return szFlag;
				end
			end
		end
	end
	
	return nil;
end


function PresendCard:OnCheckResult(nPresentType,nResult)
	if nResult == 1 then
		self:OnGetAward(nPresentType);
		return 1;
	end
	Dialog:Say(self.RESULT_DESC[nResult] or "激活码异常");
end


function PresendCard:OnCheckResult_LX(nResult)
	if nResult == 1 then
		self:OnGetAward(2);
		return 1;
	end
	Dialog:Say(self.RESULT_DESC[nResult] or "激活码异常");
end

function PresendCard:OnCheckResult_JN(nResult)
	if nResult == 1 then
		self:OnGetAward(3);
		return 1;
	end
	Dialog:Say(self.RESULT_DESC[nResult] or "激活码异常");	
end

function PresendCard:OnCheckResult_DL(nResult)
	if nResult == 1 then
		self:OnGetAward(4);
		return 1;
	end
	Dialog:Say(self.RESULT_DESC[nResult] or "激活码异常");	
end

function PresendCard:OnCheckResult_YY(nResult)
	if nResult == 1 then
		if not me.GetTempTable("Player").tbPresend or type(me.GetTempTable("Player").tbPresend) ~= "string" then
			Dialog:Say(self.RESULT_DESC[nResult] or "激活码异常");	
			print("error ,OnCheckResult_YY ");
			return;
		end
		local szPresend = me.GetTempTable("Player").tbPresend;
		local nSecType = self.PresendCardParamYY[szPresend];
		if not nSecType then
			Dialog:Say(self.RESULT_DESC[nResult] or "激活码异常");	
			return;
		end		
		self:OnGetAward(6,nSecType);
		me.GetTempTable("Player").tbPresend = nil;
		return 1;
	end
	me.GetTempTable("Player").tbPresend = nil;
	Dialog:Say(self.RESULT_DESC[nResult] or "激活码异常");		
end

function PresendCard:OnCheckBefore_YY(szCDKey)
	me.GetTempTable("Player").tbPresend = string.sub(szCDKey,3,4);
end

function PresendCard:OnCheckResult_MLXS(nResult)
	if nResult == 1 then
		self:OnGetAward(2000);
		return 1;
	end
	Dialog:Say(self.RESULT_DESC[nResult] or "激活码异常");	
end

function PresendCard:OnGetAward(nPresentType, nSecondType)
	local tbInfo = self.PRESEND_TYPE[nPresentType];
	if (not tbInfo) then
		Dbg:WriteLog("PresendCard",  "OnGetAward", me.szName,  string.format("%d号这个礼包不存在，请与系统管理员联系", nPresentType));
		Dialog:Say("这个礼包不存在，请与系统管理员联系！");
		return 0;
	end
	
	if (not tbInfo[self.INDEX_TASKGROUP] or not tbInfo[self.INDEX_TASKID]) then
		return 0;
	end
	
	if (not tbInfo[self.INDEX_ITEMTABLE] or type(tbInfo[self.INDEX_ITEMTABLE]) ~= "table") then
		Dbg:WriteLog("PresendCard",  "OnGetAward", me.szName,  string.format("%d号这个礼包有问题", nPresentType));
		Dialog:Say("这个礼包不存在，请与系统管理员联系！");
	end
	
	local pItem = me.AddItem(unpack(tbInfo[self.INDEX_ITEMTABLE]));
	if (not pItem) then
		Dbg:WriteLog("PresendCard",  "OnGetAward", me.szName,  string.format("获得大礼包失败!"));
		return 0;
	end
	pItem.SetCustom(Item.CUSTOM_TYPE_MAKER, tbInfo[self.INDEX_NAME] or "");
	pItem.SetGenInfo(1,nPresentType);
	if nSecondType then
		pItem.SetGenInfo(2,nSecondType);
	end
	pItem.SetTimeOut(0, (GetTime() + self.ITEM_TIMEOUT)); -- 加过期时间
	pItem.Sync();  	
	
	local nTaskGroup 	= tonumber(pItem.GetExtParam(1));
	local nTaskId		= tonumber(pItem.GetExtParam(2));
	local nNum			= self:SetPresentTypeFlag(0, nPresentType);
	if nTaskId ~= 0 and nTaskGroup ~= 0 then
		me.SetTask(nTaskGroup, nTaskId, nNum);
	end
	if tbInfo[self.INDEX_TASKGROUP] ~= 0 and tbInfo[self.INDEX_TASKID] ~= 0 then
		me.SetTask(tbInfo[self.INDEX_TASKGROUP], tbInfo[self.INDEX_TASKID], GetTime());
	end
	Dbg:WriteLog("PresendCard",  "OnGetAward", me.szName,  string.format("激活了%s礼包，并获得了大礼包一份", tbInfo[self.INDEX_NAME]));
end

function PresendCard:SetPresentTypeFlag(nResult, nPresentType)
	local nTempA = math.floor(nPresentType / 16);
	local nTempB = math.fmod(nPresentType, 16);
	local nResult = KLib.SetByte(nResult, 4, nTempB);
	nResult = KLib.SetByte(nResult, 3, nTempA);
	return nResult;
end

function PresendCard:GetPresentTypeFlag(nFlag)
	local nTempA = KLib.GetByte(nFlag, 3);
	local nTempB = KLib.GetByte(nFlag, 4);
	local nResult = nTempB + nTempA * 16;
	return nResult;
end

function PresendCard:_SetTestFlag(nPresentType, nFlag)
	self._FLAG_TEST[nPresentType] = nFlag;
	return;
end

function PresendCard:_GetTestFlag(nPresentType)
	return self._FLAG_TEST[nPresentType] or 0;
end


function PresendCard:CmpGateWay(nPresentType)
	local szWay = self.PRESEND_TYPE[nPresentType][self.INDEX_GATEWAYLIMIT];
	if not szWay then
		return 1;
	end
	
	local szGate =  GetGatewayName();	
	local bSuit = 0;
	local tbWay = Lib:SplitStr(szWay);
	for _, szStr in ipairs(tbWay) do
		if szGate == szStr then
			bSuit = 1;
			break;
		end
	end
	return bSuit;
end






--BUF 相关
function PresendCard:GetGblBuf()
	local tbBuf = GetGblIntBuf(GBLINTBUF_PRESENDCARD, 0, 1);
	if tbBuf and type(tbBuf)=="table"  then
		self.tbGblBuf = tbBuf;
	end
	if not self.tbGblBuf then
		self.tbGblBuf = {};
	end
	return self.tbGblBuf;	
end

function PresendCard:ReLoadBuf()
	if not self.PRESEND_TYPE_BAK then	
	 	self.PRESEND_TYPE_BAK = Lib:CopyTB1(self.PRESEND_TYPE);
	 end

	local tbBuf = self:GetGblBuf();

	self.PRESEND_TYPE = Lib:CopyTB1(self.PRESEND_TYPE_BAK);
	for nType, tbInfo in pairs(tbBuf) do
		self.PRESEND_TYPE[nType] = tbInfo;
	end	
end

ServerEvent:RegisterServerStartFunc(PresendCard.ReLoadBuf, PresendCard);