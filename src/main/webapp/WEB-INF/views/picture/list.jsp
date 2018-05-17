<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>图片总数</title>
	<link rel="stylesheet" href="${ctx }/assets/layui/css/layui.css" media="all" />
	<link rel="stylesheet" href="${ctx }/assets/css/images.css" media="all" />
</head>
<body class="childrenBody">
<form class="layui-form">
		<blockquote class="layui-elem-quote">
			<div class="layui-inline">
				<a class="layui-btn layui-btn-normal crateCategory">创建相册</a>
			</div>
			<div class="layui-inline">
				<a class="layui-btn layui-btn-normal  batchUppic">上传图片</a>
			</div>
			<div class="layui-inline" style="float:right">
			    <label class="layui-form-label">相册分类</label>
			    <div class="layui-input-block">
				      <select name="interest" lay-verify="required" id="tests" lay-filter="category">
					        <option value="">直接选择或搜索选择</option>
					         <c:forEach var="category" items="${categorys }" varStatus="status">
				 				<option value="${category.id}">${category.name}</option>
							</c:forEach>
				      </select>
    			</div>
  			</div>
  			<div class="layui-inline">
				<input type="checkbox" name="selectAll" id="selectAll" lay-filter="selectAll" lay-skin="primary" title="全选">
			</div>
  			<div class="layui-inline">
				<a class="layui-btn layui-btn-danger batchDel">批量删除</a>
			</div>
		</blockquote>
		<div>
			<ul>
				<li></li>
			</ul>
		</div>
	<ul id="Images">
	</ul> 
</form>

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
	    /* //流加载图片
	    var imgNums = 10;  //单页显示图片数量
		    flow.load({
		        elem: '#Images', //流加载容器
		        done: function(page, next){ //加载下一页
		            $.get(g_rootPath+"/picture/getpicture",function(data){
		            	console.log(data[0].srcpath)
		                var imgList = [];
		                var maxPage = imgNums*page < data.length ? imgNums*page : data.length;
		                setTimeout(function(){
		                    for(var i=imgNums*(page-1); i<maxPage; i++){
		                        imgList.push('<li><img style="width:200px;height:200px" src="'+${ctx}/+''+data[i].srcpath+'"><div class="operate"><div class="check"><input type="checkbox" name="belle" lay-filter="choose" lay-skin="primary""></div><i class="layui-icon img_del">&#xe640;</i></div></li>')
		                    }
		                    next(imgList.join(''), page < (data.length/imgNums));
		                    form.render();
		                }, 500);
		            }); 
		        }
		    }); */
		    $("#tests").change(function(){
		    	 $(this).css("background-color","#FFFFCC");
	    	})
	/*   form.on('select(category)', function(data){
	    	var imgNums = 10;  //单页显示图片数量
	    	
		    flow.load({
		        elem: '#Images', //流加载容器
		        isLazyimg:true,
		        isAuto:false,
		        done: function(page, next){ //加载下一页
		            $.get(g_rootPath+"/picture/select",{
		            	cateid:data.value
		            },function(res){
		            	//console.log(res)
		                var imgList = [];
		                var maxPage = imgNums*page < res.length ? imgNums*page : res.length;
		                setTimeout(function(){
		                 for(var i=imgNums*(page-1); i<maxPage; i++){
		                	// imgList.push('<li><img lay-src="'+${ctx}/+''+res[i][4]+'"></li>');
		                      imgList.push('<li><img style="width:200px;height:200px" src="'+${ctx}/+''+res[i][4]+'"><div class="operate"><div class="check"><input type="checkbox" name="belle" lay-filter="choose" lay-skin="primary" title="'+res[i].imageFileName+'"></div><i class="layui-icon img_del">&#xe640;</i></div></li>')
		                    }
		                    next(imgList.join(''), page < (res.length/imgNums));
		                    form.render('select');
		                }, 500);
		            
		            }); 
		        	
		        }
		    });
	    	//console.log(data.value)
	   // }),
	   */
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