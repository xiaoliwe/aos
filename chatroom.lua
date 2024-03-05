Balances = Balances or {}

Handlers.add(
    "Register",
    Handlers.utils.hasMatchingTag("Action", "Register"),
    function (msg)
      table.insert(Members, msg.From)
      Handlers.utils.reply("registered")(msg)
    end
  )

Handlers.add(
    "broadcast",
    Handlers.utils.hasMatchingTag("Action", "Broadcast"),
    function(m)
        local balance_check = tonumber(Balances[m.From])
        if (not balance_check) or balance_check < 1 then
            print("UNAUTH REQ: " .. m.From)
            --Handlers.utils.reply("No balance")(m)
            return
        end
        -- local type = m.Type or "Normal"
        print("Broadcasting message from " .. m.From .. ". Content: " .. m.Data)
        for _, recipient in ipairs(Members) do
            print(recipient)
            ao.send({
                Target = recipient,
                Nickname = recipient,
                Action = "Broadcasted",
                Broadcaster = m.From,
                --Nickname = Members[i],
                --Broadcaster = m.From,
                Data = m.Data
            })
        end
    end
)