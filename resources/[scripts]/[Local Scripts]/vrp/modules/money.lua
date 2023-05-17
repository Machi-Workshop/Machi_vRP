local lang = vRP.lang

-- Money module, wallet/bank API
-- The money is managed with direct SQL requests to prevent most potential value corruptions
-- the wallet empty itself when respawning (after death)

MySQL.createCommand("vRP/money_tables", [[
CREATE TABLE IF NOT EXISTS vrp_user_moneys(
  user_id INTEGER,
  wallet INTEGER,
  bank INTEGER,
  credit INTEGER,
  loan INTEGER,
  CONSTRAINT pk_user_moneys PRIMARY KEY(user_id),
  CONSTRAINT fk_user_moneys_users FOREIGN KEY(user_id) REFERENCES vrp_users(id) ON DELETE CASCADE
);
]])

-- 세금

MySQL.createCommand("vRP/get_tax","SELECT statecoffers FROM elysium_tax")

MySQL.createCommand("vRP/add_tax","UPDATE elysium_tax SET statecoffers = statecoffers + @statecoffers")
MySQL.createCommand("vRP/del_tax","UPDATE elysium_tax SET statecoffers = statecoffers - @statecoffers")

MySQL.createCommand("vRP/add_hi","UPDATE elysium_tax SET hi = hi + @hi")
MySQL.createCommand("vRP/delete_hi","UPDATE elysium_tax SET hi = hi - @hi")

MySQL.createCommand("vRP/add_army","UPDATE elysium_tax SET army = army + @army")
MySQL.createCommand("vRP/del_army","UPDATE elysium_tax SET army = army - @army")

-- 법인

MySQL.createCommand("vRP/add_companycapital","UPDATE elysium_company SET capital = capital + @capital WHERE user_id = @user_id")
MySQL.createCommand("vRP/del_companycapital","UPDATE elysium_company SET capital = capital - @capital WHERE user_id = @user_id")
MySQL.createCommand("vRP/get_company","SELECT code,name,capital,stockprice,stocks,salary,salary1,salary2,salary3,salary4,salary5,salary6,salary7,salary8,ceosalary FROM elysium_company WHERE user_id = @user_id")

MySQL.createCommand("vRP/money_init_user","INSERT IGNORE INTO vrp_user_moneys(user_id,wallet,bank,credit,loanlimit,loan,creditrating,exp) VALUES(@user_id,@wallet,@bank,@credit,@loanlimit,@loan,@creditrating,@exp)")
MySQL.createCommand("vRP/get_money","SELECT wallet,bank,credit,loanlimit,loan,creditrating,exp FROM vrp_user_moneys WHERE user_id = @user_id")
MySQL.createCommand("vRP/set_money","UPDATE vrp_user_moneys SET wallet = @wallet, bank = @bank, credit = @credit, loanlimit = @loanlimit, loan = @loan, creditrating = @creditrating, exp = @exp WHERE user_id = @user_id")

-- init tables
MySQL.execute("vRP/money_tables")

-- load config
local cfg = module("cfg/money")

-- API

function comma_value(amount)
  local formatted = amount
  while true do  
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return formatted
end

function vRP.getTax(cbr)
  local task = Task(cbr)
    MySQL.query("vRP/get_tax", {}, function(rows, affected)
      local tax = rows[1]
      task({tax})
    end)
end

-- 법인

function vRP.getUserCompany(user_id, cbr)
  local task = Task(cbr)

  if user_id ~= nil then
    MySQL.query("vRP/get_company", {user_id = user_id}, function(rows, affected)
      local company = rows[1]
      task({company})
    end)
  else
    task()
  end
end



-- 경험치 시스템

function vRP.getEXP(user_id)
  local tmp = vRP.getUserTmpTable(user_id)
  if tmp then
    return tmp.exp or 0
  else
    return 0
  end
end

function vRP.setEXP(user_id,value)
  local tmp = vRP.getUserTmpTable(user_id)
  if tmp then
    tmp.exp = value
  end
end

-- 대출 시스템

function vRP.getLoan(user_id)
  local tmp = vRP.getUserTmpTable(user_id)
  if tmp then
    return tmp.loan or 0
  else
    return 0
  end
end

function vRP.setLoan(user_id,value)
  local tmp = vRP.getUserTmpTable(user_id)
  if tmp then
    tmp.loan = value
  end
end

function vRP.getLoanLimit(user_id)
  local tmp = vRP.getUserTmpTable(user_id)
  if tmp then
    return tmp.loanlimit or 0
  else
    return 0
  end
