--[[
  大衍之数五十，其用四十有九。
  分而为二以象两，挂一以象三，揲之以四以象四时，
  归奇於抟以象闰，故再抟而后挂.
      --《易经·系辞上传》第九章
]]
local log=print
local T8GUA={'坤','震','坎','兑','艮','离','巽','乾'}
local T8XIANG={'地','雷','水','泽','山','火','风','天'}
--[[
local T64GUA={
  ['天']='乾',	['天风']='姤',	  ['天山']='遁',	  ['天地']='否',	  ['风地']='观',	  ['山地']='剥',	  ['火地']='晋',	  ['火天']='大有',	
  ['水']='坎',	['水泽']='节',	  ['水雷']='屯',	  ['水火']='既济',	['泽火']='革',	  ['雷火']='丰',	  ['地火']='明夷',	['地水']='师',	
  ['山']='艮',	['山火']='贲',	  ['山天']='大畜',	['山泽']='损',	  ['火泽']='睽',	  ['天泽']='履',	  ['风泽']='中孚',	['风山']='渐',	
  ['雷']='震',	['雷地']='豫',	  ['雷水']='解',	  ['雷风']='恒',	  ['地风']='升',	  ['水风']='井',	  ['泽风']='大过',	['泽雷']='随',	
  ['风']='巽',	['风天']='小畜',	['风火']='家人',	['风雷']='益',	  ['天雷']='无妄',	['火雷']='噬嗑',	['山雷']='颐',	  ['山风']='蛊',	
  ['火']='离',	['火山']='旅',	  ['火风']='鼎',	  ['火水']='未济',	['山水']='蒙',	  ['风水']='涣',	  ['天水']='讼',	  ['天火']='同人',	
  ['地']='坤',	['地雷']='复',	  ['地泽']='临',	  ['地天']='泰',	  ['雷天']='大壮',	['泽天']='夬',	  ['水天']='需',	  ['水地']='比',	
  ['泽']='兑',	['泽水']='困',	  ['泽地']='萃',	  ['泽山']='咸',	  ['水山']='蹇',	  ['地山']='谦',	  ['雷山']='小过',	['雷泽']='归妹',	
}
local TYAOCI={
  '乾',	  '姤',	  '遁',	  '否',	  '观',	  '剥',	  '晋',	  '大有',
  '坎',	  '节',	  '屯',	  '既济',	'革',	  '丰',	  '明夷',	'师',
  '艮',	  '贲',	  '大畜',	'损',	  '睽',	  '履',	  '中孚',	'渐',
  '震',	  '豫',	  '解',	  '恒',	  '升',	  '井',	  '大过',	'随',
  '巽',	  '小畜',	'家人', '益',	  '无妄',	'噬嗑',	'颐',	  '蛊',
  '离',	  '旅',	  '鼎',	  '未济',	'蒙',	  '涣',	  '讼',	  '同人',
  '坤',	  '复',	  '临',	  '泰',	  '大壮',	'夬',	  '需',	  '比',
  '兑',	  '困',	  '萃',	  '咸',	  '蹇',	  '谦',	  '小过', '归妹'
}

local T64XIANG={
  '天',	'天风',	'天山',	'天地',	'风地',	'山地',	'火地',	'火天',
  '水',	'水泽',	'水雷',	'水火',	'泽火',	'雷火',	'地火',	'地水',
  '山',	'山火',	'山天',	'山泽',	'火泽',	'天泽',	'风泽',	'风山',
  '雷',	'雷地',	'雷水',	'雷风',	'地风',	'水风',	'泽风',	'泽雷',
  '风',	'风天',	'风火',	'风雷',	'天雷',	'火雷',	'山雷',	'山风',
  '火',	'火山',	'火风',	'火水',	'山水',	'风水',	'天水',	'天火',
  '地',	'地雷',	'地泽',	'地天',	'雷天',	'泽天',	'水天',	'水地',
  '泽',	'泽水',	'泽地',	'泽山',	'水山',	'地山',	'雷山',	'雷泽'
}
]]
local SHU=50
local YONG=49
local XUSHU={'初','二','三','四','五','上'}
local XUJI={'六','九'}
local FUHAO={'---  ---','--------'}
local yiBook
local gcBen
local gcBian
local gcHu

function ShiBu(seed)
  -- 成卦;六爻数,六爻阴阳
  local ys,yy=ChengGua(seed) 
  -- 变爻位
  local bw=BianWei(ys) 
  -- 查书;得到
  SearchBook(yy,bw)
  -- 卦象;本,变,互
  ShowGuaXiang(yy,bw) 
  -- 卦辞
  ShowGuaci(bw)
  
  -- 互卦
  -- 生克
