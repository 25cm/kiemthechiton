-------------------------------------------------------------------
--File: 	define.lua
--Author: sunduoliang
--Date: 	2008-4-15
--Describe:	�����ϵͳ
--InterFace1:��ǰ����.
--InterFace2:
--InterFace3:
-------------------------------------------------------------------


EventManager.EventManager 		= EventManager.EventManager or {};
EventManager.Event 				= EventManager.Event or {};
EventManager.EventNpc 			= EventManager.EventNpc or {};
EventManager.EventPart 			= EventManager.EventPart or {};
EventManager.EventKindBase 		= EventManager.EventKindBase or {};
EventManager.EventKind 			= EventManager.EventKind or {};
EventManager.EventKind.ExClass 	= EventManager.EventKind.ExClass or {};
EventManager.EventKind.Module 	= EventManager.EventKind.Module or {};

EventManager.tbFun 				= EventManager.tbFun or {};			--���ú�����
EventManager.ExEvent			= EventManager.ExEvent or {};		--������Ա�
EventManager.KingEyes			= EventManager.KingEyes or {};		--��Ӫ֧��

Require("\\script\\event\\manager\\base.lua");
Require("\\script\\event\\manager\\eventpart.lua");
Require("\\script\\event\\manager\\event.lua");
Require("\\script\\event\\manager\\manager.lua");

EventManager.TASK_GROUP_ID 		= 2026;	--��������Group(1-50Ϊ����ָ���������ʹ�ã�ʹ���ظ����Σ������������գ�)
EventManager.TASK_PACTH_GROUP_ID= 2096;	--��������Group���α�
EventManager.EVENT_TABLE 		= "\\setting\\event\\manager\\event.txt";
EventManager.EVENT_BASE_PATH    = "\\setting\\event\\manager\\";
EventManager.EVENT_CLOSE_DATE 	= -3;	--�رջ,
EventManager.EVENT_TIMER_DATE_RSTART 	= -2;	--Ԥ������,
EventManager.EVENT_TIMER_DATE_START 	= -1;	--���ϻ,
EventManager.EVENT_PARAM_MAX 	= 25;	--��չ���������

EventManager.AWARD_TYPE_ITEM1 	= 0;	--�������ͣ����У�
EventManager.AWARD_TYPE_ITEM2 	= 1;	--�������ͣ����Ͻ�����
EventManager.AWARD_TYPE_MAREIAL = 2;	--�����������

EventManager.TIME_MAX_MAINTAIN = 46800;		--��ʱ�����ʱ���� ��
EventManager.KIND_CALLBOSS_GC	= 1;	--GC����ִ������,gc�����ٻ�npc.

EventManager.DIALOG_CLOSE = "�����Ի�";	--�Ի��������.ͳһ�ӿڲ���,���