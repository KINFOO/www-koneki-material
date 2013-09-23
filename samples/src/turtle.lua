-- base api turtle for moving and digging
-- http://pastebin.com/xucw2TU7
-- in order to enable in your program write: os.loadAPI("baseapi")

-- api version
local ver=300
-- ********* CNANGELOG HISTORY *********
-- ver=100 - first version of api;
-- *********** END CHANGELOG ***********
-- get api version
function getVer()
  return ver
end
-- behavior: "brk" - break block; "err"- throw error
behavior={brk=1,err=2,other=3}
local _db=behavior.brk
-- current rotate orientation
rot={NORTH=tonumber(1),EAST=tonumber(2),SOUTH=tonumber(3),WEST=tonumber(4)}
-- current slot
local cSlot=1
-- filter length
local filterLen=0;
-- minimal fuel to back base position
local minFuel=0;


-- **** BASE FUNCTIONS ****
-- create point table, where r - rotate orientation
function createPoint(px,py,pz,pr)
  if (px and py and pz and pr) then
    return {x=tonumber(px), y=tonumber(py), z=tonumber(pz), r=tonumber(pr)}
  else
    error("error create point")
  end
end
-- current point
cPoint={x=tonumber(0), y=tonumber(0), z=tonumber(0), r=tonumber(rot.NORTH)}
-- base point
bPoint={x=tonumber(0), y=tonumber(0), z=tonumber(0), r=tonumber(rot.NORTH)}
-- save point
sPoint={x=tonumber(0), y=tonumber(0), z=tonumber(0), r=tonumber(rot.NORTH)}
-- anchor point
aPoint={x=tonumber(0), y=tonumber(0), z=tonumber(0), r=tonumber(rot.NORTH)}

function clrScr()
  term.clear()
  term.setCursorPos(1,1)
end

-- select slot in the turtle inventory (1<=slt<=16)
function selectSlot(slt)
  if turtle.select(slt) then
    cSlot=slt
    return true
  end
  return false
end
-- get current selected slot
function getSlot()
  return cSlot
end
-- set behavior if detect block on the path
-- behavior.brk - break block; behavior.err- throw error
function setBehavior(val)
  _db=val
end
-- get current behavior
function getBehavior()
  return _db
end
-- set current position
function setPos(point)
  cPoint.x=point.x
  cPoint.y=point.y
  cPoint.z=point.z
  cPoint.r=point.r
end
-- set save position
function setSavePos(point)
  sPoint.x=point.x
  sPoint.y=point.y
  sPoint.z=point.z
  sPoint.r=point.r
end
-- set base position
function setBasePos(point)
  bPoint.x=point.x
  bPoint.y=point.y
  bPoint.z=point.z
  bPoint.r=point.r
end
-- set anchor position
function setAnchorPos(point)
  aPoint.x=point.x
  aPoint.y=point.y
  aPoint.z=point.z
  aPoint.r=point.r
end
-- set current pos to save pos
function savePos()
    sPoint.x=cPoint.x
    sPoint.y=cPoint.y
    sPoint.z=cPoint.z
    sPoint.r=cPoint.r
end
-- restore cur pos from save pos
function restPos()
    cPoint.x=sPoint.x
    cPoint.y=sPoint.y
    cPoint.z=sPoint.z
    cPoint.r=sPoint.r
end
-- set base pos to save pos
function saveBasePos()
    sPoint.x=bPoint.x
    sPoint.y=bPoint.y
    sPoint.z=bPoint.z
    sPoint.r=bPoint.r
end
-- set current pos to base pos
function saveToBasePos()
    bPoint.x=cPoint.x
    bPoint.y=cPoint.y
    bPoint.z=cPoint.z
    bPoint.r=cPoint.r
end
-- set current pos to anchor pos
function saveToAnchorPos()
  aPoint.x=cPoint.x
  aPoint.y=cPoint.y
  aPoint.z=cPoint.z
  aPoint.r=cPoint.r
