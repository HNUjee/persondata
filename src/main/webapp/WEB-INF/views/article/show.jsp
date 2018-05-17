<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>文章添加后台管理</title>
 	<style type="text/css">
    .containers {
        margin: 0 auto;
        width: 1000px;
        height: 100px;
        display: flex;
        flex-direction: column;
    }

    .containers .htitle {
        display: flex;
        align-self: center;
    }

    .containers .mac {
      margin-top:20px;
        display: flex;
        flex-direction: row;
        justify-content: space-between;
    }
    .layuiitem{
    	 margin-top:30px;
    }
    </style>
 	<script src="${ctx }/assets/ueditor/ueditor.parse.js"></script>
</head>
<body class="childrenBody" >
		 <div class="containers">
        <div class=" htitle ">
            <h1>${articlelist.title }</h1>
        </div>
        <div class="mac">
            <div class="info ">
                <label>作者</label>
                <span>${articlelist.author }</span>
            </div>
            <div class="type">
                <label>类型</label>
                <span>${articlelist.type }</span>
            </div>
            <div class="time">
                <label>时间</label>
                <span>${articlelist.createTime }</span>
            </div>
            <div class="keyword">
                <label>关键词</label>
                <span>${articlelist.keywords }</span>
            </div>
        </div>
    </div>
		<div class="layuiitem">
			<div class="ueparse">
				${articlelist.content }
			</div>
		</div>
		<script>
		 uParse('.ueparse', {rootPath:'${ctx }/assets/ueditor/'});
		</script>
	<script type="text/javascript" src="${ctx }/assets/layui/layui.js"></script>
</body>
</html>