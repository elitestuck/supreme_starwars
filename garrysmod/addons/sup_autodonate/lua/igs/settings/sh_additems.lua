/***  ----------------------------------------------------------------------  ***
	Документацию по всем доступным методам можно посмотреть в файле documentation.txt
	Там написано много интересных и полезных методов, не ленитесь открыть

	Если демонстрационных итемов для настройки автодоната недостаточно
	- свяжитесь с нами и мы вам оперативно поможем: https://vk.com/im?sel=-143836547

	Не забудьте раскомментировать блок кода, чтобы настройки заработали
	Для этого нужно убрать "--" перед нужными строками.
	Если не знаете, как это сделать - напишите нам

	ДЛЯ ОПЫТНЫХ ПОЛЬЗОВАТЕЛЕЙ пример конфигурации автодоната на TRIGON.IM:
	https://gist.github.com/284608002faf5ff10525874b0225801e
***  -------------------------------------------------------------------------  ***/

прочтите_то_что_написано_выше = !!!ОБЯЗАТЕЛЬНО

/****************************************************************************
	Разрешаем покупать отмычку только донатерам (DarkRP)
	Доступ навсегда за 1 рубль
	https://img.qweqwe.ovh/1493244432112.png -- частичное объяснение
****************************************************************************/

local IGS_CAT_SETS    = "Набор прав"
local IGS_PS2_SETS    = "Pointshop"
local IGS_CAT_LVL     = "Система уровней"
local GS_CAT_JEDI     = "Основной Донат"
local GS_CAT_MONEY     = "Игровая Валюта"

/****************************************************************************
	Игровая валюта для DarkRP
	Срок нет смысла указывать
	Для удобства суммы объединены в группу (Не категорию)
****************************************************************************/
local GROUP = IGS.NewGroup("Игровая Валюта")
local STORE_ITEM = FindMetaTable("IGSItem")
function STORE_ITEM:SetMetaMoney(iSum)
	self:SetDescription("Мгновенно и без проблем пополняет баланс игровой валюты на " .. string.Comma(iSum) .. " валюты")
	self:SetOnActivate(function(pl) pl:AddMoney(iSum) end)
	self:SetStackable(true) -- а нужно?

	self.dpr_money = iSum
	return self
end


GROUP:AddItem(
 	IGS("50000 РК", "150k_deneg"):SetMetaMoney(20000)
 	:SetPrice(199) -- 299 руб
)

GROUP:AddItem(
 	IGS("100000 РК", "200k_deneg"):SetMetaMoney(100000)
 	:SetPrice(299) -- 499 руб
)

GROUP:AddItem(
 	IGS("450000 РК", "500k_deneg"):SetMetaMoney(450000)
 	:SetPrice(499) -- 699 руб
)

--[[-------------------------------------------------------------------------
	Группы прав
---------------------------------------------------------------------------]]
local superadmin_description = [[
ВАЖНО!

Весь донат - это прежде всего пожертвование, это значит то, что администрация может отобрать привелегии без объяснения причины
Так же ваши привелегии и сам донат может меняться в зависимости от нужд сервера.

С повышением привелегий, повышаются бонусы за них, выделяемость на фоне остальных, доступ к админским командам и проведениям ивентов. Также Аполлион и Таумиель доступны 3 персонажа вместо двух стандартных

Возможности:
Доступ к Республиканский Дроид, Сенатор

Республиканский Дроид создан для тех, кто любит РП составляющее.
Астромеханики, протокольные дроиды - всё для любителей починки и бибиканья

Вуки - Сильный Воин Кашиика. Имеет Арбалет, большую выносливость и прекрасные
голосовые связки, благодаря которым вас никто не будет понимать
]]

