
-- 外部配置机制

-- 回调函数接口，装载外部配置
function Item:LoadExternSetting(szPath, nVersion)
	local tbSetting = self.tbExternSetting[nVersion];
	if (not tbSetting) then
		tbSetting = Lib:NewClass(self.tbExternSetting);	-- 以Item.tbExternSetting为模板
		self.tbExternSetting[nVersion] = tbSetting;
	end
	return	tbSetting:Load(szPath);
end

-- 获得指定的外部配置类
function Item:GetExternSetting(szClassName, nVersion, bAutoVersion)

	if (not nVersion) or (nVersion <= 0) or (nVersion > table.maxn(Item.tbExternSetting)) then
		if (1 ~= bAutoVersion) then						-- 如果bAutoVersion == 1则尝试使用最新版本号
			return;										-- 版本号不正确
		end
		nVersion = table.maxn(Item.tbExternSetting);	-- 默认使用最新版本计算
	end

	local tbSetting = Item.tbExternSetting[nVersion];
	if (not tbSetting) then
		print("[ITEM] T?p c?u hình c?a phiên b?n này kh?ng ???c t?i！Version:"..nVersion);
		return;
	end

	return	tbSetting:GetClass(szClassName, 1);

end
