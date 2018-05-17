<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>首页</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link rel="stylesheet" href="${ctx}/assets/layui/css/layui.css" media="all" />
	<link rel="stylesheet" href="//at.alicdn.com/t/font_tnyc012u2rlwstt9.css" media="all" />
	<link rel="stylesheet" href="${ctx}/assets/css/main.css" media="all" />
</head>
<body class="childrenBody">
	<div class="panel_box row">
		<div class="panel col">
			<a href="javascript:;" data-url="${ctx}/user/allUsers">
				<div class="panel_icon" style="background-color:#009688;">
					<i class="layui-icon" data-icon="&#xe613;">&#xe613;</i>
				</div>
				<div class="panel_word userAll">
					<span></span>
					<cite>用户总数</cite>
				</div>
			</a>
		</div>
		<div class="panel col">
			<a href="javascript:;" data-url="${ctx}/picture/list">
				<div class="panel_icon" style="background-color:#5FB878;">
					<i class="layui-icon" data-icon="&#xe64a;">&#xe64a;</i>
				</div>
				<div class="panel_word imgAll">
					<span></span>
					<cite>图片总数</cite>
				</div>
			</a>
		</div>
		<div class="panel col max_panel">
			<a href="javascript:;" data-url="${ctx}/article/list">
				<div class="panel_icon" style="background-color:#2F4056;">
					<i class="iconfont icon-text" data-icon="icon-text"></i>
				</div>
				<div class="panel_word allNews">
					<span></span>
					<em>文章总数</em>
					<cite>文章列表</cite>
				</div>
			</a>
		</div>
	</div>
	
	<div><!-- 系统参数 -->
		<div class="sysNotice">
		</div>
	</div>

	<script type="text/javascript" src="${ctx}/assets/layui/layui.js"></script>
	<script type="text/javascript">

	layui.config({
		base : "assets/js/"
	}).use(['form','element','layer','jquery'],function(){
		var form = layui.form(),
			layer = parent.layer === undefined ? layui.layer : parent.layer,
			element = layui.element(),
			$ = layui.jquery;

		$(".panel a").on("click",function(){
			window.parent.addTab($(this));
		})

		//动态获取文章总数和待审核文章数量,最新文章
		$.get("${ctx}/article/getArticle",
			function(data){
				var waitNews = [];
				$(".allNews span").text(data.length);  //文章总数
			}
		)

		//图片总数
		$.get("${ctx}/picture/getpicture",
			function(data){
				$(".imgAll span").text(data.length);
			}
		)

		//用户数
		$.get("${ctx}/user/getlist",
			function(data){
				$(".userAll span").text(data.length);
			}
		)



		//数字格式化
		$(".panel span").each(function(){
			$(this).html($(this).text()>9999 ? ($(this).text()/10000).toFixed(2) + "<em>万</em>" : $(this).text());	
		})
			
		//填充数据方法
	 	function fillParameter(data){
	 		//判断字段数据是否存在
	 		function nullData(data){
	 			if(data == '' || data == "undefined"){
	 				return "未定义";
	 			}else{
	 				return data;
	 			}
	 		}
	 		$(".version").text(nullData(data.version));      //当前版本
			$(".author").text(nullData(data.author));        //开发作者
			$(".homePage").text(nullData(data.homePage));    //网站首页
			$(".server").text(nullData(data.server));        //服务器环境
			$(".dataBase").text(nullData(data.dataBase));    //数据库版本
			$(".maxUpload").text(nullData(data.maxUpload));    //最大上传限制
			$(".userRights").text(nullData(data.userRights));//当前用户权限
	 	}

	})

	</script>
</body>
</html>