end
-- restore base pos from save pos
function restBasePos()
    bPoint.x=sPoint.x
    bPoint.y=sPoint.y
    bPoint.z=sPoint.z
    bPoint.r=sPoint.r
end
-- print position for debug
function printPos(type)
  if (type==0) then
    print("cPos: ",cPoint.x,",",cPoint.y,",",cPoint.z,",",cPoint.r)
  else if (type==1) then
    print("sPos: ",sPoint.x,",",sPoint.y,",",sPoint.z,",",sPoint.r)
  else if (type==2) then
    print("bPos: ",bPoint.x,",",bPoint.y,",",bPoint.z,",",bPoint.r)
  end; end; end  
end  
-- get current position
function getPos()
  return cPoint;
end
-- get save position
function getSavePos()
  return sPoint;
end
-- get base position
function getBasePos()
  return bPoint;
end
-- get anchor position
function getAnchorPos()
  return aPoint;
end
-- get a coord
function getbX()
  return bPoint.x
end
function getbY()
  return bPoint.y
end
function getbZ()
  return bPoint.z
end
function getbR()
  return bPoint.r
end
function getsX()
  return sPoint.x
end
function getsY()
  return sPoint.y
end   
function getsZ()
  return sPoint.z
end
function getsR()
  return sPoint.r
end   
function getX()
  return cPoint.x
end
function getY()
  return cPoint.y
end
function getZ()
  return cPoint.z
end
function getR()
  return cPoint.r
end
-- attack mob or player in front
function attack()
  while turtle.attack() do
    sleep(0.3)
  end
end
-- rotate to defined orientation
function rotateTo(rotate)
  print("rotate:",rotate)
  print("cPoint",cPoint.z)
  local _d = cPoint.r - rotate
  if (_d==0) then return; end
  if (_d > 0) then
    turnLeft(_d)
  else
    turnRight(-_d)
  end;
end
-- turn right num steps
function turnRight(num)
  local _it=0
  while (_it < num) do
    cPoint.r = cPoint.r + 1
    if (cPoint==5) then cPoint.r = rot.NORTH; end
    turtle.turnRight()
    _it = _it + 1
  end
end
-- turn left num steps
function turnLeft(num)
  _it=0
  while (_it < num) do
    cPoint.r = cPoint.r - 1
    if (cPoint.r==0) then cPoint.r = rot.WEST; end
    turtle.turnLeft()
    _it = _it + 1
  end
end

-- back num steps
function back(num)
  _it=0
  while (_it < num) do
   if (cPoint.r==1) then cPoint.y=cPoint.y-1
   else if (cPoint.r==2) then cPoint.x=cPoint.x-1
   else if (cPoint.r==3) then cPoint.y=cPoint.y+1
   else cPoint.x=cPoint.x+1; end; end; end
     turtle.back()
    _it = _it+1
  end
end
-- up num steps
function up(num)
  _it=0
  while (_it < num) do
    if (turtle.detectUp()) then
      if (_db==behavior.brk) then turtle.digUp();
        if (turtle.detectUp()) then
          print("error dig up!")
          return false
        end
      else if (_db==behavior.err) then print("up block!"); return false; end; end
    end
    while turtle.attackUp() do
      sleep(0.3)
    end
    cPoint.z = cPoint.z+1
    turtle.up()
    _it = _it+1
  end
  return true;
end
-- down num steps
function down(num)
  _it = 0
  while (_it < num) do
    if (turtle.detectDown()) then
      if (_db==behavior.brk) then turtle.digDown()
        if (turtle.detectDown()) then
          print("error dig down!")
          return false
        end
      else if (_db==behavior.err) then print("down block!"); return false; end; end
    end
    while turtle.attackDown() do
      sleep(0.3)
    end
    cPoint.z = cPoint.z-1
    turtle.down()
    _it = _it + 1
  end
  return true
end

