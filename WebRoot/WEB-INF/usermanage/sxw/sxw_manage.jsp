<%@ page contentType="text/html; charset=gb2312"
    pageEncoding="gb2312" session="true" 
    import="beanpac.IssConInfo,beanpac.PrMoney,pubmethpac.GlobalMeth"%>
<%@ include file="/common/taglibs.jsp"%>

<%GlobalMeth objGM=new GlobalMeth(); %>
<html>
<head>
<title>管理平台-11选五</title>
<%@ include file="/common/meta.jsp"%>

<script type='text/javascript' src='/dwr/interface/DwrBean.js'></script>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/util.js'></script>
<script src="/js/jquery/jquery.js" type="text/javascript"></script>

<script Language="JavaScript">
function toSubmitForm(act){
  
//中奖用户查询
  if(act == "showZjUser"){
	var temp = document.getElementById("queryIssueNum").value;
	if(temp == ""){
		alert("请输入要查询的期号!");
		return;
	}
	document.formZjUser.action="/sxw/sxwManage.do?method=findZjUserInfo";
	document.formZjUser.submit();
  }
  //中奖号码
  if(act == "saveZhongjiang"){
 	//document.formpokwin.action="/sxw/sxwManage.do?method=saveZhongjianghaoma";
	
    //document.formpokwin.submit();
	var tempIssueNum = document.getElementById("zjIssueNum").value;
	if(tempIssueNum == ""){
		alert("请输入期号!");
		return;
	}
	if(fucCheckInt(tempIssueNum) == 0){
		alert("期号只能为数字，请重新输入!");
		return;
	}

	//判断设置的中奖号码中是否有2个相同的数字2011-3-19
	//alert($("#wan").attr("value"));
	//alert($("#wan").val());
	var tempAry = new Array($("#wan").val(),$("#qian").val(),$("#bai").val(),$("#shi").val(),$("#ge").val());
	//alert(tempAry);
	var doubleFlag = false;
	for(var i = 0 ; i < tempAry.length-1; i++){
		var first = tempAry[i];
		for(var j = i+1;j < tempAry.length;j++){
			if(first == tempAry[j]){
				doubleFlag = true;
				break;
			}
		}
	}
	if(doubleFlag){
		if(confirm("有两个或两个以上位置号码发生重复,是否继续保存?")){
			//alert("继续保存...");
			DwrBean.getSxwZjConfig(tempIssueNum,function(data){callback_saveZj(data);});
		}	
	}else{
			//alert("正常保存...");
			DwrBean.getSxwZjConfig(tempIssueNum,function(data){callback_saveZj(data);});
	}
  }
  //基本信息 
  if(act == "saveBaseInfo"){
	// alert("baseInfo");
	// alert("baseInfo");
	var offsetTime = $("#offsetTime").val();
    if(offsetTime > (10*60)){
		alert("请设置偏移时间在10分钟(600秒)以内!");
		return false;

	}
 	document.formregtime.action="/sxw/sxwManage.do?method=saveBaseInfo";
	
    document.formregtime.submit();
  }
}
//保存中奖号码回调函数
function callback_saveZj(data){

 	if(data.issueNum == null){
		document.formpokwin.action="/sxw/sxwManage.do?method=saveZhongjianghaoma";
		
	    document.formpokwin.submit();
	}else if(data.issueNum == "-"){
		alert("内部错误，请重新设置一次 :(");
		return;
	}else{
		if(confirm(data.issueNum+"期已经设置中奖号码，是否要重新设置？")){
			if(confirm(" 重新设置将会删除之前设置的该期的中奖信息，是否继续?")){
				$("#isResetIssueInfo").attr("value","1");
 				document.formpokwin.action="/sxw/sxwManage.do?method=saveZhongjianghaoma";
				document.formpokwin.submit();
			}
		}
	}
}

//得到相应的值
function change_val(val){
	//alert(val);
	DwrBean.getMoneyLimitInfo("sxw",val,function(data){callback_fun(data);});
}
function callback_fun(data){
	//alert(data);
	if(data != null){
		if(data == "," || data == ""){
			document.getElementById("money").value ="";
			document.getElementById("limitOneIssue").value = "";
		}else{
			var str = data.split(",");
		//	alert(str[0]);
			document.getElementById("money").value = str[0];
			document.getElementById("limitOneIssue").value = str[1];
		}
	}
}
//保存限号信息
function toSubmitLimit(){
	//alert("000");
	//alert($("#money").attr("value"));
	var rule=document.getElementById("rule").value;
	var money=document.getElementById("money").value;
	var limit=document.getElementById("limitOneIssue").value;
	if(rule == ""){
		alert("请选择!");
		return;
	}
	//var ttt = $("#money").attr("value");
 	if(money == ""){
		alert("请输入金额!");
		return;
	}
	if(limit == ""){
		alert("请输入限制倍数!");
		return;
	}
	 
 	document.formprmonup.action = "/sxw/sxwManage.do?method=saveLimitInfo";
	formprmonup.submit();
}
//页面加载
$(document).ready(function(){
	//只能输入整数
	$(".style_int_num").bind("keydown",onlyNumbers);

});

