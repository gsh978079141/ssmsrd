<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>极限星空酒店管理-后台管理</title>
  	<link rel="stylesheet" type="text/css" href="css/common.css" />
	<link rel="stylesheet" type="text/css" href="js/easyui/themes/bootstrap/myeasyui.css" />
	<link rel="stylesheet" type="text/css" href="js/easyui/themes/icon.css" />
	<link type="text/css" href="css/sys_main_style.css" rel="stylesheet">
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/echarts/echarts.min.js"></script>
	<style type="text/css">
		ul li{
			font-size: 100px;
		}
	</style>
	<script type="text/javascript">
	$(document).ready(function(){
        $.post("resource/getMenu.do", {}, function(data) {
            $("#menu").tree({
				data:data,
			});
		});
            $(".def-nav,.info-i").hover(function(){
		$(this).find(".pulldown-nav").addClass("hover");
		$(this).find(".pulldown").show();
	},function(){
		$(this).find(".pulldown").hide();
		$(this).find(".pulldown-nav").removeClass("hover");
	});
	
});
			$(function(){
			/*S 菜单事件绑定*/
				$("#menu").tree({
                onClick:function(node){
					if($(this).tree('isLeaf',node.target)){
                        var src=node.attributes.url;
		                var title =node.text;
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
							}
					else{
							$(this).tree(node.state === 'closed' ? 'expand' : 'collapse', node.target);//点击文字展开/折叠
						} 
                	}
            });
           	/*E 菜单事件绑定*/
			/*S 手风琴a标签事件绑定*/
				/*$('a[title]').click(function(){
						var src = $(this).attr('title');
						var title = $(this).html();
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
			/*E 手风琴a标签事件绑定*/
				
				bindTabEvent();
				bindTabMenuEvent();
			});
			function bindTabEvent(){
		$(".tabs-inner").dblclick(function(){
			var subtitle = $(this).children(".tabs-title").text();
            $('#tt').tabs('close',subtitle);
		})
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
		//关闭当前
		$('#mm-tabclose').click(function(){
			var currtab_title = $('#mm').data("currtab");
			$('#tt').tabs('close',currtab_title);
		})
		//全部关闭
		$('#mm-tabcloseall').click(function(){
			$('.tabs-inner span').each(function(i,n){
				var t = $(n).text();
				$('#tt').tabs('close',t);
			});	
		});
		//关闭除当前之外的TAB
		$('#mm-tabcloseother').click(function(){
			var currtab_title = $('#mm').data("currtab");
			$('.tabs-inner span').each(function(i,n){
				var t = $(n).text();
				if(t!=currtab_title)
					$('#tt').tabs('close',t);
			});	
		});
		//关闭当前右侧的TAB
		$('#mm-tabcloseright').click(function(){
			var nextall = $('.tabs-selected').nextAll();
			if(nextall.length==0){
				//msgShow('系统提示','后边没有啦~~','error');
				alert('后边没有啦~~');
				return false;
			}
			nextall.each(function(i,n){
				var t=$('a:eq(0) span',$(n)).text();
				$('#tt').tabs('close',t);
			});
			return false;
		});
		//关闭当前左侧的TAB
		$('#mm-tabcloseleft').click(function(){
			var prevall = $('.tabs-selected').prevAll();
			if(prevall.length==0){
				alert('到头了，前边没有啦~~');
				return false;
			}
			prevall.each(function(i,n){
				var t=$('a:eq(0) span',$(n)).text();
				$('#tt').tabs('close',t);
			});
			return false;
		});

	}
			/*E 菜单事件绑定*/
	</script>
  </head>
  
  <body>
  <!--S  banner -->
  <div>
		  <div class="hd-main clearfix" id="header" style="height: 10%;">
		  	<img src="images/logoko-back.png" style="height: 80px;float: left; margin-left: 50px;"/>
				<div class="info">
					<ul >
						<%-- <li class="info-i user-name has-pulldown">
							<em class="f-icon pull-arrow"></em>
							<a class="f-icon identity" href="" title="未开通VIP"></a>
							<span class="name top-username">${sessionScope.username}</span>
							<div class="pulldown user-info">
								<em class="arrow"></em>
								<div class="content"style="height:100px;" >
									<span class="li"><a href="">个人资料</a></span>
									<span class="li"><a href="">会员中心</a></span>
									<span class="separate-li no-height"></span>
									<span class="li"><a href="javascript:signout();" id="signout">退出</a></span>
									<script type="text/javascript">
										function signout(){
											alert("loginout?");
										}
									</script>	
								</div>
							</div>
						</li> --%>
						<li class="info-i no-separate default-text has-pulldown">
							<em class="f-icon pull-arrow"></em>
							<span class="more" hideFocus="hideFocus">${sessionScope.username}</span>
							<div class="pulldown more-info">
								<em class="arrow"></em>
								<div class="content" style="height:100px;" >
									<span class="separate-li no-height"></span>
									<span class="li"><a href="javascript:alert('gerenziliao');">个人资料</a></span>
									<span class="li"><a href="javascript:loginout();">退出</a></span>
								</div>
							</div>
						</li>
					</ul>
				</div>
			</div>
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
  <!--E  banner -->
		<div id="cc" class="easyui-layout" style="width:100%;height: 89%;">  