-- goto base position from current position
-- mode: "zxy","zyx","xyz","yxz","xzy","yzx"
function goTo(mode, typeP)
  local dX, dY, dZ
  if (typeP=="base") then
    dX=bPoint.x-cPoint.x
    dY=bPoint.y-cPoint.y
    dZ=bPoint.z-cPoint.z
  else
    dX=sPoint.x-cPoint.x
    dY=sPoint.y-cPoint.y
    dZ=sPoint.z-cPoint.z
  end
  if (mode=="zxy") then
    moveToZ(dZ)
    moveToX(dX)
    moveToY(dY)
  else if (mode=="zyx") then
    moveToZ(dZ)
    moveToY(dY)
    moveToX(dX)
  else if (mode=="xyz") then
    moveToX(dX)
    moveToY(dY)
    moveToZ(dZ)
  else if (mode=="yxz") then
    moveToY(dY)
    moveToX(dX)
    moveToZ(dZ)
  else if (mode=="xzy") then
    moveToX(dX)
    moveToZ(dZ)
    moveToY(dY)
  else if (mode=="yzx") then
    moveToY(dY)
    moveToZ(dZ)
    moveToX(dX)
  end; end; end; end; end; end
  rotateTo(bPoint.r)
end
-- check free slots
function freeSlots()
  for slot=1,16,1 do
    if (turtle.getItemSpace(slot)==64) then
      return true
    end
  end
  return false
end
-- pick up items from "dir" direction
function suckDir(dir)
  if (dir=="front") then
    return turtle.suck()
  else if (dir=="up") then
    return turtle.suckUp()
  else if (dir=="down") then
    return turtle.suckDown()
  end; end; end
  return false;
end
-- drop items to "dir" direction
function dropDir(dir,num)
  if (dir=="front") then
    return turtle.drop(num)
  else if (dir=="up") then
    return turtle.dropUp(num)
  else if (dir=="down") then
    return turtle.dropDown(num)
  end; end; end
end
-- refuel turtle: "num"-number of block, "por"-portion by refuel, "fDir"
-- direction chest("front","up","down")
-- fuel is in slot 16
function refuel(num,por,fDir)
  local _curFuel=0
  local _itemFuel=0
  local _bCnt=0
  turtle.select(16)
  if (turtle.getItemSpace(16)==64) then
    if (not suckDir(fDir)) then
      rTo(rot.NORTH)
      error("can't pickup fuel item!")
      turtle.select(cSlot)
      return false
    end
  end
  _curFuel=turtle.getFuelLevel()
  turtle.refuel(por)
  _itemFuel=turtle.getFuelLevel()-_curFuel
-- print ("itemFuel: ",_itemFuel)
  if (_itemFuel==0) then
    rTo(rot.NORTH)
    error("block is not fuel!")
    dropDir(fDir,64)
    turtle.select(cSlot)
    return false
  end
  _bCnt=num/_itemFuel
  for _b=1,_bCnt,1 do
    if (turtle.getItemSpace(16)==64) then
      if (not suckDir(fDir)) then
       rTo(rot.NORTH)
       error("can't pickup fuel item!")
       turtle.select(cSlot)
       return false
      end
    end
    turtle.refuel(por)
  end
  dropDir(fDir,64)
  _itemFuel=turtle.getFuelLevel()
  if (_itemFuel-_curFuel)<num then
    rTo(rot.NORTH)
    error("not enouth fuel in chest")
  end
  turtle.select(cSlot)
  return true
end
-- set filter len
function setFilterLen(num)
  if (num<0) then
    error("error set filter length")
  end
  filterLen=num;
end
-- get filter len
function getFilterLen(num)
  return filterLen;
end
-- compute filter length before run digging
function computeFilterLen()
  for flen=1,16,1 do
    if (turtle.getItemSpace(filterLen)==64) then
      break
    end
    filterLen=flen
  end
  return filterLen
end
-- check filter with front block
function chkFilter()
  for fltr=1,filterLen,1 do
    turtle.select(fltr)
    if turtle.compare() then return true; end
  end
  turtle.select(cSlot)
  return fasle
