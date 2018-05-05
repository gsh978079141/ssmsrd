<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>极限星空酒店管理</title>
   <link rel="stylesheet" type="text/css" href="css/common.css" />
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<link rel="stylesheet" type="text/css" href="js/easyui/themes/bootstrap/easyui.css" />
	<link rel="stylesheet" type="text/css" href="js/easyui/themes/icon.css" />
	<script type="text/javascript" src="js/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui/locale/easyui-lang-zh_CN.js"></script>
	
	<script type="text/javascript">
			$(function(){
				/*$('a[title]').click(function(){
						var myframe=$("#main");
						var nowsrc=myframe.attr('src');
						var src = $(this).attr('title');
						if(src!=nowsrc){
						myframe.attr('src',src);
						}
					});*/
					$('#win').window("close");
					$('a[title]').click(function(){
						var myframe=$("#main");
						var title=$(this).attr('tip');
						var nowsrc=myframe.attr('src');
						var src = $(this).attr('title');
						if(src!=nowsrc&&src!="jump/reception/roomcenter.do"){
						myframe.attr('src',src);
						$('#win').window({
							title:title,
    						closed:false,
						    onBeforeClose:function(){ 
        					 	 myframe.attr('src',"");
      						 	},
      						onMinimize: function () {     
			                //最下化移动到右下角并折叠          
			                      $('#win').window('move', {   
			                                       left: "26%",    
			                                        top: "-5px"             
			                         }).window('collapse').window('open'); 
          						}     
						});
					}
				});
				});
				</script>
  </head>
  
  <body>
  			<!-- S top  -->
  			<div region="north" title="banner"  split="false" style="height:100px;background-color: rgb(42,108,160);">
	  			<img src="images/logoko.png" style="height: 100px;margin-left: 50px;"/>
					   		 <a title="jump/reception/roomcenter.do" style="margin-left: 450px;"><img src="images/ftzx.png"/></a> 
					   		 <a title="jump/reception/reserve.do" tip="预定管理"><img src="images/ydgl.png"/></a>
					   		 <a title="jump/reception/membercenter.do" tip="会员中心"><img src="images/khgx.png"/></a> 
					   		 <a href="javascript:void(0);" onclick="loginout();" tip="安全退出"><img src="images/aqtc.jpg" width="73" height="77"/></a> 
		    </div> 
		    <script type="text/javascript">
		    	function loginout(){
		    			$.messager.confirm('安全退出', '确认退出？',function(r){
						 				if(r){	
						 					window.location.href="login/loginout.do";  
					    					}
										});
		    	
		    	}
		    </script>
  			<!-- E top  -->
  			<!-- S center  -->
		    <div >
		    	<iframe src="jump/reception/roomcenter.do" noresize="noresize"  marginwidth="0"  frameborder="0" style="width: 100%;height: 83.5%;" ></iframe>
		    </div>
  			<!-- S center  -->
		    <div id="win" class="easyui-window"  style="width:800px;height:650px;padding:10px;">
 				<iframe src="" name="main" id="main" noresize="noresize"  marginwidth="0"  frameborder="0" style="width: 100%;height: 100%;"></iframe>
			</div>
		    <div style="background-color: rgb(40,105,157); color:white ;height: 30px; text-align: center;" ><label>酒店编号：${sessionScope.hotelnum}</label>&nbsp;&nbsp;&nbsp;&nbsp;<label>酒店名称：${sessionScope.hotelname}</label>&nbsp;&nbsp;&nbsp;&nbsp;<label>当前用户:${sessionScope.username}</label></div>
  </body>
</html>