local owner_description = [[
ВАЖНО!

Весь донат - это прежде всего пожертвование, это значит то, что администрация может отобрать привелегии без объяснения причины
Так же ваши привелегии и сам донат может меняться в зависимости от нужд сервера.

С повышением привелегий, повышаются бонусы за них, выделяемость на фоне остальных, доступ к админским командам и проведениям ивентов. Также Аполлион и Таумиель доступны 3 персонажа вместо двух стандартных

Возможности:
KETER + Наёмник

- Полёт
- Невидимость
- Бессмертие
- Регулирование НПЦ
- Изменение модели
- Выдача предупреждений в случае нарушений
- Слежка

]]
local afina_description = [[
ВАЖНО!

Весь донат - это прежде всего пожертвование, это значит то, что администрация может отобрать привелегии без объяснения причины
Так же ваши привелегии и сам донат может меняться в зависимости от нужд сервера.

С повышением привелегий, повышаются бонусы за них, выделяемость на фоне остальных, доступ к админским командам и проведениям ивентов. Также Аполлион и Таумиель доступны 3 персонажа вместо двух стандартных

Возможности:
AFINA + Элитный Республиканский Коммандос

Элитный республиканские коммандос — клон-солдат Республиканской армии, обученный для проведения особо важных специальных операций.
Большое количество вооружения, выносливость и наличие большой кастомизации персонажа

- Полёт
- Невидимость
- Бессмертие
- Регулирование НПЦ
- Изменение модели
- Выдача предупреждений в случае нарушений
- Все виды телепортаций
- Кик
- Слежка
]]
local thaumiel_description = [[
ВАЖНО!

Весь донат - это прежде всего пожертвование, это значит то, что администрация может отобрать привелегии без объяснения причины
Так же ваши привелегии и сам донат может меняться в зависимости от нужд сервера.

С повышением привелегий, повышаются бонусы за них, выделяемость на фоне остальных, доступ к админским командам и проведениям ивентов. Также Аполлион и Таумиель доступны 3 персонажа вместо двух стандартных

Возможности:
THAUMIEL + Коммандос

Республиканский Коммандос имеет большое кол-во продвинутого вооружения
Республики, Броню класса "Катарн", а также прекрасный вид. Ну вы посмотрите на этого Красавца!

- Полёт
- Невидимость
- Бессмертие
- Регулирование НПЦ
- Изменение модели
- Выдача предупреждений в случае нарушений
- Все виды телепортаций
- Кик + Бан
- Слежка
- Возможность помогать в проведении ивентов, а после, с разрешения модераторов, проводить ивенты самому
]]
local pers_description = [[
ВАЖНО!

Весь донат - это прежде всего пожертвование, это значит то, что администрация может отобрать привелегии без объяснения причины
Так же ваши привелегии и сам донат может меняться в зависимости от нужд сервера.

При создании своей личной профессии вы выбираете вооружение (макс. 6 слотов) и основа, на которой он будет создан

Основа: Коммандос (Будете приписаны к РК) + Броня и HP или ЭРК (Будете приписаны к ЭРК) + Броня и HP
Также есть нулевая основа, там вы действуете сами по себе, но будет трудно с повышениями а также у вас будет стандартное кол-во HP и Брони

ВАЖНО! При покупки модели обратитесь к продавцу за информацией по доступным моделям!

]]
local pers4_description = [[
ВАЖНО!

Весь донат - это прежде всего пожертвование, это значит то, что администрация может отобрать привелегии без объяснения причины
Так же ваши привелегии и сам донат может меняться в зависимости от нужд сервера.

При создании своей личной профессии вы обсуждаете всю информациб с главой ордена джедаев или высшими рыцарями

ВАЖНО! При покупки модели обратитесь к продавцу за информацией по доступным моделям!

]]

local pers1_description = [[
ВАЖНО!

Весь донат - это прежде всего пожертвование, это значит то, что администрация может отобрать привелегии без объяснения причины
Так же ваши привелегии и сам донат может меняться в зависимости от нужд сервера.

При создании своего отряда вы должны выбрать дополнительное оружие для профессий, а также кол-во участников отряда.

Размер отряда: 3-5 в зависимости от желания покупателя

(Макс. Оружия: 8)

]]

local pers2_description = [[
ВАЖНО!

Весь донат - это прежде всего пожертвование, это значит то, что администрация может отобрать привелегии без объяснения причины
Так же ваши привелегии и сам донат может меняться в зависимости от нужд сервера.

При покупке персонажа вы обязаны выбрать роли из доступных

Охотник - командир отряда
Прицельщик - снайпер
Тех - взломщик и сапер
Крушила - тяжелый боец

]]
local pers3_description = [[
ВАЖНО!

Весь донат - это прежде всего пожертвование, это значит то, что администрация может отобрать привелегии без объяснения причины
Так же ваши привелегии и сам донат может меняться в зависимости от нужд сервера.

Данный товар позволит вам стать сюжетным клоном в своем боевом подразделении

Список персонажей 104-го
Буст
Комет
Синкер
Даш
СплиттерМортер
Вартог
ВилдФайр

Список персонажей 501-го
Кикс
Пятерня
Хардкейс
Джесси
Эхо
Догма
Бумер

Список персонажей Охраны
Джек
Хаунд
Рис
Стоун
Тайр

]]
local leg_description = [[
ВАЖНО!

Весь донат - это прежде всего пожертвование, это значит то, что администрация может отобрать привелегии без объяснения причины
Так же ваши привелегии и сам донат может меняться в зависимости от нужд сервера.

Создание своего личного подразделения на основе уже существующих подразделений

Доступно:
212
41
9
187
Зеленая Рота
Рота Парджай

При покупке вы должны проинформировать продавца что именно вы хотите добавить в легион (Оружие, дополнительные предметы)
]]

local jedi_description = [[

Энакин Скайуокер
Шаак Ти
Асока Тано
Баррис Оффи
Луминара Ундули
Типлар
Типли
Сэси Тиин
Айма-Ган Дай
Иит Кот
Квинлан Вос
Кит Фисто
Пло Кун
Мэйс Винду
Ади Галлия
Эйла Секура
Ки-Ади Мунди
Йода
]]