end

-- **** FUNCTIONS FOR DIGGING ****
-- dmode: goto-status then dig state save every move 1 block
-- dmode: dig -status then dig state save every move 1 x-line
dmode={none=tonumber(0), gotob=tonumber(1), gofromb =tonumber(2), setanchor=tonumber(3), digfloor=tonumber(4),digdown=tonumber(5) }
lastmove={none=tonumber(0),byx=tonumber(1),by_x=tonumber(2),byy=tonumber(3),by_y=tonumber(4),byz=tonumber(5),by_z=tonumber(6)}
-- curflr - current floor
local dStatus={work=0, mode=dmode.none, digX=0, digY=0, digZ=0}
-- max dig count
local maxDigCount=25
-- set dig status
function setDigStatus(ds)
  if (ds) then
    dStatus=ds;
  else
    error("error set dig status")
  end
end
-- get dig status
function getDigStatus()
  return dStatus;
end
-- save current dig state
function saveDigState(fileName)
  if (fileName) then
    local file=fs.open(fileName,"w")
    -- write dig status
    file.writeLine(textutils.serialize(dStatus))
    -- write current position
    file.writeLine(textutils.serialize(cPoint))
    -- write save position
    file.writeLine(textutils.serialize(sPoint))
    -- write base position
    file.writeLine(textutils.serialize(bPoint))
    -- write anchor position
    file.writeLine(textutils.serialize(aPoint))
    file.close()
  end
end
-- load current dig state
function loadDigState(fileName)
  if (fileName) then
    local file=fs.open(fileName,"r")
    -- load dig status
    dStatus=textutils.unserialize(file.readLine());
    -- load current pos
    cPoint=textutils.unserialize(file.readLine());
    -- load save pos
    sPoint=textutils.unserialize(file.readLine());
    -- load base pos
    bPoint=textutils.unserialize(file.readLine());
    -- load anchor pos
    aPoint=textutils.unserialize(file.readLine());
    file.close();
    return data;
  end
end
function turnR(num)
  local _it=0
  while (_it < num) do
    cPoint.r = cPoint.r + 1
    if (cPoint==5) then cPoint.r = rot.NORTH; end
    saveDigState("state")
    turtle.turnRight()
    _it = _it + 1
  end
end

function turnL(num)
  _it=0
  while (_it < num) do
    cPoint.r = cPoint.r - 1
    if (cPoint.r==0) then cPoint.r = rot.WEST; end
    saveDigState("state")
    turtle.turnLeft()
    _it = _it + 1
  end
end

-- rotate to defined orientation
function rTo(rotate)
  local _d = cPoint.r - rotate
  if (_d==0) then return; end
  if (_d > 0) then
    turnL(_d)
  else
    turnR(-_d)
  end;
end

function moveTurtle(moveFn, detectFn, digFn, attackFn, _maxDigCount)
  local digCount = 0
  local moveSuccess = moveFn()
  while ((moveSuccess == false) and (digCount < _maxDigCount)) do
        if (detectFn() == true) then
                if(digCount > 0) then
                  sleep(0.4)
                end
                digFn()
                digCount = digCount + 1
        else
          while attackFn() do
            sleep(0.3)
          end;
        end
        moveSuccess = moveFn()
  end
  return moveSuccess

end

function dropBySlot(slot,dropFn)
  turtle.select(slot)
  if (turtle.getItemCount(slot) > 0) then
    while not dropFn() do
      sleep(1)
      print("chest full!")
    end
  end
end

-- forward num steps
function forward(num)
  local _it = 0
  local tmpF=0
  while (_it < num) do
     if (minFuel > turtle.getFuelLevel())or(not freeSlots()) then
       print("dig: fuel/slots not enouth, go to base")
       dStatus.mode=dmode.gotob
  -- set anchor position
       aPoint.x=cPoint.x
       aPoint.y=cPoint.y
       aPoint.z=cPoint.z
       aPoint.r=cPoint.r
  -- goto base pos
       moveToZs(bPoint.z-aPoint.z)
       moveToYb()
       moveToXb()
