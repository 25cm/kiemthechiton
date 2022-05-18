


local tbPlanItem = Item:GetClass("planitem");

tbPlanItem.ID_TABLE =
{
	[111]	= { 111, 221 },
	[112]	= { 112, 222 },
	[113]	= { 113, 223 },
	[114]	= { 114, 224 },
	[115]	= { 115, 225 },
	[116]	= { 116, 226 },
	[117]	= { 117, 227 },
	[118]	= { 118, 228 },
	[119]	= { 119, 229 },
	[120]	= { 120, 230 },

	[141]	= { 141, 231 },
	[142]	= { 142, 232 },
	[143]	= { 143, 233 },
	[144]	= { 144, 234 },
	[145]	= { 145, 235 },
	[146]	= { 146, 236 },
	[147]	= { 147, 237 },
	[148]	= { 148, 238 },
	[149]	= { 149, 239 },
	[150]	= { 150, 240 },

	[391]	= { 391, 431, 471, 511 },
	[392]	= { 392, 432, 472, 512 },
	[393]	= { 393, 433, 473, 513 },
	[394]	= { 394, 434, 474, 514 },
	[395]	= { 395, 435, 475, 515 },
	[396]	= { 396, 436, 476, 516 },
	[397]	= { 397, 437, 477, 517 },
	[398]	= { 398, 438, 478, 518 },
	[399]	= { 399, 439, 479, 519 },
	[400]	= { 400, 440, 480, 520 },
	[401]	= { 401, 441, 481, 521 },
	[402]	= { 402, 442, 482, 522 },
	[403]	= { 403, 443, 483, 523 },
	[404]	= { 404, 444, 484, 524 },
	[405]	= { 405, 445, 485, 525 },
	[406]	= { 406, 446, 486, 526 },
	[407]	= { 407, 447, 487, 527 },
	[408]	= { 408, 448, 488, 528 },
	[409]	= { 409, 449, 489, 529 },
	[410]	= { 410, 450, 490, 530 },

	[891]	= { 891, 931, 971, 1011 },
	[892]	= { 892, 932, 972, 1012 },
	[893]	= { 893, 933, 973, 1013 },
	[894]	= { 894, 934, 974, 1014 },
	[895]	= { 895, 935, 975, 1015 },
	[896]	= { 896, 936, 976, 1016 },
	[897]	= { 897, 937, 977, 1017 },
	[899]	= { 899, 939, 979, 1019 },
	[900]	= { 900, 940, 980, 1020 },
	[901]	= { 901, 941, 981, 1021 },
	[902]	= { 902, 942, 982, 1022 },
	[903]	= { 903, 943, 983, 1023 },
	[904]	= { 904, 944, 984, 1024 },
	[905]	= { 905, 945, 985, 1025 },
	[906]	= { 906, 946, 986, 1026 },
	[907]	= { 907, 947, 987, 1027 },
	[908]	= { 908, 948, 988, 1028 },
	[909]	= { 909, 949, 989, 1029 },
	[910]	= { 910, 950, 990, 1030 },

	[101]	= { 101, 131, 161, 181, 261 },
	[102]	= { 102, 132, 162, 182, 262 },
	[103]	= { 103, 133, 163, 183, 263 },
	[104]	= { 104, 134, 164, 184, 264 },
	[105]	= { 105, 135, 165, 185, 265 },
	[106]	= { 106, 136, 166, 186, 266 },
	[107]	= { 107, 137, 167, 187, 267 },
	[108]	= { 108, 138, 168, 188, 268 },
	[109]	= { 109, 139, 169, 189, 269 },
	[110]	= { 110, 140, 170, 190, 270 },

	[121]	= { 121, 171, 201, 241, 281 },
	[122]	= { 122, 172, 202, 242, 282 },
	[123]	= { 123, 173, 203, 243, 283 },
	[124]	= { 124, 174, 204, 244, 284 },
	[125]	= { 125, 175, 205, 245, 285 },
	[126]	= { 126, 176, 206, 246, 286 },
	[127]	= { 127, 177, 207, 247, 287 },
	[128]	= { 128, 178, 208, 248, 288 },
	[129]	= { 129, 179, 209, 249, 289 },
	[130]	= { 130, 180, 210, 250, 290 },

	[191]	= { 191, 211, 251, 271, 291 },
	[192]	= { 192, 212, 252, 272, 292 },
	[193]	= { 193, 213, 253, 273, 293 },
	[194]	= { 194, 214, 254, 274, 294 },
	[195]	= { 195, 215, 255, 275, 295 },
	[196]	= { 196, 216, 256, 276, 296 },
	[197]	= { 197, 217, 257, 277, 297 },
	[198]	= { 198, 218, 258, 278, 298 },
	[199]	= { 199, 219, 259, 279, 299 },
	[200]	= { 200, 220, 260, 280, 300 },

	[331]	= { 331, 351, 411, 451, 491 },
	[332]	= { 332, 352, 412, 452, 492 },
	[333]	= { 333, 353, 413, 453, 493 },
	[334]	= { 334, 354, 414, 454, 494 },
	[335]	= { 335, 355, 415, 455, 495 },
	[336]	= { 336, 356, 416, 456, 496 },
	[337]	= { 337, 357, 417, 457, 497 },
	[338]	= { 338, 358, 418, 458, 498 },
	[339]	= { 339, 359, 419, 459, 499 },
	[340]	= { 340, 360, 420, 460, 500 },
	[341]	= { 341, 361, 421, 461, 501 },
	[342]	= { 342, 362, 422, 462, 502 },
	[343]	= { 343, 363, 423, 463, 503 },
	[344]	= { 344, 364, 424, 464, 504 },
	[345]	= { 345, 365, 425, 465, 505 },
	[346]	= { 346, 366, 426, 466, 506 },
	[347]	= { 347, 367, 427, 467, 507 },
	[348]	= { 348, 368, 428, 468, 508 },
	[349]	= { 349, 369, 429, 469, 509 },
	[350]	= { 350, 370, 430, 470, 510 },

	[531]	= { 531, 551, 571, 591, 611 },
	[532]	= { 532, 552, 572, 592, 612 },
	[534]	= { 534, 554, 574, 594, 614 },
	[535]	= { 535, 555, 575, 595, 615 },
	[536]	= { 536, 556, 576, 596, 616 },
	[537]	= { 537, 557, 577, 597, 617 },
	[538]	= { 538, 558, 578, 598, 618 },
	[539]	= { 539, 559, 579, 599, 619 },
	[540]	= { 540, 560, 580, 600, 620 },
	[541]	= { 541, 561, 581, 601, 621 },
	[542]	= { 542, 562, 582, 602, 622 },
	[543]	= { 543, 563, 583, 603, 623 },
	[544]	= { 544, 564, 584, 604, 624 },
	[545]	= { 545, 565, 585, 605, 625 },
	[546]	= { 546, 566, 586, 606, 626 },
	[547]	= { 547, 567, 587, 607, 627 },
	[548]	= { 548, 568, 588, 608, 628 },
	[549]	= { 549, 569, 589, 609, 629 },
	[550]	= { 550, 570, 590, 610, 630 },

	[631]	= { 631, 651, 671, 691, 711 },
	[632]	= { 632, 652, 672, 692, 712 },
	[633]	= { 633, 653, 673, 693, 713 },
	[634]	= { 634, 654, 674, 694, 714 },
	[635]	= { 635, 655, 675, 695, 715 },
	[636]	= { 636, 656, 676, 696, 716 },
	[637]	= { 637, 657, 677, 697, 717 },
	[638]	= { 638, 658, 678, 698, 718 },
	[639]	= { 639, 659, 679, 699, 719 },
	[640]	= { 640, 660, 680, 700, 720 },
	[641]	= { 641, 661, 681, 701, 721 },
	[642]	= { 642, 662, 682, 702, 722 },
	[643]	= { 643, 663, 683, 703, 723 },
	[644]	= { 644, 664, 684, 704, 724 },
	[645]	= { 645, 665, 685, 705, 725 },
	[646]	= { 646, 666, 686, 706, 726 },
	[647]	= { 647, 667, 687, 707, 727 },
	[648]	= { 648, 668, 688, 708, 728 },
	[649]	= { 649, 669, 689, 709, 729 },
	[650]	= { 650, 670, 690, 710, 730 },

	[731]	= { 731, 751, 771, 791, 811 },
	[732]	= { 732, 752, 772, 792, 812 },
	[733]	= { 733, 753, 773, 793, 813 },
	[734]	= { 734, 754, 774, 794, 814 },
	[735]	= { 735, 755, 775, 795, 815 },
	[736]	= { 736, 756, 776, 796, 816 },
	[737]	= { 737, 757, 777, 797, 817 },
	[738]	= { 738, 758, 778, 798, 818 },
	[739]	= { 739, 759, 779, 799, 819 },
	[740]	= { 740, 760, 780, 800, 820 },
	[741]	= { 741, 761, 781, 801, 821 },
	[742]	= { 742, 762, 782, 802, 822 },
	[743]	= { 743, 763, 783, 803, 823 },
	[744]	= { 744, 764, 784, 804, 824 },
	[745]	= { 745, 765, 785, 805, 825 },
	[746]	= { 746, 766, 786, 806, 826 },
	[747]	= { 747, 767, 787, 807, 827 },
	[748]	= { 748, 768, 788, 808, 828 },
	[749]	= { 749, 769, 789, 809, 829 },
	[750]	= { 750, 770, 790, 810, 830 },

	[831]	= { 831, 851, 911, 951, 991 },
	[832]	= { 832, 852, 912, 952, 992 },
	[833]	= { 833, 853, 913, 953, 993 },
	[834]	= { 834, 854, 914, 954, 994 },
	[835]	= { 835, 855, 915, 955, 995 },
	[836]	= { 836, 856, 916, 956, 996 },
	[837]	= { 837, 857, 917, 957, 997 },
	[838]	= { 838, 858, 918, 958, 998 },
	[839]	= { 839, 859, 919, 959, 999 },
	[840]	= { 840, 860, 920, 960, 1000 },
	[841]	= { 841, 861, 921, 961, 1001 },
	[842]	= { 842, 862, 922, 962, 1002 },
	[843]	= { 843, 863, 923, 963, 1003 },
	[844]	= { 844, 864, 924, 964, 1004 },
	[845]	= { 845, 865, 925, 965, 1005 },
	[846]	= { 846, 866, 926, 966, 1006 },
	[847]	= { 847, 867, 927, 967, 1007 },
	[848]	= { 848, 868, 928, 968, 1008 },
	[849]	= { 849, 869, 929, 969, 1009 },
	[850]	= { 850, 870, 930, 970, 1010 },

	[1056]	= { 1056, 1066, 1076, 1086, 1096 },
	[1057]	= { 1057, 1067, 1077, 1087, 1097 },
	[1058]	= { 1058, 1068, 1078, 1088, 1098 },
	[1059]	= { 1059, 1069, 1079, 1089, 1099 },
	[1060]	= { 1060, 1070, 1080, 1090, 1100 },
	[1061]	= { 1061, 1071, 1081, 1091, 1101 },
	[1062]	= { 1062, 1072, 1082, 1092, 1102 },
	[1063]	= { 1063, 1073, 1083, 1093, 1103 },
	[1064]	= { 1064, 1074, 1084, 1094, 1104 },
	[1065]	= { 1065, 1075, 1085, 1095, 1105 },

	[1196]	= { 1196, 1216, 1236, 1256, 1276 },
	[1197]	= { 1197, 1217, 1237, 1257, 1277 },
	[1198]	= { 1198, 1218, 1238, 1258, 1278 },
	[1199]	= { 1199, 1219, 1239, 1259, 1279 },
	[1200]	= { 1200, 1220, 1240, 1260, 1280 },
	[1201]	= { 1201, 1221, 1241, 1261, 1281 },
	[1202]	= { 1202, 1222, 1242, 1262, 1282 },
	[1203]	= { 1203, 1223, 1243, 1263, 1283 },
	[1204]	= { 1204, 1224, 1244, 1264, 1284 },
	[1205]	= { 1205, 1225, 1245, 1265, 1285 },
	[1206]	= { 1206, 1226, 1246, 1266, 1286 },
	[1207]	= { 1207, 1227, 1247, 1267, 1287 },
	[1208]	= { 1208, 1228, 1248, 1268, 1288 },
	[1209]	= { 1209, 1229, 1249, 1269, 1289 },
	[1210]	= { 1210, 1230, 1250, 1270, 1290 },
	[1211]	= { 1211, 1231, 1251, 1271, 1291 },
	[1212]	= { 1212, 1232, 1252, 1272, 1292 },
	[1213]	= { 1213, 1233, 1253, 1273, 1293 },
	[1214]	= { 1214, 1234, 1254, 1274, 1294 },
	[1215]	= { 1215, 1235, 1255, 1275, 1295 },

	[1106]	= { 1106, 1116, 1126, 1136, 1146, 1156, 1166, 1176, 1186 },
	[1107]	= { 1107, 1117, 1127, 1137, 1147, 1157, 1167, 1177, 1187 },
	[1108]	= { 1108, 1118, 1128, 1138, 1148, 1158, 1168, 1178, 1188 },
	[1109]	= { 1109, 1119, 1129, 1139, 1149, 1159, 1169, 1179, 1189 },
	[1110]	= { 1110, 1120, 1130, 1140, 1150, 1160, 1170, 1180, 1190 },
	[1111]	= { 1111, 1121, 1131, 1141, 1151, 1161, 1171, 1181, 1191 },
	[1112]	= { 1112, 1122, 1132, 1142, 1152, 1162, 1172, 1182, 1192 },
	[1113]	= { 1113, 1123, 1133, 1143, 1153, 1163, 1173, 1183, 1193 },
	[1114]	= { 1114, 1124, 1134, 1144, 1154, 1164, 1174, 1184, 1194 },
	[1115]	= { 1115, 1125, 1135, 1145, 1155, 1165, 1175, 1185, 1195 },

	[1296]	= { 1296, 1306, 1316, 1326, 1336, 1346, 1356, 1366, 1376 },
	[1296]	= { 1296, 1306, 1316, 1326, 1336, 1346, 1356, 1366, 1376 },
	[1297]	= { 1297, 1307, 1317, 1327, 1337, 1347, 1357, 1367, 1377 },
	[1298]	= { 1298, 1308, 1318, 1328, 1338, 1348, 1358, 1368, 1378 },
	[1299]	= { 1299, 1309, 1319, 1329, 1339, 1349, 1359, 1369, 1379 },
	[1300]	= { 1300, 1310, 1320, 1330, 1340, 1350, 1360, 1370, 1380 },
	[1301]	= { 1301, 1311, 1321, 1331, 1341, 1351, 1361, 1371, 1381 },
	[1302]	= { 1302, 1312, 1322, 1332, 1342, 1352, 1362, 1372, 1382 },
	[1303]	= { 1303, 1313, 1323, 1333, 1343, 1353, 1363, 1373, 1383 },
	[1304]	= { 1304, 1314, 1324, 1334, 1344, 1354, 1364, 1374, 1384 },
	[1305]	= { 1305, 1315, 1325, 1335, 1345, 1355, 1365, 1375, 1385 },
};