//一键删除
function toDelAllRecord(){
	alert("该操作将删除当前玩法下所有的投注记录和中奖记录，请谨慎操作! ");
    if(confirm("删除后将无法恢复，确实要删除吗？")){
		DwrBean.delAllRecordOfSxw(function(data){callback_delAll(data);});
	}
}
function callback_delAll(data){
	if(data){
		alert("删除成功!");
	}else{
		alert("删除失败!");
	}
}

</script>
<style type="text/css">
body,td,th { font-size:13px;}
*{margin:0px}
ul { list-style:none;}
.image1 a:link,.image1 a:visited { color:#000; text-decoration:none}
.image1 a:hover,.image1 a:active { color:#FF0000; text-decoration:underline;}
.image1 { background: url(/pkimages/mainimages/layout.gif) repeat-x top;}
.image2 { padding-top:2px; padding-left:20px;}
.image2 li { float:left; color:#FFF;margin:0 20px}
.image2 a:link,.image2 a:visited { color:#FFF; font-weight:bold; margin:0 2px 0 5px; text-decoration:none;}
.image2 a:active,.image2 a:hover { color:#FFFF00;} 
.image6 { background: url(/pkimages/mainimages/indimage6.gif) repeat-x top;margin:0px;}
</style>
</head>

<body>
<%@ include file="/common/messages.jsp"%>

<input type="hidden" name="pagemark" value="pokplat">

<table width="100%" border="1" align="center" cellpadding="0" cellspacing="0">
<input type="hidden" name="hidmulissvalue" value="">
<input type="hidden" name="hidissuetype" value="">
<input type="hidden" name="hidselling" value="false">
<tr><td align=center style="font:bold; font-size=13px; color:red" height="30"><span>11 选 5</span></td></tr>						  
      <tr>
         <td>
          <table>
           <tr>
           <td align=center>
             <iframe name="fratime" id="fratime" frameborder="0" width="700" height="30"  scrolling="no" src="/sxw/sxwIssueTime.do?method=showIssueTime"></iframe>
           </td>  
           <td align=center width=220></td>
           </tr>
          </table>
         </td>          
       </tr>
        <tr>
           <td>
            <table>
              <tr>
	           <td align=left style="padding-bottom:10px;padding-top:10px;padding-left:10px;">
	              <a href="/sxw/sxwManage.do?method=showZhongjianghaoma">中奖号码查询</a>
	           </td>
			   <!----------走势图---------->
	           <td>
				  <iframe name="fratreent" id="fratreent" frameborder="0" width="200" height="30"  scrolling="no" src="/jsp/public/sxw_zj_zoushi.jsp"></iframe>
              </td>
              </tr>
            </table>
           </td>
        </tr>
        <tr>
           <td>
              <table border=0>
                 <form name="formpokwin" method="post"  style="margin-bottom:10px;margin-top:10px;">
					<input type="hidden" name="isResetIssueInfo"  id="isResetIssueInfo" value="0" size=12>
                 <tr>
                  <td style="color:red">点击"中奖号码添加"按钮后，系统自动取得中奖用户信息。
                  </td>
                 </tr>
                  <tr>					                    
                     <td>
                        期号:<input type="text" name="zjIssueNum" value="" size=12   class="style_int_num" >
					 中奖号码:
					     <% 
						   String[] arrNumValue={"1","2","3","4","5","6","7","8","9","10","11"};
						   String[] arrPlaType={"万位","千位","百位","十位","个位"};
						   String[] arrPlaTypeNamePlus={"wan","qian","bai","shi","ge"};
						   for(int i=0;i<arrPlaType.length;i++){
							   out.println(arrPlaType[i]+":<select name='"+arrPlaTypeNamePlus[i]+"' id='"+arrPlaTypeNamePlus[i]+"'>");
							   for(int j=0;j<arrNumValue.length;j++){
								   out.println("<option value='"+arrNumValue[j]+"'>"+arrNumValue[j]);
							   }
							   out.println("</select>");
						   }%>
					 </td>
					 <td>
			           <input type="button" name="butpokplus" value="中奖号码添加" onClick="toSubmitForm('saveZhongjiang')"> 
   				       <font color=red><%=objGM.removeNull((String)request.getAttribute("remMessage"))%></font>
						
						<c:if test="${saveZhongjianghaoma != null && saveZhongjianghaoma != ''}">
							  <font color=red><c:out value="${saveZhongjianghaoma}"/></font>
					    </c:if>
			         </td>
			      </tr>
		       </form>
	         </table>
         </td>
      </tr>
      
      <tr>
      <td>
      <table border=0>
      <tr><td style="color:red">请输入"期号"值,并点击"中奖用户查询"按钮查询。</td>
      </tr>
      <tr>
        <td>
        <form name="formZjUser"  method="post" style="margin-bottom:10px;margin-top:10px;">
           期号:<input type="text" name="queryIssueNum"   class="style_int_num"  id="queryIssueNum" value="" size=12 >
          <input type="button" name="butpokquery" value="中奖用户查询" onClick="toSubmitForm('showZjUser')"> 
		  <font color=red></font>
        </form>        
        </td>
      </tr>
      </table>
      </td>
      </tr>
      <tr>
           <td>
           <%//IssConInfo objIssCI=new IssConInfo();
           //objIssCI.getIssCon("pokisscon");%>
              <table border=1>
                 <form name="formregtime"  method="post" style="margin-bottom:10px;margin-top:10px;">
                  <tr>					                    
                     <td >
                        <b>期号调整:</b>
                        <font color=red>
                        说明:默认从早晨(9:00)开始销售，每期销售(10)分钟，然后停止销售进行(5)分钟的开奖，每天一共销售(53)期。括号部分可重新设置。
                        </font>
			         </td>
					 <td rowspan="4">
			           <input type="button" name="subreg" value="启动" onClick="toSubmitForm('saveBaseInfo')">   				   
					   <font color=red></font>
					  
			         </td>
			      </tr>
			      <tr>
			        <td >
                        每天开始时间:
                        <input type="text" name="beginHour" class="style_int_num" value="<bean:write name="sxwConfigInfo" property="beginHour"/>" size=2>时
                        <input type="text" name="beginMin" class="style_int_num"  value="<bean:write name="sxwConfigInfo" property="beginMin"/>" size=2>分					 
                        ,每期销售:
                        <input type="text" name="sellMin"  class="style_int_num" value="<bean:write name="sxwConfigInfo" property="sellMin"/>" size=2>分钟
                        ,进行
                        <input type="text" name="winMin"  class="style_int_num" value="<bean:write name="sxwConfigInfo" property="winMin"/>" size=2>分钟的开奖
                        ,每天共销售
                        <input type="text" name="dayIssueTimes"  class="style_int_num" value="<bean:write name="sxwConfigInfo" property="dayIssueTimes"/>" size=2>期

						 <c:if test="${saveBaseInfo != null && saveBaseInfo != ''}">
							  <font color="red"><c:out value="${saveBaseInfo}"/></font>
					    </c:if>
					 </td>
			      </tr>
			      <tr>
			        <td>
			        今天开始期号为:
			        <input type="text" name="beginIssue" size=10   class="style_int_num"  value='<bean:write name="sxwConfigInfo" property="beginIssue"/>'>
			        期号填写样式为：7000001。 7表示2007年.000001表示期号。<font color=red>注意：7前不可加0，7后保持6位，如不可写成07001</font>
			        </td>
			        
			      </tr>


          <%
             //以正负表示开奖时间与服务器时间的偏移量，“+”表示系统的销售/开奖时间比服务器的时间提前，“-”表示系统的开奖时间比服务器的时间滞后。
		   %>
             <tr>					                    
                     <td >
                       <b>销售/开奖时间调整(以秒为单位)</b><br>
					   销售/开奖时间与服务器的时间
					   <select name="offsetFlag" id="offsetFlag"> 
					      <option value="+" <c:if test="${sxwConfigInfo.offsetFlag=='+'}">selected</c:if>>提前</option>
					      <option value="-" <c:if test="${sxwConfigInfo.offsetFlag=='-'}">selected</c:if>>滞后</option>
					   </select>&nbsp;&nbsp;
                        <input type="text" name="offsetTime" id="offsetTime" class="style_int_num"  size=10 value='<c:out value="${sxwConfigInfo.offsetTime}"/>'/>秒
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 					   <br>
                        <font color=red>
                        说明:<br>如果服务器时间是15:30:00，那么“提前10秒”，表示实际的销售/开奖时间是"15:29:50";"滞后10秒"表示实际的销售/开奖时间是“15:30:10”；<br>
						 如果销售/开奖时间需要和服务器时间一致，那么将偏移时间设置为0即可（默认)
                        </font>
			         </td>
			      </tr>

<%/*
        <tr>
           <td colspan=1>
 		  
              <table border=1 width="100%">
                  <tr>					                    
                     <td >
                       <b>销售/开奖时间调整(以秒为单位)</b><br>
					   销售/开奖时间与服务器的时间
					   <select name="offsetFlag" id="offsetFlag"> 
					      <option value="+" <c:if test="${sxwConfigInfo.offsetFlag=='+'}">selected</c:if>>提前</option>
					      <option value="-" <c:if test="${sxwConfigInfo.offsetFlag=='-'}">selected</c:if>>滞后</option>
					   </select>&nbsp;&nbsp;
                        <input type="text" name="offsetTime" id="offsetTime" class="style_int_num"  size=10 value='<c:out value="${sxwConfigInfo.offsetTime}"/>'/>秒
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="button" name="subreg" value="保存并启动" onClick="toSubmitForm('saveBaseInfo')">   
					   <br>
                        <font color=red>
                        说明:<br>如果服务器时间是15:30:00，那么“提前10秒”，表示实际的销售/开奖时间是"15:29:50";"滞后10秒"表示实际的销售/开奖时间是“15:30:10”；<br>
						 如果销售/开奖时间需要和服务器时间一致，那么将偏移时间设置为0即可（默认)
                        </font>
			         </td>
			      </tr>
				  
				</table>
		    </td>
	   </tr>
	*/%>


		       </form>
	         </table>
         </td>
      </tr>
      
<%
  //超级一键删除 2013-5-27
%>
      <tr>
        <td>
           <table>
              <tr>
                 <td>
				     <b>超级一键删除</b> <input type="button" name="btndel" value="清除所有记录" onClick="toDelAllRecord()">   <br><br>
				  
                        <font color=red>
                        说明:该操作将删除当前玩法下所有的投注记录和中奖记录，请谨慎操作!
                        </font>
                 </td>
              </tr> 
		   </table>
         </td>
      </tr>  


      <tr>
        <td>
           <table>
              <tr>
                 <td>修改奖金金额
                 </td>
              </tr>
              <tr>
                 <td>
                   <form name="formprmonup" action="" method="post" style="margin-bottom:10px;margin-top:10px;">
                      <input type="hidden" name="play" value="ssc">
                      <SELECT id="rule" name="rule"  onchange="change_val(this.value)">
						<option value="">请选择...</option>
							<OPTION VALUE="renxuan1">任选一(1中1)</OPTION>
							<OPTION VALUE="renxuan2">任选二(2中2)</OPTION>
							<OPTION VALUE="renxuan2zhiqian2">任选二(直选前2)</OPTION>
							<OPTION VALUE="renxuan2zuqian2">任选二(组选前2)</OPTION>
							<!--
							<OPTION VALUE="renxuan2zuqian2dantuo">任选二(组选前2胆拖)</OPTION>
							
							<OPTION VALUE="renxuan5zhong2">任选二(5中2)</OPTION>
							-->

							<OPTION VALUE="renxuan3">任选三(3中3)</OPTION>						
							<OPTION VALUE="renxuan3zhiqian3">任选三(直选前3)</OPTION>
							<OPTION VALUE="renxuan3zuqian3">任选三(组选前3)</OPTION>
							<!--
							<OPTION VALUE="renxuan3zuqian3dantuo">任选三(组选前3胆拖)</OPTION>
							<OPTION VALUE="renxuan5zhong3">任选三(5中3)</OPTION>-->

							<OPTION VALUE="renxuan4">任选四(4中4)</OPTION>
							<!--<OPTION VALUE="renxuan5zhong4">任选四(5中4)</OPTION>-->
							<OPTION VALUE="renxuan5">任选五(5中5)</OPTION>
							<OPTION VALUE="renxuan6">任选六(6中5)</OPTION>
							<OPTION VALUE="renxuan7">任选七(7中5)</OPTION>
							<OPTION VALUE="renxuan8">任选八(8中5)</OPTION>
		              </SELECT>

		               &nbsp;&nbsp;奖金：<input type="text" name="money" id="money" value="0" size="5" class="style_int_num">元/注
					  &nbsp;&nbsp;
					  限制倍数：<input type="text" name="limitOneIssue" id="limitOneIssue" value="0" size=10 class="style_int_num">倍
		              <input type="button" name="subprmon" value="更新" onclick="toSubmitLimit()">  
					  
					   <c:if test="${saveLimitInfo != null && saveLimitInfo != ''}">
							  <font color="red"><c:out value="${saveLimitInfo}"/></font>
					    </c:if>
                   </form>
                 </td>
              </tr>   
              <tr>
              <%PrMoney objPM=new PrMoney(); %>
                 <td>当前奖金为: <br>
                    <%=objPM.getSscMoneyAndLimit("sxw")%><br>
                 </td>
              </tr>
           </table>
        </td>
      </tr>
</table>

</body>
</html>