<!-- 		    <div region="north" title="banner"  split="false" style="width:280px; height:100px;">
 --><!--		    	  <img src="images/logoko.png" style="height: 100px;margin-left: 50px;background-color: rgb(42,108,160);"/>-->
<!-- 		    </div><div region="south" title="South Title" split="true" style="height:100px;"></div>  -->	
		    <div region="east" collapsed=true iconCls="icon-reload" title="East" split="true" style="width:100px;"></div>  
		    <!-- S 动态菜单区  -->
		    <div region="west"  iconCls="icon-ok" split="true"  style="width:200px;background-color: #F2F2F2;">
             <ul id="menu" class="easyui-tree">
             </ul>
  			</div>
		    <!-- E 动态菜单区  -->
		    <!-- S 主操作区 -->
		    <div region="center"  style="padding:5px;height: 79%;">
				<div id="tt" class="easyui-tabs" fit=true style="width:500px;height: 100%;">  
					<div  class="main" style="padding:5px;" title="主界面" name="main" >
						 <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
						 <!-- S 入住率  -->
    					 <div id="rzl" style="width: 500px;height:300px;float: left;"></div>
    					 <div id="bkly" style="width: 500px;height:350px;float: left;"></div>
    					 <div id="shouzhi" style="width: 500px;height:350px;float: left;"></div>
    					 	<script type="text/javascript">
    					 	
					        // 基于准备好的dom，初始化echarts实例
					        var ruzhulv = echarts.init(document.getElementById('rzl'));
					        var bkly = echarts.init(document.getElementById('bkly'));
					        var shouzhi = echarts.init(document.getElementById('shouzhi'));
					        // 指定图表的配置项和数据
					        var option1 = {
					            title: {
					                text: '房间入住率'
					            },
					            tooltip: {},
					             toolbox: { //可视化的工具箱
					                show: true,
					                feature: {
					                    dataView: { //数据视图
					                        show: true
					                    },
					                    restore: { //重置
					                        show: true
					                    },
					                    dataZoom: { //数据缩放视图
					                        show: true
					                    },
					                    saveAsImage: {//保存图片
					                        show: true
					                    },
					                    magicType: {//动态类型切换
					                        type: ['bar', 'line']
					                    }
					                }
					            },
					            legend: {
					                data:['入住率/%']
					            },
					            xAxis: {
					                data: ["标准间","商务间","圆床房","标准单人间","商务单人间","特价房"]
					            },
					            yAxis: {},
					            series: [{
					                name: '入住率/%',
					                type: 'bar',
					                data: [5, 15, 26, 28, 6, 20]
					            }]
					        };
					       /*E  入住率*/
					        
					        /*S  宾客来源*/
					       var option2 = {
									    title : {
									        text: '宾客来源分析图',
									        x:'center'
									    },
									    tooltip : {
									        trigger: 'item',
									        formatter: "{a} <br/>{b} : {c} ({d}%)"
									    },
									    legend: {
									        x : 'center',
									        y : 'bottom',
									        data:['网上预订','酒店员工','会员介绍','合作单位','电话预订','直接入住']
									    },
									    toolbox: {
									        show : true,
									        feature : {
									            mark : {show: true},
									            dataView : {show: true, readOnly: false},
									            magicType : {
									                show: true,
									                type: ['pie', 'funnel']
									            },
									            restore : {show: true},
									            saveAsImage : {show: true}
									        }
									    },
									    calculable : true,
									    series : [
									        {
									            name:'半径模式',
									            type:'pie',
									            radius : [20, 110],
									            center : ['25%', '50%'],
									            roseType : 'radius',
									            label: {
									                normal: {
									                    show: false
									                },
									                emphasis: {
									                    show: true
									                }
									            },
									            lableLine: {
									                normal: {
									                    show: false
									                },
									                emphasis: {
									                    show: true
									                }
									            },
									            data:[
									                {value:25, name:'网上预订'},
									                {value:5, name:'酒店员工'},
									                {value:15, name:'会员介绍'},
									                {value:25, name:'合作单位'},
									                {value:19, name:'电话预订'},
									                {value:21, name:'直接入住'}
									            ]
									        },
									        {
									            name:'面积模式',
									            type:'pie',
									            radius : [30, 110],
									            center : ['75%', '50%'],
									            roseType : 'area',
									            data:[
									                {value:25, name:'网上预订'},
									                {value:5, name:'酒店员工'},
									                {value:15, name:'会员介绍'},
									                {value:25, name:'合作单位'},
									                {value:19, name:'电话预订'},
									                {value:21, name:'直接入住'}
									            ]
									        }
									    ]
									};
					        /*E  宾客来源*/
					        /*S 收支图*/
								var option3 = {
								title : {
									        text: '收支分析图'
									       
									    },
								    tooltip : {
								        trigger: 'axis',
								        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
								            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
								        }
								    },
								    legend: {
								    		x : 'center',
									        y : 'top',
								        data:['利润', '支出', '收入']
								    },
								    grid: {
								        left: '3%',
								        right: '4%',
								        bottom: '3%',
								        containLabel: true
								    },
								    xAxis : [
								        {
								            type : 'value'
								        }
								    ],
								    yAxis : [
								        {
								            type : 'category',
								            axisTick : {show: false},
								            data : ['周一','周二','周三','周四','周五','周六','周日']
								        }
								    ],
								    series : [
								        {
								            name:'利润',
								            type:'bar',
								            label: {
								                normal: {
								                    show: true,
								                    position: 'inside'
								                }
								            },
								            data:[200, 170, 240, 244, 200, 220, 210]
								        },
								        {
								            name:'收入',
								            type:'bar',
								            stack: '总量',
								            label: {
								                normal: {
								                    show: true
								                }
								            },
								            data:[320, 302, 341, 374, 390, 450, 420]
								        },
								        {
								            name:'支出',
								            type:'bar',
								            stack: '总量',
								            label: {
								                normal: {
								                    show: true,
								                    position: 'left'
								                }
								            },
								            data:[-120, -132, -101, -134, -190, -230, -210]
								        }
								    ]
								};
					      		
					        /*E 收支*/
					        // 使用刚指定的配置项和数据显示图表。
					       	ruzhulv.setOption(option1);
					        bkly.setOption(option2);
					        shouzhi.setOption(option3);
					       
					    </script>
					</div>
				</div> 
		    </div> 
		    <!-- E 主操作区 -->
		 </div>
  	<!-- start 右键菜单 -->
		<div id="mm" class="easyui-menu" style="width:150px;">
				<div id="mm-tabrefresh">刷新</div>
				<div class="menu-sep"></div>
				<div id="mm-tabclose">关闭</div>
				<div id="mm-tabcloseall">全部关闭</div>
				<div id="mm-tabcloseother">除此之外全部关闭</div>
				<div class="menu-sep"></div>
				<div id="mm-tabcloseright">当前页右侧全部关闭</div>
				<div id="mm-tabcloseleft">当前页左侧全部关闭</div>
		</div>
  	<!-- end 右键菜单 -->

  </body>
</html>