end
function ShowGuaci(bw)
  print('====卦辞====')
  print('--卦名--')
  print(ParseGuaciMing(gcBen,0))
  local xmBen=ParseGuaciMing(gcBen,2)
  local xmBian=ParseGuaciMing(gcBian,2)
  print(xmBen..' 之 '..xmBian)
  print('--本卦--')
  print(ParseGuaciBengua(gcBen))
  print(ParseGuaciTuan(gcBen))
  print(ParseGuaciXiang(gcBen))
  print(ParseGuaciBianyao(gcBen,bw))
  print('--变卦--')
  print(ParseGuaciBengua(gcBian))
  --print(ParseGuaciTuan(gcBian))
  --print(ParseGuaciXiang(gcBian))
  print(ParseGuaciBianyao(gcBian,bw))
end
function BianGua(benyao,bw)         -- 变卦;in:六爻阴阳,变爻位;out:变卦六爻阴阳
  local ny={}
  for i=1,6 do
    ny[i]=benyao[i]
  end
  ny[bw]=1-ny[bw]
  return ny
end

function ChengGua(seed)             -- 成卦;in:seed;out:六爻数,六爻阴阳
  local yShu={} -- 爻挂数
  local yYin={} -- 爻阴阳
  local rs = os.time()+seed
  math.randomseed(rs)
  print("====卜蓍====")
  for i=1,6 do
    print('--'..i..'爻'..'--')
    yShu[i]=DieYao()
    local yin=yShu[i]%2==0
    yYin[i]=yin and 0 or 1
    print(i..'爻:\t'..yShu[i])
  end  
  return yShu,yYin
end

function BianWei(yShu)              -- in:六爻阴阳;out:变爻位
  local sum=0
  for i=1,6 do
    sum=sum+yShu[i]
  end
  print('和数:\t'..sum)
  local y=(55-sum)%6
  if y==0 then y=6 end
  print('变爻:\t'..y)
  return y
end

function ShowGuaXiang(benyao,bw)        -- 卦象;in:六爻阴阳,变位;out:打印各类卦象
  print('====卦象====')
 -- for k,v in pairs(gcBen) do
 -- end
  local xmBen=ParseGuaciMing(gcBen,2)
  local xmBian=ParseGuaciMing(gcBian,2)
  local g={
    '本卦\t'..xmBen..'\t变卦\t'..xmBian,'','','','','',''
  } -- 1:属性,2~7:六爻 
  print(g[1])
  for i=6,1,-1 do
    if bw~=i then
      g[i+1]=g[i+1]..MingYao(i,benyao)..'\t'..g[i+1]..MingYao(i,benyao)
    else 
      local ben=MingYao(i,benyao)
      local bian=MingYao(i,BianGua(benyao,bw))
      g[i+1]=g[i+1]..ben..'\t'..g[i+1]..bian
    end
    print(g[i+1])
  end
end

function BenGua(yao)                -- in:六爻阴阳;out:本卦卦辞
  local gx=Yao6ToGua(yao)
  return gx
end
function HuGua(benyao,bw)           -- 互卦;in:六爻阴阳,变位
  
end
function MingYao(n,yao)             -- 爻名称;in:爻数,六爻阴阳;out:爻名称
  local yin=yao[n]==0
  local s=''
  if n==1 then
    s='初'..MingYinyang(yin)      
  elseif n==6 then
    s='上'..MingYinyang(yin)
  else
    s=MingYinyang(yin)..XUSHU[n]
  end
  s=s..'\t'
  local hua=yin and FUHAO[1] or FUHAO[2]
  s=s..hua
  return s
end

function MingYinyang(yin)           -- 阴阳名称;in:0或1;out:六或九
  return yin and XUJI[1] or XUJI[2]
end

function DieYao()                   -- 三揲成爻;in:无;out:爻数
  -- 一揲
  local yong = YONG
  print('用:\t'..yong)
  local t,d=FenEr(yong)
  local t,d,r=GuaYi(t,d)
  print('一揲:\t天'..t..'\t地'..d..'\t人'..r)
  yong=Die(t,d,r)
  -- 再揲
  print('用:\t'..yong)
  t,d=FenEr(yong)
  t,d,r=GuaYi(t,d)
  print('二揲:\t天'..t..'\t地'..d..'\t人'..r)
  yong=Die(t,d,r)
  -- 三揲
  print('用:\t'..yong)
  t,d=FenEr(yong)
  t,d,r=GuaYi(t,d)
  print('三揲:\t天'..t..'\t地'..d..'\t人'..r)
  yong=Die(t,d,r)
  -- 挂
  return yong/4
end

function FenEr(yong)                -- 将蓍草分成两堆,以象天地;in:用数;out:天地挂
  local tian
  local di
  tian=math.random(1,yong-2)
  di=yong-tian
  return tian,di
end

function GuaYi(tian,di)             -- 取于地,挂一,以象人;in:天地挂;out:三才挂
  return tian,di-1,1
end
function Die(tian,di,ren)           -- 揲;in:三才位挂数;out:揲后剩余挂数
  local lt=Tuan(tian)
  local ld=Tuan(di)
  local lr=Tuan(ren)
  print('抟:\t天'..lt..'\t地'..ld..'\t人'..lr)
  return tian+di+ren-lt-ld-lr
end

function Tuan(g)                    -- 抟;in:挂数;out:抟的数量
  local t= g%4
  if t==0 then t=4 end
  return t