-- drop all items
       rTo(rot.SOUTH)
       for tmpF=1,14,1 do
         dropBySlot(tmpF,turtle.drop)
       end
       dropBySlot(16,turtle.drop)
       turtle.select(cSlot)
-- refuel
       rTo(rot.WEST)
       tmpF = (dStatus.digZ-aPoint.z)*dStatus.digX*dStatus.digY
       if (tmpF < 960) then
         if (turtle.getFuelLevel() < minFuel*2+tmpF) then
           refuel(minFuel*2+tmpF-turtle.getFuelLevel(), 8, "front")
         end
       else
         if (turtle.getFuelLevel() < minFuel*2+960) then
            refuel(minFuel*2+960-turtle.getFuelLevel(), 8, "front")
         end
       end
 -- goto anchor pos
       print("dig: go to anchor pos")
       dStatus.mode=dmode.gofromb
       moveToX(aPoint.x-bPoint.x)
       moveToY(aPoint.y-bPoint.y)
       moveToZs(aPoint.z-bPoint.z)
       rTo(aPoint.r)
       dStatus.mode=dmode.digdown
     end

     if moveTurtle(turtle.forward, turtle.detect, turtle.dig, turtle.attack, maxDigCount) then
       if (cPoint.r==rot.NORTH) then cPoint.y=cPoint.y+1
       else if (cPoint.r==rot.EAST) then cPoint.x=cPoint.x+1
       else if (cPoint.r==rot.SOUTH) then cPoint.y=cPoint.y-1
       else cPoint.x=cPoint.x-1; end; end; end
     else
       -- print("error dig forward!")

       -- up to 1 block
       moveToZs(-1)
       return false
     end
     _it=_it+1

  end
  return true
end


-- move to x coord num steps
function moveToX(num)
  if (num>0) then
    rTo(rot.EAST)
    return forward(num)
  else
    rTo(rot.WEST)
    return forward(-num)
  end

end
-- move to y coord num steps
function moveToY(num)
  if (num<0) then
    rTo(rot.SOUTH)
    return forward(-num)
  else
    rTo(rot.NORTH)
    return forward(num)
  end
end
-- move to z coord num steps
function moveToZ(num)
  if (num>0) then
    return up(num)
  else
    return down(-num)
  end
end

-- move to z and save dig state
function moveToZs(num)
  local _it=0
  if num<0 then
    num=-num
    while (_it < num) do
      cPoint.z = cPoint.z-1
      saveDigState("state")
      if (moveTurtle(turtle.up, turtle.detectUp, turtle.digUp, turtle.attackUp, maxDigCount)) then
      else
        cPoint.z=cPoint.z+1
        saveDigState("state")
        return false
      end
      _it = _it+1
    end
  else
    while (_it < num) do
      cPoint.z = cPoint.z+1
      saveDigState("state")
      if (moveTurtle(turtle.down, turtle.detectDown, turtle.digDown, turtle.attackDown, maxDigCount)) then
      else
        cPoint.z=cPoint.z-1
        saveDigState("state")
        return false
      end
      _it = _it+1
    end
  end
  return true
end

-- move to y and find base blocks
function moveToYb()
  rTo(rot.SOUTH)
  for _it=1,dStatus.digY,1 do
    if turtle.detectUp() then
       turtle.select(15)
       if turtle.compareUp() then
          turtle.select(cSlot)
          return true
       end
       turtle.select(cSlot)
    end
    if (turtle.detect()) then
      if (_db==behavior.brk) then
        turtle.dig()
        if (turtle.detect()) then
          print("error dig forward!")
          return false
        end
      else if (_db==behavior.err) then print("front block!"); return false; end; end
    end
    while turtle.attack() do
      sleep(0.3)
    end;
    turtle.forward()
    cPoint.y=cPoint.y-1
  end
  return false
