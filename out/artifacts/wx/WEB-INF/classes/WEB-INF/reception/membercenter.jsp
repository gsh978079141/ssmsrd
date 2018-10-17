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
	
	<script type="text/javascript">
			$(function(){
				$('a[title]').click(function(){
						var src = $(this).attr('title');
						var title = $(this).attr('desc');
						if($('#tt').tabs('exists' ,title)){
							$('#tt').tabs('select',title);
						} else {
							$('#tt').tabs('add',{   
							    title:title,   
							    content:'<iframe frameborder=0 style=width:100%;height:100% src='+ src +' ></iframe>',   
							    closable:true  
							});  
						}
						bindTabEvent();
				});
				bindTabEvent();
				bindTabMenuEvent();
			});
			
			
			function bindTabEvent(){
			$(".tabs-inner").dblclick(function(){
			var subtitle = $(this).children(".tabs-title").text();
				$('#tt').tabs('close',subtitle);
			});
			$(".tabs-inner").bind('contextmenu',function(e){
			$('#mm').menu('show', {
				left: e.pageX,
				top: e.pageY
			});
			var subtitle =$(this).children(".tabs-title").text();
			$('#mm').data("currtab",subtitle);
			return false;
		});
	}	
	function bindTabMenuEvent(){
		var temp = $('#tt');
		//刷新
		$('#mm-tabrefresh').click(function(){
			var currtab_title = $('#mm').data("currtab");
			var frame = temp.tabs('getTab', currtab_title).find('iframe')
			frame.attr('src',frame.attr('src'));
		});
	}
	
	</script>
  </head>
  
  <body>
	<div id="tt" class="easyui-tabs" fit=true style="width:500px;height:250px;"> 
					<!-- S 会员中心 --> 
					<div title="会员中心" style="padding:10px">
							<iframe  frameborder=0 style=width:100%;height:100% src='jump/reception/center.do'></iframe>
					</div>
					<!-- E 会员中心 --> 
					<!-- S 会员办理 -->
					<div title="会员办理" style="padding:10px">
						    <iframe  frameborder=0 style=width:100%;height:100% src='jump/reception/memadd.do'></iframe>
					</div>
					<!-- E 会员办理 -->
					<!-- S 会员充值 -->
					<div title="会员冲值" style="padding:10px" data-options="href:'jump/reception/memrec.do'">
					</div>
					<!-- E 会员充值 -->
					<!-- S 积分兑换 -->
					<div title="积分兑换" style="padding:10px" data-options="href:'jump/reception/mempoint.do'">
					</div>
					<!-- E 积分兑换 -->
					<!-- S 会员消费明细 -->
					<div title="会员消费明细" style="padding:10px" data-options="href:'jump/reception/memconlist.do'">
					</div>
					<!-- E 会员消费明细 -->
	</div>
	
  	<!-- start 右键菜单 -->
		<div id="mm" class="easyui-menu" style="width:50px;">
				<div id="mm-tabrefresh">刷新</div>
		</div>
  	<!-- end 右键菜单 -->
  </body>
</html>