end

function vRP.setLoanLimit(user_id,value)
  local tmp = vRP.getUserTmpTable(user_id)
  if tmp then
    tmp.loanlimit = value
  end
end

function vRP.getCR(user_id)
  local tmp = vRP.getUserTmpTable(user_id)
  if tmp then
    return tmp.creditrating or 0
  else
    return 0
  end
end

function vRP.setCR(user_id,value)
  local tmp = vRP.getUserTmpTable(user_id)
  if tmp then
    tmp.creditrating = value
  end
end


-- get money
-- cbreturn nil if error
function vRP.getMoney(user_id)
  local tmp = vRP.getUserTmpTable(user_id)
  if tmp then
    return tmp.wallet or 0
  else
    return 0
  end
end

-- set money
function vRP.setMoney(user_id,value)
  local tmp = vRP.getUserTmpTable(user_id)
  if tmp then
    tmp.wallet = value
  end

-- update client display
  local source = vRP.getUserSource(user_id)
  if source ~= nil then
    --기존 HUD
    --vRPclient.setDiv(source,{"money",cfg.display_css," <span class=\"symbol\"></span> "..comma_value(vRP.getMoney(user_id)).." $"})
  end
end

function vRP.getMoney(user_id)
  local tmp = vRP.getUserTmpTable(user_id)
  if tmp then
    return tmp.wallet or 0
  else
    return 0
  end
end

-- 크레딧 겟

function vRP.getCredit(user_id)
  local tmp = vRP.getUserTmpTable(user_id)
  if tmp then
    return tmp.credit or 0
  else
    return 0
  end
end

-- 크레딧 셋

function vRP.setCredit(user_id,value)
  local tmp = vRP.getUserTmpTable(user_id)
  if tmp then
    tmp.credit = value
  end
  

-- 크레딧 디스플레이

  local source = vRP.getUserSource(user_id)
  if source ~= nil then
    --기존 HUD
    --vRPclient.setDiv(source,{"credit",cfg.display_css," <span class=\"symbol\"></span> "..comma_value(vRP.getCredit(user_id))..""})
  end
end

-- try a payment (돈)
-- return true or false (debited if true)
function vRP.tryPayment(user_id,amount)
  local money = vRP.getMoney(user_id)
  if money >= amount then
    vRP.setMoney(user_id,money-amount)
    return true
  else
    return false
  end
end

-- 트라이 페이먼트 (크레딧)
function vRP.tryPaymentCredit(user_id,amount)
  local credit = vRP.getCredit(user_id)
  if credit >= amount then
    vRP.setCredit(user_id,credit-amount)
    return true
  else
    return false
  end
end

-- give money
function vRP.giveMoney(user_id,amount)
  local money = vRP.getMoney(user_id)
  vRP.setMoney(user_id,money+amount)
  vRP.elysiumlog("moneylog.txt","고유번호 ".. user_id .. " "..amount.."$를 현금으로 획득")
end

-- 크레딧 지급
function vRP.giveCredit(user_id,amount)
  local credita = vRP.getCredit(user_id)
  vRP.setCredit(user_id,credita+amount)
  vRP.elysiumlog("moneylog.txt","고유번호 ".. user_id .. " "..amount.." 크레딧을 획득")
end

-- get bank money
function vRP.getBankMoney(user_id)
  local tmp = vRP.getUserTmpTable(user_id)
  if tmp then
    return tmp.bank or 0
  else
    return 0
  end
end

-- set bank money
function vRP.setBankMoney(user_id,value)
  local tmp = vRP.getUserTmpTable(user_id)
  if tmp then
    tmp.bank = value
  end
  local source = vRP.getUserSource(user_id)
  if source ~= nil then
    --기존 HUD
    --vRPclient.setDiv(source,{"bmoney",cfg.display_css," <span class=\"symbol\"></span> "..comma_value(vRP.getBankMoney(user_id)).." $"})
  end
end

-- give bank money
function vRP.giveBankMoney(user_id,amount)
  if amount > 0 then
    local money = vRP.getBankMoney(user_id)
    vRP.setBankMoney(user_id,money+amount)
    vRP.elysiumlog("moneylog.txt","고유번호 ".. user_id .. " "..amount.."$를 계좌로 획득")
  end
end