for group,t in pairs({
	-- ["euclid"] = {
	-- 	name  = "Евклид",
	-- 	alias = "EUCLID",
	-- 	desc  = superadmin_description,
	-- 	image = "https://i.ibb.co/zZc0KBL/euclid1.jpg",
	-- 	icon =  "https://i.ibb.co/q53Jqkd/EUCLID.jpg",
	-- 	weight = 2,
	-- 	{149,30}, -- 50
	-- 	{299}, -- 200
	-- },
	["keter"] = {
		name   = "Кетер",
		alias  = "KETER",
		desc   = superadmin_description,
		image  = "https://i.ibb.co/vxSctXw/keter1.jpg",
		icon   = "https://i.ibb.co/VmPdSrV/KETER.jpg",
		weight = 3,
		{399}, -- 500
	},
	["afina"] = {
		name   = "Афина",
		alias  = "AFINA",
		desc   = owner_description,
		image  = "https://i.ibb.co/ypnQpfd/afina1.jpg",
		icon   = "https://i.ibb.co/sq9fJPt/AFINA.jpg",
		weight = 4,
		{699}, -- 800
	},
	["thaumiel"] = {
		name   = "Таумиель",
		alias  = "THAUMIEL",
		desc   = afina_description,
		image  = "https://i.ibb.co/kB6qfV8/thaumiel.jpg",
		icon   = "https://i.ibb.co/DLKhnnD/THAUMIEL.jpg",
		weight = 5,
		{999}, -- 1100
	},
	["apollo"] = {
		name   = "Аполлион",
		alias  = "APOLLO",
		desc   = thaumiel_description,
		image  = "https://i.ibb.co/1q7r35H/apollo1.jpg",
		icon   = "https://i.ibb.co/sVR1PG3/APPOLION.jpg",
		weight = 6,
		{1499}, -- 1500
	},
	-- ["jedi"] = {
	-- 	name  = "Орден Джедаев",
	-- 	alias = "Покупка Джедая",
	-- 	desc  = jedi_description,
	-- 	weight = 1,
	-- 	image  = "https://i.ibb.co/nmy9Szf/12232sa.jpg",
	-- 	{1299}, -- 600
	-- },
	["leg"] = {
		name  = "Собственный Легион",
		alias = "создай свою историю на сервере",
		image  = "https://i.ibb.co/R42sTnD/122sa.jpg",
		desc  = leg_description,
		weight = 1,
		{6499}, -- 600
	},
	["pers"] = {
		name  = "Свой Персонаж",
		alias = "выделись на фоне остальных",
		desc  = pers_description,
		image  = "https://i.ibb.co/ZKFnPx1/1sa.jpg",
		weight = 1,
		{1499}, -- 600
	},
	-- ["pers4"] = {
	-- 	name  = "Свой Джедай",
	-- 	alias = "выделись на фоне остальных",
	-- 	desc  = pers4_description,
	-- 	image  = "https://i.ibb.co/ZKFnPx1/1sa.jpg",
	-- 	weight = 1,
	-- 	{1899}, -- 600
	-- },
	["pers1"] = {
		name  = "Свой Отряд",
		alias = "создай семейку",
		desc  = pers1_description,
		image  = "https://i.ibb.co/Bsfg2JC/sq.jpg",
		weight = 1,
		{4999}, -- 600
	},
	["pers2"] = {
		name  = "Отряд Клонов 99",
		alias = "#clonewarssaved",
		desc  = pers2_description,
		image  = "https://i.ibb.co/F0FjFdY/991.jpg",
		weight = 1,
		{1199}, -- 600
	},
	["pers23"] = {
		name  = "Лорный Клон",
		alias = "Воплоти действия персонажей сериала на сервере!",
		desc  = pers3_description,
		image  = "https://i.ibb.co/61xWk5B/m-BMc345pgq.jpg",
		weight = 1,
		{249}, -- 600
	},
}) do
	local GROUP = IGS.NewGroup(t["name"])
	GROUP:SetIcon(t["icon"])

	for _,v in ipairs(t) do
	local ITEM = IGS(t["name"],"group_" .. group .. "_" .. (v[2] or "~") .. "d") -- group_premium_15d
		:SetPrice(v[1])
		:SetTerm(v[2])
		:SetCategory(IGS_CAT_SETS)
		:SetDescription(t["desc"])
		:SetIcon(t["icon"])
		:SetImage(t["image"])
		:SetOnActivate(function(pl)
			serverguard.player:SetRank(pl, group, 0, true)
			pl.IGSSGWeight = t["weight"]
		end)
		:SetValidator(function(pl)
			if pl.IGSSGWeight then
				return t["weight"] < pl.IGSSGWeight
			else
				return serverguard.player:GetRank(pl) == group, true
			end
		end)

	GROUP:AddItem(ITEM,t["alias"])
	end
end
