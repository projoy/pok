
var timeOutFade=100;
var backTimeOut=10;

var winTimeRunMark=null;
var timeOutMark=null;
var backTimeOutMark=null;

var spadeRunFinish=false;
var heartRunFinish=false;
var clubRunFinish=false;
var diamondRunFinish=false;
var halfFinish=false;

var backRunStart=true;

function movieLoad(){
    winTimeRun();
}

function winTimeRun(){
    var framTime=parent.document.frames['fratime'];
    if(framTime.document.readyState=='complete'){
	    if(framTime.document.all("remainsecond").innerHTML==""){
	      clearShowPr();
	    }else if(framTime.document.all("issstatshow").innerHTML=="正在开奖"){
	      if(framTime.document.all("remainsecond").innerHTML=="00:30"){
		    document.location.href="/servlet/startwinmovie";
		  }
		  if(document.all("isgetwinval").value=="true"){
		      document.all("isgetwinval").value="false";
		      document.all("issuewinresult").innerHTML="0000000000";
		      document.all("spadewin").innerHTML="0";
		      document.all("heartwin").innerHTML="0";
		      document.all("clubwin").innerHTML="0";
		      document.all("diamondwin").innerHTML="0";
		      prizeBackMovie();//得到中奖信息后启动背景动画
		  }
		  if(backTimeOut==0){//当backTimeOut为0时
		    backTimeOut=10;//恢复backTimeOut
		    clearTimeout(backTimeOutMark);//关闭prizeBackMovie.
		    prizeMovie();//启动prizeMovie
		  }
	    }
    }
    winTimeRunMark=setTimeout("winTimeRun()",1000);
}

function clearShowPr(){
  document.all("issuewinresult").innerHTML="";
  document.all("spadewin").innerHTML="";
  document.all("clubwin").innerHTML="";
  document.all("heartwin").innerHTML="";
  document.all("diamondwin").innerHTML="";
}

function prizeBackMovie(){
  if(backRunStart==true){
    backRunStart=false;
    document.all("spadeimg").src="/pkimages/pokerimage/pokpic/backpic.gif";
    document.all("heartimg").src="/pkimages/pokerimage/pokpic/backpic.gif";
    document.all("clubimg").src="/pkimages/pokerimage/pokpic/backpic.gif";
    document.all("diamondimg").src="/pkimages/pokerimage/pokpic/backpic.gif";
  }
  backTimeOut--;
  backTimeOutMark=setTimeout("prizeBackMovie()", 1000);
}
function prizeMovie(){
  
  var objSpadeImg=document.all("spadeimg");
  var objHeartImg=document.all("heartimg");
  var objClubImg=document.all("clubimg");
  var objDiamondImg=document.all("diamondimg");
  var strWinMaxIss=document.all("hidwinmaxiss").value;
  var strSpadeVal=document.all("hidspadeval").value;
  var strHeartVal=document.all("hidheartval").value;
  var strClubVal=document.all("hidclubval").value;
  var strDiamondVal=document.all("hiddiamondval").value;
  var strSpadePicL=document.all("hidspadepicl").value;
  var strHeartPicL=document.all("hidheartpicl").value;
  var strClubPicL=document.all("hidclubpicl").value;
  var strDiamondPicL=document.all("hiddiamondpicl").value;
  
  document.all("issuewinresult").innerHTML=strWinMaxIss;
  if(spadeRunFinish==false){
    if(halfFinish==false){
      timeOutFade--;
      objSpadeImg.src="/pkimages/pokerimage/pokpic/back.bmp";
      objSpadeImg.filters.alpha.opacity=timeOutFade;
      if(timeOutFade==0){
        halfFinish=true;
      }
    }else if(halfFinish==true){
      objSpadeImg.src=strSpadePicL;
      timeOutFade++;
      objSpadeImg.filters.alpha.opacity=timeOutFade; 
      if(timeOutFade==100){
        spadeRunFinish=true;
        halfFinish=false;
        document.all("spadewin").innerHTML=strSpadeVal;
      }
    }    
  }else if(heartRunFinish==false){
    if(halfFinish==false){
      timeOutFade--;
      objHeartImg.src="/pkimages/pokerimage/pokpic/back.bmp";
      objHeartImg.filters.alpha.opacity=timeOutFade;
      if(timeOutFade==0){
        halfFinish=true;
      }
    }else if(halfFinish==true){
      objHeartImg.src=strHeartPicL;
      timeOutFade++;
      objHeartImg.filters.alpha.opacity=timeOutFade; 
      if(timeOutFade==100){
        heartRunFinish=true;
        halfFinish=false;
        document.all("heartwin").innerHTML=strHeartVal;
      }
    }
  }else if(clubRunFinish==false){
    if(halfFinish==false){
      timeOutFade--;
      objClubImg.src="/pkimages/pokerimage/pokpic/back.bmp";
      objClubImg.filters.alpha.opacity=timeOutFade;
      if(timeOutFade==0){
        halfFinish=true;
      }
    }else if(halfFinish==true){
      objClubImg.src=strClubPicL;
      timeOutFade++;
      objClubImg.filters.alpha.opacity=timeOutFade; 
      if(timeOutFade==100){
        clubRunFinish=true;
        halfFinish=false;
        document.all("clubwin").innerHTML=strClubVal;
      }
    }
  }else if(diamondRunFinish==false){
    if(halfFinish==false){
      timeOutFade--;
      objDiamondImg.src="/pkimages/pokerimage/pokpic/back.bmp";
      objDiamondImg.filters.alpha.opacity=timeOutFade;
      if(timeOutFade==0){
        halfFinish=true;
      }
    }else if(halfFinish==true){
      objDiamondImg.src=strDiamondPicL;
      timeOutFade++;
      objDiamondImg.filters.alpha.opacity=timeOutFade; 
      if(timeOutFade==100){
        diamondRunFinish=true;
        halfFinish=false;
        document.all("diamondwin").innerHTML=strDiamondVal;
        //刷新winnumshow
        parent.document.frames['frawinnumshow'].location.href="/servlet/winnumshow?play=poker";
        parent.document.frames['fratime'].location.href="/lottpok/isstime.jsp";
        document.location.href="/servlet/winnumpost";
      }
    }
  }
  timeOutMark=setTimeout("prizeMovie()", 30);
}