-- 출금
-- return true or false (withdrawn if true)
function vRP.tryWithdraw(user_id,amount)
  local money = vRP.getBankMoney(user_id)
  if amount > 0 and money >= amount then
    vRP.setBankMoney(user_id,money-amount)
    vRP.giveMoney(user_id,amount)
    vRP.elysiumlog("moneylog.txt","고유번호 ".. user_id .. " "..amount.."$를 계좌로부터 출금")
    return true
  else
    return false
  end
end


--법인 추가

function vRP.AddToCompany(company_id,amount)
  if amount ~= nil then
    MySQL.execute("vRP/add_companycapital", {capital = amount, user_id = company_id})
    return true
  else
    return false
  end
end


--법인 입금
function vRP.tryDepositToCompany(user_id,company_id,amount)
  local money = vRP.getBankMoney(user_id)
  if amount > 0 and money >= amount then
    vRP.setBankMoney(user_id,money-amount)
    MySQL.execute("vRP/add_companycapital", {capital = amount, user_id = company_id})
    return true
  else
    return false
  end
end

--법인 출금
function vRP.tryWithdrawToCompany(user_id,company_id,amount)
  local money = vRP.getBankMoney(user_id)
  if amount > 0 then
    vRP.setBankMoney(user_id,money+amount)
    MySQL.execute("vRP/del_companycapital", {capital = amount, user_id = company_id})
    return true
  else
    return false
  end
end


-- 국고 출금

function vRP.tryWithdrawToTax(user_id,amount)
  local money = vRP.getBankMoney(user_id)
  if amount > 0 then
    vRP.setBankMoney(user_id,money+amount)
    MySQL.execute("vRP/del_tax", {statecoffers = amount})
    return true
  else
    return false
  end
end



-- 입금
-- return true or false (deposited if true)
function vRP.tryDeposit(user_id,amount)
  if amount > 0 and vRP.tryPayment(user_id,amount) then
    vRP.giveBankMoney(user_id,amount)
    return true
  else
    return false
  end
end

function vRP.addTax(amount)
  if amount > 0 then
    MySQL.execute("vRP/add_tax", {statecoffers = amount})
    return true
  else
    return false
  end
end

-- 크레딧 환전
function vRP.tryDepositCredit(user_id,amount)
  if amount > 0 and vRP.tryPaymentCredit(user_id,amount) then
    vRP.giveBankMoney(user_id,amount*1000)
    return true
  else
    return false
  end
end

-- 크레딧 역환전
function vRP.tryMoneyToCredit(user_id,amount)
  if amount > 0 and vRP.tryFullPayment(user_id,amount*1200) then
    vRP.giveCredit(user_id,amount)
    return true
  else
    return false
  end
end

-- try full payment (wallet + bank to complete payment)
-- return true or false (debited if true)
function vRP.tryFullPayment(user_id,amount)
  local money = vRP.getMoney(user_id)
  if money >= amount then -- enough, simple payment
    return vRP.tryPayment(user_id, amount)
  else  -- not enough, withdraw -> payment
    if vRP.tryWithdraw(user_id, amount-money) then -- withdraw to complete amount
      return vRP.tryPayment(user_id, amount)
    end
  end

  return false
end

-- events, init user account if doesn't exist at connection
AddEventHandler("vRP:playerJoin",function(user_id,source,name,last_login)
  MySQL.execute("vRP/money_init_user", {user_id = user_id, wallet = cfg.open_wallet, bank = cfg.open_bank, credit = cfg.open_credit, loanlimit = cfg.open_loanlimit, loan = cfg.open_loan, creditrating = cfg.open_creditrating, exp = cfg.open_exp}, function(affected)
    -- load money (wallet,bank)
    local tmp = vRP.getUserTmpTable(user_id)
    if tmp then
      MySQL.query("vRP/get_money", {user_id = user_id}, function(rows, affected)
        if #rows > 0 then
          tmp.bank = rows[1].bank
          tmp.wallet = rows[1].wallet
          tmp.credit = rows[1].credit
          tmp.loanlimit = rows[1].loanlimit
          tmp.loan = rows[1].loan
          tmp.creditrating = rows[1].creditrating
          tmp.exp = rows[1].exp
        end
      end)
    end
  end)
end)

-- save money on leave
AddEventHandler("vRP:playerLeave",function(user_id,source)
  -- (wallet,bank)
  local tmp = vRP.getUserTmpTable(user_id)
  if tmp and tmp.wallet ~= nil and tmp.bank ~= nil and tmp.credit ~= nil and tmp.loanlimit ~= nil and tmp.loan ~= nil and tmp.creditrating ~= nil and tmp.exp ~= nil then
    MySQL.execute("vRP/set_money", {user_id = user_id, wallet = tmp.wallet, bank = tmp.bank, credit = tmp.credit, loanlimit = tmp.loanlimit, loan = tmp.loan, creditrating = tmp.creditrating, exp = tmp.exp})
  end
end)

