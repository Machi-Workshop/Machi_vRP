-- define items, see the Inventory API on github

local cfg = {}
-- see the manual to understand how to create parametric items
-- idname = {name or genfunc, description or genfunc, genfunc choices or nil, weight or genfunc}
-- a good practice is to create your own item pack file instead of adding items here
cfg.items = {
  ["benzoyl"] = {"벤조일", "코카인의 원료.", nil, 0.01}, -- no choices
  ["seeds"] = {"대마씨", "대마의 씨앗.", nil, 0.01}, -- no choices
  ["harness"] = {"LSD 원료", "LSD의 원료.", nil, 0.01}, -- no choices
  ["AK47"] = {"AK47", "A Russian masterpeice.", nil, 0.01}, -- no choices
  ["M4A1"] = {"M4A1", "Helps give non-Americans freedom.", nil, 0.01}, -- no choices
  ["credit"] = {"Stolen Credit Card", "Credit card.", nil, 0.01}, -- no choices
  ["driver"] = {"운전면허증", "운전면허증.", nil, 0.01}, -- no choices
  ["bank_money"] = {"Money of bank", "$.", nil, 0},
  ["trash"] = {"Trash", "It fucking stinks!", nil, 0},  -- no choices
  ["fake_id"] = {"Fake ID", "It just says Mcluvin.", nil, 0}, -- no choices
  ["police_report"] = {"Police Report", "Take it to the Bank Manager.", nil, 0},  -- no choices
  ["ems_report"] = {"EMS Report", "Take it to the Hospital.", nil, 0}, -- no choices
  ["cargo"] = {"택배 소포", "누군가의 소포다.", nil, 0}, -- no choices
  ["key_pd_boss"] = {"🔑 서장실 열쇠", "", nil, 0.01},
  ["key_lspd"] = {"🔑 경찰 열쇠", "", nil, 0.01},
  --["piece1"] = {"🧩 GT-R의 조각", "", nil, 0},
  --["piece2"] = {"🧩 카마로의 조각", "", nil, 0},
  ["radio"] = {"📻 경찰 무전", "", nil, 0},
  ["elcato"] = {"카지노 칩", "다이아몬드 카지노에서 통용되는 칩이다.",nil,0},
  ["rec"] = {"부동산계약서", "집을 계약할 수 있는 계약서이다",nil,0},
  ["picareta"] = {"광부 전용 곡괭이","광산에서 사용할수있는 1회용 곡괭이",nil,0.1},
  --["ouro"] = {"먼지에 쌓인 광물","먼지 털기를 통해 어떤 광물인지 감정할 수 있다.",nil,0.1},
}

-- load more items function
local function load_item_pack(name)
  local items = module("cfg/item/"..name)
  if items then
    for k,v in pairs(items) do
      cfg.items[k] = v
    end
  else
    print("[vRP] item pack ["..name.."] not found")
  end
end

-- PACKS
load_item_pack("required")
load_item_pack("food")
load_item_pack("drugs")

return cfg