end
-- move to x and find base position
function moveToXb()
  rTo(rot.WEST)
  for _it=1,dStatus.digX,1 do
    if (turtle.detect()) then
       return true
    end
    while turtle.attack() do
      sleep(0.3)
    end;
    turtle.forward()
    cPoint.x=cPoint.x-1
  end
  return false
end

-- restore real position
function restRealPos()
    if not moveToZs(bPoint.z-cPoint.z) then
      return false
    end
    if not moveToYb() then
      return false
    end
    if not moveToXb() then
      return false
    end
    cPoint.x=bPoint.x
    cPoint.y=bPoint.y
    cPoint.z=bPoint.z
    cPoint.r=rot.WEST
    saveDigState("state")
  return true
end

-- start digging
function startDig()
  local dirX=1
  local dirY=1
  local tmpF=0
  -- compute minimal fuel
    minFuel=dStatus.digX+dStatus.digX+dStatus.digY+dStatus.digZ
  if (dStatus.work >0 ) then
     if (dStatus.mode==dmode.gotob) then
       restRealPos()
-- drop all items
       rTo(rot.SOUTH)
       for tmpF=1,14,1 do
         dropBySlot(tmpF,turtle.drop)
       end
       dropBySlot(16,turtle.drop)
       turtle.select(cSlot)
-- refuel
       rTo(rot.WEST)
       tmpF = (dStatus.digZ-aPoint.z)*dStatus.digX*dStatus.digY
       if (tmpF < 960) then
         if (turtle.getFuelLevel() < minFuel*2+tmpF) then
           refuel(minFuel*2+tmpF-turtle.getFuelLevel(), 8, "front")
         end
       else
         if (turtle.getFuelLevel() < minFuel*2+960) then
            refuel(minFuel*2+960-turtle.getFuelLevel(), 8, "front")
         end
       end
     elseif (dStatus.mode==dmode.gofromb) then
       restRealPos()
     elseif (dStatus.mode==dmode.digdown) then
       aPoint.x=cPoint.x
       aPoint.y=cPoint.y
       aPoint.z=cPoint.z
       aPoint.r=cPoint.r
       restRealPos()
     end

     moveToX(aPoint.x-bPoint.x)
     moveToY(aPoint.y-bPoint.y)
     moveToZs(aPoint.z-bPoint.z)
     print("Zrestore:",cPoint.z)

     rTo(aPoint.r)
     if (cPoint.z-bPoint.z+1-dStatus.skipZ)%2>0 then
       dirY=-1
     else
       dirY=1
     end

     if (cPoint.y-bPoint.y+cPoint.z-bPoint.z+1-dStatus.skipZ)%2>0 then
       dirX=1
     else
       dirX=-1
     end

  else
-- check X orientation blocks
    if (turtle.getItemCount(15) <= dStatus.digX) then
      error("not enouth items in 15 slot")
    end

-- refuel
-- rotate to fuel chest
    rTo(rot.WEST)
    tmpF = (dStatus.digZ-aPoint.z)*dStatus.digX*dStatus.digY
    if (tmpF < 960) then
      if (turtle.getFuelLevel() < minFuel*2+tmpF) then
        refuel(minFuel*2+tmpF-turtle.getFuelLevel(), 8, "front")
      end
    else
      if (turtle.getFuelLevel() < minFuel*2+960) then
         refuel(minFuel*2+960-turtle.getFuelLevel(), 8, "front")
      end
    end
    print("fuel:",turtle.getFuelLevel())

-- create X orientation blocks

    rTo(rot.EAST)
    turtle.select(15)
    local _it=0

    if turtle.detectUp() then
      turtle.digUp()
      if turtle.detectUp() then
        error("error set start X items")
      end
    end
    turtle.placeUp()

    while (_it < dStatus.digX-1) do
      if turtle.detect() then
        turtle.dig()
        if turtle.detect() then
          error("error set start X items")
        end
      end
      turtle.forward()
      if turtle.detectUp() then
        turtle.digUp()
        if turtle.detectUp() then
          error("error set start X items")
        end
      end
      while turtle.attack() do
        sleep(0.3)
      end;
      turtle.placeUp()
      cPoint.x=cPoint.x+1
      _it=_it+1
    end
    turtle.select(cSlot)
    moveToX(bPoint.x-cPoint.x)
    rTo(rot.NORTH)
    dStatus.work=1
    dStatus.mode=dmode.digdown
    saveDigState("state")

