Citizen.CreateThread(function ()
  ESX = nil
  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
  
  local restartTime = 14400 -- in seconds, must match batch file
  local hour = 3600 -- 3600
  local sleep = restartTime - hour
  local notifiedHour = false
  local notified30Min = false
  local notified10Min = false
  local notified1Min = false

  while true do
    Wait(sleep*1000)
    sleep = 1
    local serverTime = math.floor(os.clock())
    if not notifiedHour and serverTime > (restartTime - hour) then
      notifiedHour = true
      TriggerClientEvent('chatMessage', -1, "SERVER BOT", {255, 0, 0}, 'SERVER RESTART IN 1 HOUR')
    elseif not notified30Min and serverTime > (restartTime - (hour/2)) then
      notified30Min = true
      TriggerClientEvent('chatMessage', -1, "SERVER BOT", {255, 0, 0}, 'SERVER RESTART IN 30 MINUTES')
    elseif not notified10Min and serverTime > (restartTime - (hour/6)) then
      notified10Min = true
      TriggerClientEvent('chatMessage', -1, "SERVER BOT", {255, 0, 0}, 'SERVER RESTART IN 10 MINUTES')
    elseif not notified1Min and serverTime > (restartTime - (hour/30)) then
      notified1Min = true
      TriggerClientEvent('chatMessage', -1, "SERVER BOT", {255, 0, 0}, 'SERVER RESTART IN 2 MINUTES. Remember to restart FiveM before relogging.')
    elseif serverTime >= (restartTime - 5) then
      sleep = 2.5
      
      StopResource('enc0ded-persistent-vehicles')
      
      TriggerClientEvent('chatMessage', -1, "SERVER BOT", {255, 0, 0}, 'SERVER RESTARTING....')
      Wait(1500)
      local remainingPlayers = ESX.GetPlayers()
      for _, player in pairs(remainingPlayers) do
          DropPlayer(player, 'SERVER RESTARTING... PLEASE RELOG IN 30 SECONDS')
      end
    end
  end
end)