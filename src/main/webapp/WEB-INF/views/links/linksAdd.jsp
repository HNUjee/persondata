<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>联系人添加</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link rel="stylesheet" href="${ctx }/assets/layui/css/layui.css" media="all" />
</head>
<body class="childrenBody">
	<form class="layui-form" style="width:80%;">
	<input type="hidden" name="id" class="id" value=${link.id}>
		<div class="layui-form-item">
			<label class="layui-form-label">网站名称</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input linksName" lay-verify="required" placeholder="请输入网站名称" value=${link.linkName}>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">网站地址</label>
			<div class="layui-input-block">
				<input type="tel" class="layui-input linksUrl" lay-verify="required|url" placeholder="请输入网站地址" value=${link.linksUrl}>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">站点描述</label>
			<div class="layui-input-block">
				<textarea placeholder="请输入站点描述" class="layui-textarea linksDesc" > ${link.linksDesc}</textarea>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit="" lay-filter="addLinks">立即提交</button>
				<button type="reset" class="layui-btn layui-btn-primary">重置</button>
		    </div>
		</div>
	</form>
	<script type="text/javascript" src="${ctx }/assets/layui/layui.js"></script>
<script type="text/javascript">
layui.config({
	base : "assets/js/"
}).use(['form','layer','jquery'],function(){
	var form = layui.form(),
		layer = parent.layer === undefined ? layui.layer : parent.layer,
		$ = layui.jquery;
 	var g_rootPath = "${ctx}";
 	form.on("submit(addLinks)",function(data){
 		var str={"id":$(".id").val(),
 				"linkName":$(".linksName").val(),
 				"linksUrl":$(".linksUrl").val(),
 				"createTime":new Date().getTime(),
 				"linksDesc":$(".linksDesc").val(),
			}
 		 $.ajax({
 			url : g_rootPath+"/link/save",
 			data : JSON.stringify(str),
 			type:'POST',//默认以get提交，以get提交如果是中文后台会出现乱码
 			contentType:'application/json;charset=utf-8',
 			dataType : 'json',
 			success : function(obj) {
 				
 			}
 		});
 		//弹出loading
 		var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
        setTimeout(function(){
            top.layer.close(index);
			top.layer.msg("添加成功！");
 			layer.closeAll("iframe");
	 		//刷新父页面
	 		parent.location.reload();
        },2000);
 		return false;
 	})
})
</script>
</body>
</html>