<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>文章添加</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<meta http-equiv="Content-Type" content="multipart/form-data; charset=utf-8" />
	<link rel="stylesheet" href="${ctx }/assets/layui/css/layui.css" media="all" />
</head>
<body class="childrenBody">
	<form class="layui-form" action="${ctx }/article/save" method="post" >
		<input type="hidden" class="layui-input id" name="id"  value=${articlelist.id }>
		<div class="layui-form-item">
			<label class="layui-form-label">文章标题</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input title" name="title" lay-verify="required" placeholder="请输入文章标题" value=${articlelist.title }>
			</div>
		</div>                                                               
		<div class="layui-form-item">
			<div class="layui-inline">		
				<label class="layui-form-label">文章作者</label>
				<div class="layui-input-inline">
					<input type="text" class="layui-input author" name="author" lay-verify="author" placeholder="请输入文章作者" value=${articlelist.author }>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">浏览权限</label>
				<div class="layui-input-inline">
					<select name="look" class="look" lay-filter="browseLook">
				        <option value="true">开放浏览</option>
				        <option value="false">限制浏览</option>
				    </select>
				</div>
			</div>
			<div class="layui-inline" style="z-index:1000">
				<label class="layui-form-label">类别</label>
				<div class="layui-input-inline">
					<select name="articletype.id" class="type" >
					<c:forEach var="stu" items="${type }" varStatus="status">
						 <option value="${stu.id}">${stu.typeName}</option>
					</c:forEach>
				    </select>
				</div>
			</div>
		</div>
		<div class="layui-form-item">
		
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">关键字</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input keywords" name="keywords" placeholder="请输入文章关键字" value=${articlelist.keywords }>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">文章内容</label>
			<div class="layui-input-block">
			<script id="editor" class="content" type="text/plain" style="width:1024px;height:500px;" name="content">
				${articlelist.content }
			</script>
			</div>
		</div>
		
	</form>
	<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn addNews" lay-submit="" lay-filter="addNews">立即提交</button>
				<button type="reset" class="layui-btn layui-btn-primary">重置</button>
		    </div>
		</div>
	 <script type="text/javascript" charset="utf-8" src="${ctx }/assets/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${ctx }/assets/ueditor/ueditor.all.min.js"> </script>
    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
    <script type="text/javascript" charset="utf-8" src="${ctx }/assets/ueditor/lang/zh-cn/zh-cn.js"></script>
	<script type="text/javascript">
		var ue = UE.getEditor('editor');
	</script>
	<script type="text/javascript" src="${ctx }/assets/layui/layui.js"></script>
	<script type="text/javascript" src="${ctx }/assets/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="${ctx }/assets/jquery-form/jquery.form.min.js"></script>
	<script type="text/javascript">
	layui.use(['form', 'layer','upload'], function(){
		  var layer = layui.layer,
		  	  upload = layui.upload,
		  	   form = layui.form();
		  form.render();
		  
	 $("form").on("submit", function(e) {
		 // 阻止表单默认提交事件
			e.preventDefault();
			var $this = $(this);
			// jquery-form的异步提交方式
			$this.ajaxSubmit({
				beforeSubmit : function(data, $form) {
					/* var name = $form.find("input[name='name']");
					if ($.trim(name.val()) === "") {
						 layer.tips('请输入名字', '.name');
						return false; 
					}
					var email = $form.find("input[name='email']");
					if ($.trim(email.val()) === "") {
						 layer.tips('请输入邮箱', '.email');
						return false; 
					}
					var position = $form.find("input[name='position']");
					if ($.trim(position.val()) === "") {
						 layer.tips('请输入职位', '.position');
						return false; 
					}
					var mobile = $form.find("input[name='mobile']");
					if ($.trim(mobile.val()) === "") {
						 layer.tips('请输入电话', '.mobile');
						return false; 
					}
					var address = $form.find("input[name='address']");
					if ($.trim(address.val()) === "") {
						 layer.tips('请输入地址', '.address');
						return false; 
					} */
				},
				success : function() {
					$("form").find(".addNews").attr("disabled",true); 
					 layer.alert('添加成功',{icon: 1}); 
					 setTimeout(function(){
						parent.location.reload();
					 },2000);
				}
			});
		});
	// 保存用户
	 $(".childrenBody").find(".addNews").on("click", function() {
		$(".childrenBody").find("form").trigger("submit");
	});
});   
	</script>
</body>
</html>