function tbPlanItem:OnUse()
	local nPlanId = it.GetExtParam(1);
	if (self.ID_TABLE[nPlanId]) then
		return	self:StudyRecipe(self.ID_TABLE[nPlanId]);
	else
		return self:StudyRecipe({nPlanId});
	end
end

function tbPlanItem:StudyRecipe(tbId)
	if (not tbId) then
		return 0;
	end
	local bFinish = 1;
	for _, nRecipeId in pairs(tbId) do
		if (LifeSkill:HasLearnRecipe(me, nRecipeId) == 0) then
			bFinish = 0;
		end
	end
	if (bFinish == 1) then
		me.Msg("Đã học qua, không cần học nữa!")
		return 0;
	end
	
	
	for _, nRecipeId in pairs(tbId) do
		if (LifeSkill:AddRecipe(me, nRecipeId) ~= 1) then
			self:ShowAddRecipeError();
			return 0;
		end
	end
	return 1;
end

function tbPlanItem:ShowAddRecipeError()
	me.Msg("Phải học kỹ năng sống tương ứng đẳng cấp mới dùng được Phối Phương Quyển!")
end


function tbPlanItem:GetTip()
	local szTip			= "";
	local nPlanId 		= it.GetExtParam(1);
	local nSkillId		= LifeSkill:GetBelongSkillId(nPlanId);
	local tbRecipeData	= LifeSkill.tbRecipeDatas[nPlanId];
	local tbSkillData	= LifeSkill.tbLifeSkillDatas[nSkillId];
	local tbSkillInfo	= me.GetSingleLifeSkill(nSkillId);
	local nMyLevel		= 0;
	if (tbSkillInfo) then
		nMyLevel = tbSkillInfo.nLevel;
	end
	local nNeedLevel	= tbRecipeData.SkillLevel;
	
	szTip = szTip.."Cần cấp <color=gold>"..tbSkillData.Name.."<color>";
	if (nNeedLevel > nMyLevel) then
		szTip = szTip.."<color=red> "..nNeedLevel.."<color>\n";
	else
		szTip = szTip.." "..nNeedLevel.." \n";
	end
	
	szTip = szTip.."Có thể học được phối phương:\n";
	local tbRecipeList = {};
	if (self.ID_TABLE[nPlanId]) then
		for _, recipeid in ipairs(self.ID_TABLE[nPlanId]) do
			tbRecipeList[#tbRecipeList + 1] = recipeid;
		end
	else
		tbRecipeList[#tbRecipeList + 1] = nPlanId;
	end
	
	for _, nRecipeId in ipairs(tbRecipeList) do
		local nSerise = LifeSkill.tbRecipeDatas[nRecipeId].Produce1Series;
		local szSerise = "";
		if (nSerise == 1) then
			szSerise = "(Kim)";
		elseif(nSerise == 2) then
			szSerise = "(Mộc)";
		elseif(nSerise == 3) then
			szSerise = "(Thủy)";
		elseif(nSerise == 4) then
			szSerise = "(Hỏa)";
		elseif(nSerise == 5) then
			szSerise = "(Thổ)";
		end
		szTip = szTip.."<color=0x8080ff>"..LifeSkill.tbRecipeDatas[nRecipeId].Name..szSerise.."<color>";
	end
	
	return szTip;
end