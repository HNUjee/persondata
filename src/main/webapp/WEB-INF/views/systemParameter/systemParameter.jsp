<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>系统基本参数</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link rel="stylesheet" href="${ctx}/assets/layui/css/layui.css" media="all" />
	<style type="text/css">
		.layui-table td, .layui-table th{ text-align: center; }
		.layui-table td{ padding:5px; }
	</style>
</head>
<body class="childrenBody">
	<form class="layui-form">
		<table class="layui-table">
			<colgroup>
				<col width="20%">
				<col width="50%">
		    </colgroup>
		    <thead>
		    	<tr>
		    		<th>参数说明</th>
		    		<th>参数值</th>
		    	</tr>
		    </thead>
		    <tbody>
		    	<input type="hidden" name="id"  class="id" value=""/>
		    	<tr>
		    		<td>当前版本</td>
		    		<td><input type="text" class="layui-input currentversion" value="${systems.currentversion} "name="currentversion" placeholder="请输入当前模版版本"></td>
		    	</tr>
		    	<tr>
		    		<td>开发作者</td>
		    		<td><input type="text" class="layui-input author" name="author" value="${system.author}" placeholder="请输入开发作者"></td>
		    	</tr>
		    	<tr>
		    		<td>网站首页</td>
		    		<td><input type="text" class="layui-input homePage"name="homePage" value="${system.homePage }"placeholder="请输入网站首页"></td>
		    	</tr>
		    	<tr>
		    		<td>服务器环境</td>
		    		<td><input type="text" class="layui-input server" name="servers" value="${system.servers }"placeholder="请输入服务器环境"></td>
		    	</tr>
		    	<tr>
		    		<td>数据库版本</td>
		    		<td><input type="text" class="layui-input dataBase" name="dataService" value="${system.dataService}"placeholder="请输入数据库版本"></td>
		    	</tr>
		    	<tr>
		    		<td>jdk版本</td>
		    		<td><input type="text" class="layui-input jdk" name="jdks" value="${system.jdks}"placeholder="请输入jdk版本"></td>
		    	</tr>
		    	<tr>
		    		<td>tomcat版本</td>
		    		<td><input type="text" class="layui-input tomcat" name="tomcat"value="${system.tomcat }" placeholder="请输入运行环境"></td>
		    	</tr>
		    	<tr>
		    		<td>默认关键字</td>
		    		<td><input type="text" class="layui-input keywords"name="keywords" value="${system.keywords }"placeholder="请输入默认关键字"></td>
		    	</tr>
		    	<tr>
		    		<td>网站描述</td>
		    		<td><textarea placeholder="请输入网站描述" class="layui-textarea description" value="${system.description }"name="description"></textarea></td>
		    	</tr>
		    </tbody>
		</table>
		<div class="layui-form-item" style="text-align: right;">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit="" lay-filter="systemParameter">立即提交</button>
				<button type="reset" class="layui-btn layui-btn-primary">重置</button>
		    </div>
		</div>
	</form>
	<script type="text/javascript" src="${ctx}/assets/layui/layui.js"></script>
	<script type="text/javascript">
	layui.config({
		base : "assets/js/"
	}).use(['form','layer','jquery'],function(){
		var form = layui.form(),
			layer = parent.layer === undefined ? layui.layer : parent.layer,
			laypage = layui.laypage,
			$ = layui.jquery;

	 //	var systemParameter;
	 	form.on("submit(systemParameter)",function(data){
	 		$.ajax({
				url : "${ctx}/system/save",
				type : "post",
				dataType : "json",
				data:JSON.stringify(data.field),
				contentType:'application/json;charset=utf-8',
				success : function(data){
				}
			})
	 		var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
	        setTimeout(function(){
	            layer.close(index);
				layer.msg("系统基本参数修改成功！");
	        },2000);
	 		return false;
	 	})


	 	//加载默认数据
	 		$.ajax({
				url : "${ctx}/system/getParameter",
				type : "get",
				dataType : "json",
				success : function(data){
					fillData(data);
				}
			})

	 	//填充数据方法
	 	function fillData(data){
	 		$(".id").val(data[0].id); 
	 		$(".currentversion").val(data[0].currentversion);      //当前版本
			$(".jdk").val(data[0].jdks);        //开发作者
			$(".tomcat").val(data[0].author);
			$(".dataBase").val(data[0].dataService);
			$(".author").val(data[0].author);
			$(".homePage").val(data[0].homePage);    //网站首页
			$(".server").val(data[0].server);        //服务器环境
			$(".dataBase").val(data[0].dataService);    //数据库版本
			$(".description").val(data[0].description);//站点描述
			$(".keywords").val(data[0].keywords);    //默认关键字
	 	}
	 	
	})

	</script>
</body>
</html>