-- save money (at same time that save datatables)
AddEventHandler("vRP:save", function()
  for k,v in pairs(vRP.user_tmp_tables) do
    if v.wallet ~= nil and v.bank ~= nil and v.credit ~= nil and v.loanlimit ~= nil and v.loan ~= nil and v.creditrating ~= nil and v.exp ~= nil then
      MySQL.execute("vRP/set_money", {user_id = k, wallet = v.wallet, bank = v.bank, credit = v.credit, loanlimit = v.loanlimit, loan = v.loan, creditrating = v.creditrating, exp = v.exp})
    end
  end
end)

-- money hud
AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
  if first_spawn then
    -- add money display
    --기존 HUD
  --vRPclient.setDiv(source,{"money",cfg.display_css," <span class=\"symbol\"></span> "..comma_value(vRP.getMoney(user_id)).." $"})
	--vRPclient.setDiv(source,{"bmoney",cfg.display_css," <span class=\"symbol\"></span> "..comma_value(vRP.getBankMoney(user_id)).." $"})
	--vRPclient.setDiv(source,{"credit",cfg.display_css," <span class=\"symbol\"></span> "..comma_value(vRP.getCredit(user_id))..""})
  end
end)

local function ch_give(player,choice)
  -- get nearest player
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRPclient.getNearestPlayer(player,{10},function(nplayer)
      if nplayer ~= nil then
        local nuser_id = vRP.getUserId(nplayer)
        if nuser_id ~= nil then
          -- prompt number
          vRP.prompt(player,lang.money.give.prompt(),"",function(player,amount)
            local amount = parseInt(amount)
            if amount < 100000000 then
            if amount > 0 and vRP.tryPayment(user_id,amount) then
              local name = GetPlayerName(player)
              vRP.elysiumlog("moneylog.txt",user_id .. " | " .. name .. " | ".. nuser_id .. "에게 "..amount.."$를 줌.")
              vRP.giveMoney(nuser_id,amount)
              vRPclient.notify(player,{lang.money.given({amount})})
              vRPclient.notify(nplayer,{lang.money.received({amount})})
            else
              vRPclient.notify(player,{lang.money.not_enough()})
            end
          else
            vRPclient.notify(user_id, {"~r~한번에 1억 이상의 현금은 줄 수 없습니다!"})
          end
          end)
        else
          vRPclient.notify(player,{lang.common.no_player_near()})
        end
      else
        vRPclient.notify(player,{lang.common.no_player_near()})
      end
    end)
  end
end

local function ch_givec(player,choice)
  -- 크레딧 송금
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRPclient.getNearestPlayer(player,{10},function(nplayer)
      if nplayer ~= nil then
        local nuser_id = vRP.getUserId(nplayer)
        if nuser_id ~= nil then
          -- prompt number
          vRP.prompt(player,lang.credit.give.prompt(),"",function(player,amount)
            local amount = parseInt(amount)
            if amount > 0 and vRP.tryPaymentCredit(user_id,amount) then
              local name = GetPlayerName(player)
              vRP.elysiumlog("moneylog.txt",user_id .. " | " .. name .. " | ".. nuser_id .. "에게 "..amount.." 크레딧을 줌.")
              vRP.giveCredit(nuser_id,amount)
              vRPclient.notify(player,{lang.credit.given({amount})})
              vRPclient.notify(nplayer,{lang.credit.received({amount})})
            else
              vRPclient.notify(player,{lang.credit.not_enough()})
            end
          end)
        else
          vRPclient.notify(player,{lang.common.no_player_near()})
        end
      else
        vRPclient.notify(player,{lang.common.no_player_near()})
      end
    end)
  end
end

-- add player give money to main menu
vRP.registerMenuBuilder("main", function(add, data)
  local user_id = vRP.getUserId(data.player)
  if user_id ~= nil then
    local choices = {}
    choices[lang.money.give.title()] = {ch_give, lang.money.give.description()}

    add(choices)
  end
end)

--[[ vRP.registerMenuBuilder("main", function(add, data)
  local user_id = vRP.getUserId(data.player)
  --if user_id == 1 or 2 then
  if user_id ~= nil then
    local choices = {}
    choices[lang.credit.give.title()] = {ch_givec, lang.credit.give.description()}

    add(choices)
  end
end) ]]--