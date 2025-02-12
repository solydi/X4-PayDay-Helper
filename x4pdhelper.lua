script_name("{ff7e14}x4 PayDay Helper by solodi")
script_author("{ff7e14}solodi")
script_description('Скрипт предназначен для ') 

--[[
Вы получили — X4 PayDay (осталось 0 PayDay)
[20:28:29] [Талон]{ffffff} Вы успешно активировали предмет!
[20:28:29] [Талон]{ffffff} Теперь на протяжении {6053F3}12 часов (24 PayDay){ffffff} Вы будете получать {6053F3}Х4 PayDay{ffffff}!
[20:28:29] [Талон]{ffffff} Срок действия указан в {6053F3}/stats{ffffff}!
Вы получили — X4 PayDay (осталось 17 PayDay)
]]
require "lib.moonloader"
local sampev = require "lib.samp.events"

local scriptstate = true
local cubetdid, usetdid, closetdid = "", "", ""

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end

	sampAddChatMessage("{F48B8C}[INFO] {ffffff}Скрипт {ff7e14}'x4 PayDay Helper' {ffffff}загружен! Автор: {ff7e14}solodi", -1)

	sampRegisterChatCommand("x4", function()
		scriptstate = not scriptstate
		sampAddChatMessage("{73B461}[Информация] {ffffff}PayDay Helper is {fffa00}" .. tostring(scriptstate), -1)
	end)

	sampRegisterChatCommand("usetalon", function()
		lua_thread.create(function()
			sampSendChat("/invent")
			wait(1500)
			sampSendClickTextdraw(cubetdid)
			wait(1500)
			sampSendClickTextdraw(usetdid)
			wait(1500)
			sampSendClickTextdraw(closetdid)
		end)
	end)

	while true do
		wait(0)
	end
end
--			  ( ) . % + - * ? [ ^ $
function sampev.onServerMessage(color, text)
	if text:match("Вы получили — X4 PayDay %(осталось 0 PayDay%)") then
		sampAddChatMessage("{ff0000}x4 PayDay is over", -1)
		lua_thread.create(function()
			sampSendChat("/invent")
			wait(1500)
			sampSendClickTextdraw(cubetdid)
			wait(1500)
			sampSendClickTextdraw(usetdid)
			wait(1500)
			sampSendClickTextdraw(closetdid)
		end)
	end
end

function sampev.onShowTextDraw(id, data)
	if math.floor(data.position.x) == 610 and math.floor(data.position.y) == 132 then cubetdid = id end
	if math.floor(data.position.x) == 603 and math.floor(data.position.y) == 148 then usetdid = id end
	if math.floor(data.position.x) == 593 and math.floor(data.position.y) == 331 then closetdid = id end
end