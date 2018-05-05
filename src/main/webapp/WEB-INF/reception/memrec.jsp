<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>main</title>
    
	<link rel="stylesheet" type="text/css" href="css/common.css" />
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<link rel="stylesheet" type="text/css" href="js/easyui/themes/bootstrap/easyui.css" />
	<link rel="stylesheet" type="text/css" href="js/easyui/themes/icon.css" />
	<script type="text/javascript" src="js/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui/locale/easyui-lang-zh_CN.js"></script>
	<style type="text/css">
		#hykxx{
			background-color: rgb(239,239,239);
		}
	
	</style>
	
	
  </head>
  		
  <body>
  <h1>会员充值</h1>
  	<div style="margin-left: 20px;margin-top: 50px; width: 650px; font-size: 15px;">
			<div style="background-color:rgb(239,239,239); ">
			会员卡号:<input  name="memnum" id="memnum"  data-options="prompt:'会员卡号'"class="easyui-textbox">
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="checknum();"  iconCls="icon-lock">读取</a>
			会员名：<input type="text" style="width: 90px;"  value=""  class="easyui-textbox" id="memname" readonly="readonly"/>
				
				<script type="text/javascript">
  		function checknum(){
			var memnum=$("#memnum").val();
			if(memnum.length==5){
				$.post("mem/crisearch.do",{memnum:memnum},function(data){
					if(data.total!=0){
							var mem=data.size[0];
							if(mem.state=="2"){
								$.messager.alert('提示:','会员卡已挂失...','error'); 	
							}
							else if(mem.memType.state==0){
								$.messager.alert('提示:','此类型会员已停用','error'); 	
							}
							else if(mem.state=="3"){
								$.messager.alert('警告 :','黑名单会员 无权操作 ...','error'); 	
							}
							else{
							$("#memtype").textbox('setValue',mem.memType.typename);
							$("#state").combobox('setValue',mem.state);  
							//$("#state").textbox('setValue',mem.state);
							$("#tel").textbox('setValue',mem.tel);	
							$("#totalpoints").textbox('setValue',mem.totalpoints);	
							$("#usedpoints").textbox('setValue',mem.usedpoints);	
							$("#leftpoints").textbox('setValue',mem.leftpoints);	
							$("#totalmoney").textbox('setValue',mem.totalmoney);	
							$("#leftmoney").textbox('setValue',mem.leftmoney);
							$("#memname").textbox('setValue',mem.memname);
							$('#memid').val(mem.id);								
							}
						}
						else{
							 $.messager.show({ 
							              title: '提示消息', 
							              msg: '会员卡号不存在，请检查 ', 
							              showType: 'fade', 
							              timeout: 200, 
							              style: { 
							                right: '', 
							                bottom: ''
							              } 
							            }); 
							            
						}
				});
			   }
			 else	
			   $.messager.alert('提示:','会员卡号为五位纯数字','error'); 
		}
  </script>
  			</div>
  			  				<h3>会员卡信息：</h3>
  			
  			<div>
				<div style="margin-left: 10px;background-color:rgb(239,239,239); padding: 20px;" id="hykxx">
				会员等级：<input type="text" style="width: 90px;"  value=""  class="easyui-textbox" id="memtype" readonly="readonly"/>
				会员状态：
					<select class="easyui-combobox" name="state" style="width:80px;height: 30px;" id="state" disabled="disabled" >
							<option value="1">正常</option>
							<option value="2">挂失</option>
							<option value="3">黑名单</option>
						</select>
				
<!-- 				<input type="text"id="state" name="state" value="" class="easyui-textbox" readonly="readonly" style="width:60px;"/>
 -->			绑定手机号：<input type="text"  id="tel" class="easyui-textbox"  value="" readonly="readonly" style="width:120px;"/><br><br>
				总&nbsp;积&nbsp;分：<input type="text" id="totalpoints" value="" class="easyui-textbox" readonly="readonly" style="width:60px;"/>
				兑换积分：<input type="text" id="usedpoints" value="" class="easyui-textbox" readonly="readonly" style="width:60px;"/>
				剩余积分：<input type="text" id="leftpoints" value="" class="easyui-textbox" readonly="readonly" style="width:60px;"/><br/><br>
				总&nbsp;储&nbsp;值：<input type="text" id="totalmoney" value="" class="easyui-textbox" readonly="readonly" style="width:60px;"/>
				剩余储值：<input type="text" id="leftmoney" value="" class="easyui-textbox" readonly="readonly" style="width:60px;"/>
				</div>
  			</div>
  			<form id="myform">
  			<input type="hidden" name="memid" id="memid" value="">
  			<div style="background-color: rgb(239,239,239); margin-top: 30px; padding: 5px;" >
  				充值方式：<select class="easyui-combobox" style="width:100px;" id="czfs" name="paymethod.id" >
							<option value="1">现金</option>
							<option value="3">网上支付</option>
							<option value="4">银联</option>
							<option value="5">信用卡</option>
						</select>
				充值金额:<input type="text" class="easyui-textbox"  style="width:100px;" name="recmoney" id="recmoney"/>
			 </div>
			</form>	
			<br><br>
			 <div align="center" style="text-align: center;">
			 <input type="button" value="确认充值" onclick="surecz();" style="font-size: 30px; background-color: rgb(239,239,239);width: 250px;height: 35px;">
			</div>		
		</div>
		<script type="text/javascript">
				function surecz(){
						$.messager.confirm('会员充值 ', '确认充值账户:'+$("#memname").textbox('getValue')+"("
						+$("#memnum").textbox('getValue')+"),"+"充值金额:"+$("#recmoney").textbox('getValue'),function(r){
						 				if(r){	
						 				$.ajax({  
						                    type: "post",  
						                    url: "mem/recharge.do",  
						                    data: $("#myform").serialize(),  
						                    success: function () {
						                    	$.messager.show({
																title: '提示',
																msg:'充值成功',
																timeout:200,
																showType:'slide',
																 style: { 
														                right: '', 
														                bottom: ''
														              } 
															});
														checknum();	
										 	//parent.$('#win-cz').window('close');
						                    }  
						                });  
					    						}
										});
						}
		
		</script>
			  </body>
</html>