-- dig down by z
    if not moveToZs(1) then

    end
    for i=1,dStatus.skipZ,1 do
      if not moveToZs(1) then

      end
    end

    print("Z???:",cPoint.z)

  end

  while (true) do
    while (dirY>0) do
      dStatus.mode=dmode.digdown
      if (dirX >0) then
        moveToX(dStatus.digX-cPoint.x-1)
      else
        moveToX(bPoint.x-cPoint.x)
      end
      dirX=-dirX
      if (cPoint.y==dStatus.digY-1) then
        break
      end
      moveToY(dirY)
    end
    while (dirY<0) do
      dStatus.mode=dmode.digdown
      if (dirX >0) then
        moveToX(dStatus.digX-cPoint.x-1)
      else
        moveToX(bPoint.x-cPoint.x)
      end
      dirX=-dirX
      if (cPoint.y==bPoint.y) then
        break
      end
      moveToY(dirY)
    end
    dirY=-dirY

    if cPoint.z-dStatus.digZ >=0 then
      break
    end
    if not moveToZs(1) then
      if (cPoint.y==dStatus.digY-1) and (cPoint.x==dStatus.digX-1) then
        if not moveToZs(bPoint.z-cPoint.z) then
          return false
        end
        if not moveToYb() then
          return false
        end
        if not moveToXb() then
          return false
        end
        return true
      end
      print("can't dig down")
      moveToZs(-1)
    else
       print("Z+1:",cPoint.z)

    end
  end
  return true
end

function main()
  if startDig() then
    moveToZs(bPoint.z-cPoint.z)
    moveToYb()
    moveToXb()
    rTo(rot.SOUTH)
    for tmpF=1,14,1 do
      dropBySlot(tmpF,turtle.drop)
    end
    dropBySlot(16,turtle.drop)
    turtle.select(cSlot)
    rTo(rot.NORTH)
    dStatus.work=0
    saveDigState("state")
    print("dig: done")
  else
    error("error dig")
  end
end

-- ***** MAIN PROGRAM *****
local tArgs = {...}

if #tArgs > 4 or #tArgs == 0 then
   print( "usage: program <digX> <digY> <digZ> <skipZ>" )
elseif #tArgs == 1 then
  if (tArgs[1]=="r") then
   print("restore previous session...")
   loadDigState("state")
   if (dStatus.work==0) then
     print("previous session not loaded")
     return
   end
   main()
  else
    print( "usage: program <digX> <digY> <digZ> <skipZ>" )
  end
elseif #tArgs == 4 then
  if (tonumber(tArgs[1]) ~= nil) and (tonumber(tArgs[2]) ~= nil) and (tonumber(tArgs[3]) ~= nil)and (tonumber(tArgs[4]) ~= nil) then
    dStatus.digX = tonumber( tArgs[1] )
    if (dStatus.digX <2) or(dStatus.digX > 64) then
      error("error set X dimension")
    end
    dStatus.digY = tonumber( tArgs[2] )
    if (dStatus.digY <2) or(dStatus.digY > 64) then
      error("error set Y dimension")
    end
    dStatus.digZ = tonumber ( tArgs[3] )
    if (dStatus.digZ <2) or(dStatus.digZ > 255) then
      error("error set Z dimension")
    end
    dStatus.skipZ=tonumber (tArgs[4])
    if (dStatus.skipZ <0) or(dStatus.skipZ > 255) then
      error("error set skipZ dimension")
    end
  else
    print( "usage: program <digX> <digY> <digZ> <skipZ>" )
  end
  main()
end