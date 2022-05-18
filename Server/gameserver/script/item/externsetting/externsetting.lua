
-- 装备，外部配置Văn kiện接口

------------------------------------------------------------------------------------------
-- initialize

Item.tbExternSetting = {};

local tbExternSetting = Item.tbExternSetting;

tbExternSetting.TABFILE_CLASSLIST	= "classlist.txt"

tbExternSetting.tbClass		= {};
tbExternSetting.tbClassBase	= {};

------------------------------------------------------------------------------------------
-- interface

function tbExternSetting:Load(szPath)

	local szClassList = szPath.."\\"..self.TABFILE_CLASSLIST;
	local pTabFile = KIo.OpenTabFile(szClassList);
	if (not pTabFile) then
		print("Văn kiện"..szClassList.."Không mở được!");
		return	0;
	end

	local tbContent = pTabFile.AsTable();
	local bRet = 1;

	for i = 1, #tbContent do
		local szClass = tbContent[i][1];
		if szClass and ("" ~= szClass) then
			local tbClass = self:GetClass(szClass, 1);
			if (not tbClass) then
				print("Loại thiết lập bên ngoài vô hiệu: "..szClass);
				bRet = 0;
			elseif (1 ~= tbClass:Load(szPath.."\\"..szClass.."\\")) then
				print("Đọc loại thiết lập "..szClass.." thất bại!");	-- added by dengyong  20100201
				bRet = 0;
			end
		end
	end

	KIo.CloseTabFile(pTabFile);
	return	bRet;

end

------------------------------------------------------------------------------------------
-- private

function tbExternSetting.tbClassBase:Load(szDir)
	return	0;
end

function tbExternSetting:GetClass(szClassName, bNotCreate)
	local tbClass = self.tbClass[szClassName];
	if (not tbClass) and (bNotCreate ~= 1) then		-- 如果没有bNotCreate，当找不到指定模板时会自动建立新模板
		tbClass	= Lib:NewClass(self.tbClassBase);
		self.tbClass[szClassName] = tbClass;
	end
	return tbClass;
end