end

function Yao3ToXiang(y1,y2,y3)      -- 三爻卦象;in:三爻阴阳0,1;out:卦象
  local x=y1*1+y2*2+y3*4+1
  return T8XIANG[x]
end

function Yao6ToGua(y)               -- 六爻阴阳得卦辞;in:六爻阴阳;out:卦辞
  local l=Yao3ToXiang(y[1],y[2],y[3])
  local h=Yao3ToXiang(y[4],y[5],y[6])
  local gc=SearchGua(l,h)
  return gc
end
function BeginSearch()
  yiBook=io.open('./yi.txt','r')
end
function EndSearch()
  yiBook=io.close()
end
function GuaMingDivide(line)        -- 搜书得卦名行,返回全称分割节点;in:书卦名行;out:卦名分割位置
  -- 计算各段起始位置    
    local l=line:len()
    local p={1,1,1,1,1,1,1,l}
    local i=1
    local mark=1
    while i<=l do
      if line:sub(i,i)==' ' then 
        mark=mark+1
        if mark==2 then
          p[2]=i-1
          p[3]=i+1
        elseif mark==3 then
          p[4]=i-1
          p[5]=i+1
        elseif mark==4 then
          p[6]=i-1
          p[7]=i+1
        end
      end
      i=i+1
    end    
  --  print(line:sub(p[1],p[2]),line:sub(p[3],p[4]),line:sub(p[5],p[6]),line:sub(p[7],p[8]))
    return p
end
function SearchGua(hx,lx)           -- 搜书卦辞;in:上下卦象;out:卦辞
  BeginSearch()
  local lines=yiBook:lines()
  local guaci={}
  local line=lines()
  while line~=null do
    if line:sub(1,3)=='第' then
      local p=GuaMingDivide(line)
      local xiang=line:sub(p[5],p[6])
      -- 卦象是否匹配
      local flag=false
      if hx==lx then
        if xiang:sub(7,9) == hx then
          flag=true
        end
      else 
        if xiang:sub(1,6)==hx..lx then
          flag=true
        end
      end
      if flag then
        -- 卦名
        guaci['名']=line 
        -- 本卦
        guaci['本']=lines()
        -- 彖
        guaci['彖']=lines()
        -- 象
        guaci['象']=lines()
        -- 初
        guaci['初']=lines()
        -- 二
        guaci['二']=lines()
        -- 三
        guaci['三']=lines()
        -- 四
        guaci['四']=lines()
        -- 五
        guaci['五']=lines()
        -- 上
        guaci['上']=lines()      
        return guaci
      end
    end  
    line=lines()
  end
  EndSearch()
end
function SearchBook(yao,bian)       -- 搜书,保存卦辞
  gcBen=Yao6ToGua(yao)
  gcBian=Yao6ToGua(BianGua(yao,bian))
end
function ParseGuaciMing(gc,op)      -- 卦辞中提取名称,可选;in:爻辞,控制(0-全称,1-简称,2-象称);out:名称
  local name=''
  local line=gc['名']
  local p=GuaMingDivide(line)
  op=op==nil and 2 or op
  if op==0 then
    name=gc['名']
  elseif op==1 then
    name=line:sub(p[3],p[4])
  elseif op==2 then
    name=line:sub(p[5],p[6])
  else
    name=''
  end
  return name
end
function ParseGuaciBengua(gc)       -- 卦辞中提取本卦卦辞;in:爻辞;out:卦辞
  return gc['本']
end
function ParseGuaciTuan(gc)         -- 卦辞中提取本卦彖辞;in:爻辞;out:彖辞
  return gc['彖']
end
function ParseGuaciXiang(gc)        -- 卦辞中提取本卦象辞;in:爻辞;out:象辞
  return gc['象']
end
function ParseGuaciBianyao(gc,bw)   -- 卦辞中提取爻辞;in:爻辞,变位;out:爻辞
  return gc[XUSHU[bw]]
end
function TestSearchGua()
  local hg=T8XIANG[math.random(1,8)]
  local lg=T8XIANG[math.random(1,8)]
  print('输入:'..hg..lg)
  print('输出')
  local res=SearchGua(hg,lg)
  for k,v in pairs(res) do
    print(k,v)
  end
end

function TestDistributionOfYao(num)
  -- 试验草稿代码
  local shu={6,7,8,9}
  local count={}
  local dict={}
  for i=1,num do
    local sum=0  
    for j=1,6 do
      local r=math.random(1,4)
      sum=sum+ shu[r]
    end
    if dict[sum]==nil then dict[sum]=0 end
    dict[sum]=dict[sum]+1
  end

  local ys={}
  print('和数的统计')
  for k,v in pairs(dict) do
    print(k..' '..v)
  end
  for k,v in pairs(dict) do
    local y1=55-k
    local y2=y1%6
    if ys[y2]==nil then ys[y2]=0 end
    ys[y2]=ys[y2]+v
  end
  print('爻数的统计')
  for k,v in pairs(ys) do
    print(k..' '..v)
  end
end

--ShiBu(99239)
                       