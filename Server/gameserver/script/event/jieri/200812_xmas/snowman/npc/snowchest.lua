-- �ļ�������snowball.lua
-- �����ߡ���zounan
-- ����ʱ�䣺2009-11-24 14:35:26
-- ��  ��  ��
local tbNpc = Npc:GetClass("snowchest");

SpecialEvent.Xmas2008 = SpecialEvent.Xmas2008 or {};
SpecialEvent.Xmas2008.XmasSnowman = SpecialEvent.Xmas2008.XmasSnowman or {};
local XmasSnowman = SpecialEvent.Xmas2008.XmasSnowman;

function tbNpc:OnDialog()
    local tbEvent = 
	{
		Player.ProcessBreakEvent.emEVENT_MOVE, 
		Player.ProcessBreakEvent.emEVENT_ATTACK,
		Player.ProcessBreakEvent.emEVENT_SITE,
		Player.ProcessBreakEvent.emEVENT_USEITEM,
		Player.ProcessBreakEvent.emEVENT_ARRANGEITEM,
		Player.ProcessBreakEvent.emEVENT_DROPITEM,
		Player.ProcessBreakEvent.emEVENT_SENDMAIL,
		Player.ProcessBreakEvent.emEVENT_TRADE,
		Player.ProcessBreakEvent.emEVENT_CHANGEFIGHTSTATE,
		Player.ProcessBreakEvent.emEVENT_CLIENTCOMMAND,
		Player.ProcessBreakEvent.emEVENT_LOGOUT,
		Player.ProcessBreakEvent.emEVENT_DEATH,
		Player.ProcessBreakEvent.emEVENT_ATTACKED,
	}
	GeneralProcess:StartProcess("�����ɼ���..." , XmasSnowman.CHEST_CATCHTIME * Env.GAME_FPS ,  {self.CatchSnow , self,him.dwId} , nil , tbEvent);	
end

function tbNpc:CatchSnow(nNpcId)
	local pNpc = KNpc.GetById(nNpcId);
	if not pNpc then
		return;
	end	


	if me.CountFreeBagCell() < 1 then
		me.Msg("���İ����ռ䲻��");
		return;
	end	

	local pItem = me.AddItem(unpack(XmasSnowman.BOX_ID));
	if pItem then
		pItem.Bind(1);
		me.SetItemTimeout(pItem, 30*24*60, 0);
			--���Ӽ���״̬
		me.AddSkillState(385, 7, 2, 60 * 60 * Env.GAME_FPS, 1, 0, 1);
		me.AddSkillState(386, 7, 2, 60 * 60 * Env.GAME_FPS, 1, 0, 1);
		me.AddSkillState(387, 7, 2, 60 * 60 * Env.GAME_FPS, 1, 0, 1);
		--����ֵ880, 4,����־���879, 5
		me.AddSkillState(880, 4, 2, 60 * 60 * Env.GAME_FPS, 1, 0, 1);
		me.AddSkillState(879, 8, 2, 60 * 60 * Env.GAME_FPS, 1, 0, 1);
	end
	pNpc.Delete();
end