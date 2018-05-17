<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="zh">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="http://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">	
	<link rel="stylesheet" href="${ctx }/assets/baguetteBox/css/baguetteBox.min.css">
	<link rel="stylesheet" href="${ctx }/assets/baguetteBox/css/fluid-gallery.css">
	<link rel="stylesheet" href="${ctx }/assets/layui/css/layui.css" media="all" />
</head>
<body>
<form class="layui-form">
		<blockquote class="layui-elem-quote">
			<div class="layui-inline">
				<a class="layui-btn layui-btn-normal crateCategory">创建相册</a>
			</div>
			<div class="layui-inline">
				<a class="layui-btn layui-btn-normal  batchUppic">上传图片</a>
			</div>
			<div class="layui-inline" style="float:right;">
			    <label class="layui-form-label" >分类</label>
			    <div class="layui-input-block">
				      <select name="interest" lay-verify="required" lay-filter="test">
					         <c:forEach var="category" items="${categorys }" varStatus="status">
				 				<option value="${category.id}" title="${category.name}">${category.name}</option>
							</c:forEach>
				      </select>
    			</div>
  			</div>
  		<!--  删除
  			<div class="layui-inline">
				<input type="checkbox" name="selectAll" id="selectAll" lay-filter="selectAll" lay-skin="primary" title="全选">
			</div>
  			<div class="layui-inline">
				<a class="layui-btn layui-btn-danger batchDel">批量删除</a>
			</div>
		-->		
		</blockquote>
</form>
	<div class="htmleaf-container">
		<div class="container gallery-container">
		    <div class="tz-gallery" >
			     <div class="row">
				    <c:forEach  items="${picturelist}" var="pic">
			    		<div class="col-sm-12 col-md-4" >
				    	  	<a class="lightbox" href="${ctx}/${pic}"> 
				    			<img src="${ctx}/${pic}"> 
				    		</a> 
			    		</div>
					</c:forEach>
				</div>
		    </div>
		</div>
	</div>
	
	<script type="text/javascript" src="${ctx }/assets/baguetteBox/js/baguetteBox.min.js"></script>
	<script>
	baguetteBox.run('.tz-gallery',{
		 animation: 'fadeIn',
	   });
	</script>
	<script type="text/javascript" src="${ctx }/assets/layui/layui.js"></script>
	<script type="text/javascript">
	layui.config({
		base : "assets/js/"
	}).use(['flow','form','layer'],function(){
	    var flow = layui.flow,
	        form = layui.form(),
	        layer = parent.layer === undefined ? layui.layer : parent.layer,
	        $ = layui.jquery;
	   	 form.render();
	    var g_rootPath = "${ctx}";
	  form.on('select(test)', function(data){
		  //获取相册id值
	    	var title=data.elem[data.elem.selectedIndex].title;
	    	//图片上传
			var index = layui.layer.open({
				title :title,
				type : 2,
				content : g_rootPath+"/picture/select?id="+data.value,
				success : function(layero, index){
					setTimeout(function(){
						layui.layer.tips('点击此处返回', '.layui-layer-setwin .layui-layer-close', {
							tips: 3
						});
					},500)
				}
			})
			//改变窗口大小时，重置弹窗的高度，防止超出可视区域（如F12调出debug的操作）
			$(window).resize(function(){
				layui.layer.full(index);
			})
			layui.layer.full(index);
	    	form.render('select');
	   })
	   
	    //创建相册
	    $(".crateCategory").click(function(){
			var index = layui.layer.open({
				title : "创建相册",
				type : 2,
				content : g_rootPath+"/pictureCategory/add",
				success : function(layero, index){
					setTimeout(function(){
						layui.layer.tips('点击此处返回', '.layui-layer-setwin .layui-layer-close', {
							tips: 3
						});
					},500)
				}
			})
			//改变窗口大小时，重置弹窗的高度，防止超出可视区域（如F12调出debug的操作）
			$(window).resize(function(){
				layui.layer.full(index);
			})
			layui.layer.full(index);
		})
		//图片上传
	    $(".batchUppic").click(function(){
			var index = layui.layer.open({
				title : "上传图片",
				type : 2,
				content : g_rootPath+"/picture/add",
				success : function(layero, index){
					setTimeout(function(){
						layui.layer.tips('点击此处返回', '.layui-layer-setwin .layui-layer-close', {
							tips: 3
						});
					},500)
				}
			})
			//改变窗口大小时，重置弹窗的高度，防止超出可视区域（如F12调出debug的操作）
			$(window).resize(function(){
				layui.layer.full(index);
			})
			layui.layer.full(index);
		})

	    //删除单张图片
	    $("body").on("click",".img_del",function(){
	        var _this = $(this);
	        layer.confirm('确定删除图片"'+_this.siblings().find("input").attr("title")+'"吗？',{icon:3, title:'提示信息'},function(index){
	            _this.parents("li").hide(1000);
	            setTimeout(function(){_this.parents("li").remove();},950);
	            layer.close(index);
	        });
	    })

	    //全选
	    form.on('checkbox(selectAll)', function(data){
	        var child = $("#Images li input[type='checkbox']");
	        child.each(function(index, item){
	            item.checked = data.elem.checked;
	        });
	        form.render('checkbox');
	    });

	    //通过判断文章是否全部选中来确定全选按钮是否选中
	    form.on("checkbox(choose)",function(data){
	        var child = $(data.elem).parents('#Images').find('li input[type="checkbox"]');
	        var childChecked = $(data.elem).parents('#Images').find('li input[type="checkbox"]:checked');
	        if(childChecked.length == child.length){
	            $(data.elem).parents('#Images').siblings("blockquote").find('input#selectAll').get(0).checked = true;
	        }else{
	            $(data.elem).parents('#Images').siblings("blockquote").find('input#selectAll').get(0).checked = false;
	        }
	        form.render('checkbox');
	    })

	    //批量删除
	    $(".batchDel").click(function(){
	        var $checkbox = $('#Images li input[type="checkbox"]');
	        var $checked = $('#Images li input[type="checkbox"]:checked');
	        if($checkbox.is(":checked")){
	            layer.confirm('确定删除选中的图片？',{icon:3, title:'提示信息'},function(index){
	                var index = layer.msg('删除中，请稍候',{icon: 16,time:false,shade:0.8});
	                setTimeout(function(){
	                    //删除数据
	                    $checked.each(function(){
	                        $(this).parents("li").hide(1000);
	                        setTimeout(function(){$(this).parents("li").remove();},950);
	                    })
	                    $('#Images li input[type="checkbox"]').prop("checked",false);
	                    form.render();
	                    layer.close(index);
	                    layer.msg("删除成功");
	                },2000);
	            })
	        }else{
	            layer.msg("请选择需要删除的图片");
	        }
	    })
	})
	</script>
</body>
</html>