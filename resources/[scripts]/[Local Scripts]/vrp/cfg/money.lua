
local cfg = {}

-- start wallet/bank values
cfg.open_wallet = 1000000
cfg.open_bank = 50000000
cfg.open_credit = 0
cfg.open_loanlimit = 500000
cfg.open_loan = 0
cfg.open_creditrating = 7
cfg.open_exp = 0

cfg.display_css = [[	
.div_money{
  position: absolute;
  top: 60px;
  right: 10px;
  color: white;
  background: linear-gradient(to left, rgba(0,0,0,0) 0%,rgba(0,0,0,0.55) 100%);
  //background-color: rgba(0,0,0,0.40);
  padding: 4px;
  min-width : 170px;
  max-width: 250px;
  border-radius: 5px;
  font-size: 18px;
  font-weight: bold;
  color: #FFFFFF;
  //text-shadow: rgb(0, 0, 0) 1px 0px 0px, rgb(0, 0, 0) 0.533333px 0.833333px 0px, rgb(0, 0, 0) -0.416667px 0.916667px 0px, rgb(0, 0, 0) -0.983333px 0.133333px 0px, rgb(0, 0, 0) -0.65px -0.75px 0px, rgb(0, 0, 0) 0.283333px -0.966667px 0px, rgb(0, 0, 0) 0.966667px -0.283333px 0px;
}
.div_bmoney{
  position: absolute;
  top: 100px;
  right: 10px;
  background: linear-gradient(to left, rgba(0,0,0,0) 0%,rgba(0,0,0,0.55) 100%);
  //background-color: rgba(0,0,0,0.40);
  padding: 4px;
  min-width : 170px;
  max-width: 250px;
  border-radius: 5px;
  font-size: 18px;
  font-weight: bold;
  color: #FFFFFF;
  //text-shadow: rgb(0, 0, 0) 1px 0px 0px, rgb(0, 0, 0) 0.533333px 0.833333px 0px, rgb(0, 0, 0) -0.416667px 0.916667px 0px, rgb(0, 0, 0) -0.983333px 0.133333px 0px, rgb(0, 0, 0) -0.65px -0.75px 0px, rgb(0, 0, 0) 0.283333px -0.966667px 0px, rgb(0, 0, 0) 0.966667px -0.283333px 0px;
}

.div_credit{
  position: absolute;
  top: 140px;
  right: 10px;
  background: linear-gradient(to left, rgba(0,0,0,0) 0%,rgba(0,0,0,0.55) 100%);
  //background-color: rgba(0,0,0,0.40);
  padding: 4px;
  min-width : 170px;
  max-width: 250px;
  border-radius: 5px;
  font-size: 18px;
  font-weight: bold;
  color: #FFFFFF;
  //text-shadow: rgb(0, 0, 0) 1px 0px 0px, rgb(0, 0, 0) 0.533333px 0.833333px 0px, rgb(0, 0, 0) -0.416667px 0.916667px 0px, rgb(0, 0, 0) -0.983333px 0.133333px 0px, rgb(0, 0, 0) -0.65px -0.75px 0px, rgb(0, 0, 0) 0.283333px -0.966667px 0px, rgb(0, 0, 0) 0.966667px -0.283333px 0px
}
.div_money .symbol{

  content: url('https://i.imgur.com/doXvOm6.png'); 
  margin-top: 2px;
  margin-left: 4px;
}

.div_bmoney .symbol{
  content: url('https://i.imgur.com/glLG7gH.png');
  margin-top: 2px;
  margin-left: 4px;
}

.div_credit .symbol{
  content: url('https://i.imgur.com/qHheYFF.png');
  margin-top: 2px;
  margin-left: 4px;
}
]]

return cfg
