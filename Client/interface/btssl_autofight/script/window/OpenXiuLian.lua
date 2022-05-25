--耍耍制作简化通用版。

function AutoAi:OpenXiuLian()
	local tbFind = me.FindItemInBags(18, 1, 16, 1);
	local pItem = tbFind[1].pItem;
	if (not pItem) then
		me.Msg("额，没带修炼珠！")
		return 0;
	end

	local tbItem = Item:GetClass("xiulianzhu");
	local nRemain = tbItem:GetRemainTime();

	if (nRemain < 0.5) then
--		me.Msg("修炼珠剩余时间不够");
		return;
	end
	me.UseItem(pItem);
	local function fnSelect()
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then		
			local szQuestion, tbAnswers = UiCallback:GetQuestionAndAnswer();
			for i, tbInfo in ipairs(tbAnswers) do
				if string.find(tbInfo, "我要开启修炼") or string.find(tbInfo, "我想看看其他功能") then
					me.AnswerQestion(i -1);
				end
			end
		end
			local function myopen()
				if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then		
					local szQuestion, tbAnswers = UiCallback:GetQuestionAndAnswer();
					for i, tbInfo in ipairs(tbAnswers) do
						if string.find(tbInfo, "我要开启修炼") or string.find(tbInfo, "我要开启0.5小时") then
							me.AnswerQestion(i -1);
						end
					end
					return 0;
				end
			end
			local function myopen1()
				if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
					me.AnswerQestion(0);
				end
				return 0;
			end

			local function myclose()
				UiManager:CloseWindow(Ui.UI_SAYPANEL);
				return 0;
			end

		Ui.tbLogic.tbTimer:Register(12, myopen);	-- 延迟选择
		Ui.tbLogic.tbTimer:Register(28, myopen1);	-- 延迟选择
		Ui.tbLogic.tbTimer:Register(44, myclose);	-- 延迟关窗口
		return 0;
	end
	Ui.tbLogic.tbTimer:Register(8, fnSelect);
end
