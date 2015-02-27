<!DOCTYPE html>
<html>
<head lang="zh">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <link href="http://libs.useso.com/js/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
    <script src="http://libs.useso.com/js/jquery/2.1.1/jquery.min.js"></script>
    <script src="http://libs.useso.com/js/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <title>上传 - EZShare</title>
    <style>
        #file-div, #text-div {
            transition: .5s;
        }
        .disabled {
            opacity: 0.2;
        }
    </style>
    <script>
        function upload() {
            try {FormData;}
            catch(_) { //fuck IE
                document.getElementById('iesubmit').click();
                return;
            }
            window.uploadbtn=document.getElementById('uploadbtn');
            function progress_callback(event) {
                var percent = Math.round(event.loaded*100/event.total);
                uploadbtn.innerText='上传 '+percent.toString()+'%';
            }
            function complete_callback(event) {
                uploadbtn.innerText='上传完毕';
                if(event.target.responseText==="OK")
                    window.location.assign('/');
                else
                    document.write(event.target.responseText);
            }
            function failed_callback() {
                uploadbtn.removeAttribute('disabled');
                uploadbtn.innerText='上传失败';
            }
            function cancel_callback() {
                uploadbtn.removeAttribute('disabled');
                uploadbtn.innerText='上传取消';
            }
            var xhr=new XMLHttpRequest();
            var fd=new FormData();
            var file=document.getElementById('filein').files[0];
            if(file.size>50*1024*1024) {
                alert('文件不得超过50M');
                return;
            }
            fd.append("xhr","yes");
            fd.append("file","yes");
            fd.append("upfile",file);
            fd.append("avid",document.getElementsByName('avid')[0].value);
            fd.append("strtime",document.getElementsByName('strtime')[0].value);
            xhr.upload.addEventListener("progress",progress_callback,false);
            xhr.addEventListener("load",complete_callback,false);
            xhr.addEventListener("error",failed_callback,false);
            xhr.addEventListener("abort",cancel_callback,false);
            xhr.open("POST", "/up");
            uploadbtn.setAttribute('disabled','disabled');
            xhr.send(fd);
        }
        function help() {
            alert('EZShare 是一个公开的文件临时分享平台。你可以将文字和不超过50MB的文件公开分享，所有看到你的文件的人都可以下载。');
        }
        function change(open,close) {
            document.getElementById(open).classList.remove('disabled');
            document.getElementById(close).classList.add('disabled');
        }
    </script>
</head>
<body style="background-color: #DDD">
<div class="container">
<nav class="navbar navbar-default">
    <div class="container-fluid">
        <div class="navbar-header" style="width: 100%">
            <a href="/" class="btn btn-primary navbar-btn pull-right">
                <span class="glyphicon glyphicon-arrow-left"></span>
            </a>
            <a class="navbar-brand" href="/">
                <span class="glyphicon glyphicon-share-alt"></span>
                &nbsp;EZShare
            </a>
            &nbsp;
            <button type="button" class="btn btn-default navbar-btn" onclick="help()">
                <span class="glyphicon glyphicon-comment"></span>
                &nbsp;使用帮助
            </button>
        </div>
    </div>
</nav>
<form action="/up" method="post" enctype="multipart/form-data">
    <div class="well well-sm"><div class="row">
        <div class="col-sm-6"><div class="input-group">
            <span class="input-group-addon"><span class="glyphicon glyphicon-filter"></span></span>
            <input class="form-control" name="avid" required="required" placeholder="AVID" autofocus="autofocus" tabindex="1000">
            <span class="input-group-btn">
                <button type="button" class="btn btn-default"
                        onclick="alert('使用简短的词语描述你分享的文件。\n不能包含除下划线、横杠外的特殊符号。')">
                    ?
                </button>
            </span>
        </div></div>
        <div class="col-sm-6"><div class="input-group">
            <span class="input-group-addon"><span class="glyphicon glyphicon-time"></span></span>
            <input class="form-control" name="strtime" required="required" placeholder="分享时间" value="1h" tabindex="1001">
            <span class="input-group-btn">
                <button type="button" class="btn btn-default"
                        onclick="alert('格式为“分钟数”、“小时数h 分钟数m”或“小时数 : 分钟数”。\n时间不能超过24h，文件会在到期后自动删除。')">
                    ?
                </button>
            </span>
        </div></div>
    </div></div>
    <div class="input-group" id="file-div" onmouseover="change('file-div','text-div')">
        <span class="input-group-addon"><span class="glyphicon glyphicon-file"></span>&nbsp;上传文件&nbsp;≤50M</span>
        <input id="filein" class="form-control" type="file" name="upfile">
        <span class="input-group-btn">
          <button id="uploadbtn" class="btn btn-primary" type="button" onclick="upload()" name="file" value="yes">上传</button>
        </span>
    </div>
    <button id="iesubmit" style="display: none" type="submit" name="file" value="yes">手动上传</button>
    <br />
    <div class="panel panel-default" id="text-div" onmouseover="change('text-div','file-div')">
        <div class="panel-heading"><h3 class="panel-title">上传文本</h3></div>
        <div class="panel-body">
            <textarea class="form-control" style="height: 250px;" name="uptext" tabindex="1002" placeholder=""></textarea>
            <br />
            <button class="btn btn-primary" style="width: 100%;margin-top: -6px;"
                    type="submit" name="file" value="no" tabindex="1003">
                提交
            </button>
        </div>
    </div>
</form>
</div>
<div style="display: none; height: 0; width: 0;">
<script src="http://s4.cnzz.com/stat.php?id=1254420370&web_id=1254420370" language="JavaScript"></script>
</div>
</body>
</html>