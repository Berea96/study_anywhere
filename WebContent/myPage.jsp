<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="bean.MemberBean"%>
<%@ page import="java.io.PrintWriter"%>
<%
	/* 로그인 사용자만 접속 가능 */
	MemberBean loginInfo = (MemberBean) session.getAttribute("loginInfo");

	if (loginInfo == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 하셔야 이용하실 수 있는 서비스 입니다.')");
		script.println("location.href='index.jsp'");
		script.println("</script>");
		script.close();
	} else {
		if (loginInfo.getMEMBER_CHECKED() == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이메일 인증 후 이용해 주세요.')");
			script.println("location.href='emailSendConfirm.jsp'");
			script.println("</script>");
			script.close();
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>My Page</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<style>

/* Remove the navbar's default margin-bottom and rounded borders */
.navbar {
	margin-bottom: 0;
	border-radius: 0;
}

/* Add a gray background color and some padding to the footer */
footer {
	background-color: #f2f2f2;
	padding: 25px;
}

.container {
	padding: 130px;
}

.sidenav {
	background-color: #f1f1f1;
	height: 100%;
}
/* On small screens, set height to 'auto' for sidenav and grid */
@media screen and (max-width: 767px) {
	.sidenav {
		height: auto;
		padding: 15px;
	}
	height: 400px ; .row.content {
		height: auto;
	}
	.boss {
		width: 300px;
		border: 1px solid;
	}
	.left {
		float: left;
		width: 80px;
	}
}
</style>
<script type="text/javascript">
	$(document).ready(() => {
		var oldpass = "";
		$(".container").html($("#editInfoForm").html());
		$("#editInfo").click((e) => {
    		$("li").removeAttr("class");
			e.preventDefault();
			$("#editInfo").parents("li").attr("class", "active");
			$(".container").empty();
			$(".container").html($("#editInfoForm").html());
		});
		
		function editRoom() {
    		$("li").removeAttr("class");
			$("#editRoom").parents("li").attr("class", "active");
    		$.ajax({
    			type: "GET",
    			url: "${pageContext.request.contextPath}/getMemberRooms.do",
    			data: {
    				"id" : "${sessionScope.memberID}"
    			},
    			success: (data) => {
    				var result = JSON.parse(data);
    				$(".container").empty();
    				$(".container").append("<h2>방목록 관리</h2>")
    				$.each(result, (id, it) => {
    					if(it.roomname != "lobby") {
		    				$(".container").append("<div class='row mb-3'> " + 
		    						"<div  id='" + it.roomname + "' name='" + it.roomname + "' data-toggle='modal' data-target='#joinForm' class='" + it.roomname + " dib btn btn-primary col-sm-8' style='text-align: center;'>" +
			    						"<div id='" + it.roomname + "' class='boss'> " + it.roomname + "</div>" +
			    						"<div id='" + it.roompass + "' class='boss2'></div>" +
			    						"<div id='" + it.userid + "' class='boss3'></div>" +
									"</div>");
    					}
    				})
    				$(".dib").click((e) => {
    					var boss = document.getElementsByName(e.target.id)[0];
    					console.log(boss);
    					var roomname = boss.children[0].id;
    					var roompass = boss.children[1].id;
    					oldpass = roompass;
    					var userid = boss.children[2].id;
    					console.log(roomname);
    					console.log(roompass);
    					console.log(userid);
    					$("#roomname").val(roomname);
    					$("#roompass").val(roompass);
    					$("#userid").val(userid);
    				});
    			}
    		});
    	}
		
    	$("#editRoom").click((e) => {
    		e.preventDefault();
    		editRoom();
    	});
    	
    	
    	
    	$("#delMember").click((e) => {
    		$("li").removeAttr("class");
			e.preventDefault();    		
			$("#delMember").parents("li").attr("class", "active");
			$(".container").empty();
			$(".container").html($("#delMemberForm").html());
    	});
    	$("#delRoomBtn").click(() => {
    		var roomname = $("#roomname").val();
    		console.log("클릭");
    		
    		$.ajax({
    			type: "GET",
    			url: "${pageContext.request.contextPath}/deleteMemberRoom.do",
    			data: {
    				"roomname" : roomname
    			},
    			success: (data) => {
    				var result = JSON.parse(data);
    				if(result.result == "true") {
    					$("#joinForm").modal("hide");
						$(".container").empty();
						editRoom();
    				} 
    			}
    		});
    		
    	});
    	$("#joinRoomBtn").click(() => {
    		var roomname = $("#roomname").val();
    		
    		$("#joinForm").modal("hide");
    	});
    	$("#editRoomBtn").click(() => {
    		var roomname = $("#roomname").val();
    		var roompass = $("#roompass").val();
    		var boss = $("#" + roomname);
    		console.log(boss);
    		
    		$.ajax({
    			type: "GET",
    			url: "${pageContext.request.contextPath}/updateMemberRoom.do",
    			data: {
    				"roomname" : roomname,
    				"roompass" : roompass
    			},
    			success: (data) => {
    				var result = JSON.parse(data);
    				if(result.result == "true") {
    					$(".container").empty();
						editRoom();
    				} 
    			}
    		});
    		
    		
    		$("#joinForm").modal("hide");
    	});
	});
</script>
</head>
<body>
	<nav class="navbar navbar-inverse">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#myNavbar">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="./">Study Anywhere</a>
			</div>
			<div class="collapse navbar-collapse" id="myNavbar">

				<!--       <ul class="nav navbar-nav">
        <li class="active"><a href="#">Home</a></li>
        <li><a href="#">About</a></li>
        <li><a href="#">Gallery</a></li>
        <li><a href="#">Contact</a></li>
      </ul>
 -->
				<ul class="nav navbar-nav navbar-right">

					<li><a href="./memberDetail.do"><span
							class="glyphicon glyphicon-log-in"></span> My page</a></li>
					<li><a href="./memberLogout.do"><span
							class="glyphicon glyphicon-log-out"></span> Sign out</a>
				</ul>
			</div>
		</div>
	</nav>


	<div class="container-fluid">
		<div class="row content">
			<div class="col-sm-3 sidenav">
				<h2>Study_Anywhere</h2>
				<ul class="nav nav-pills nav-stacked">
					<li class="active"><a id="editInfo" href="">내정보
							변경</a></li>
					<li><a id="editRoom" href="">방목록 관리</a></li>
					<li><a id="delMember" href="">회원탈퇴</a></li>
					<!-- <li><a href="#section2">Friends</a></li>
        <li><a href="#section3">Family</a></li>
        <li><a href="#section3">Photos</a></li> -->
				</ul>
				<br>
				<!-- 
      <div class="input-group">
        <input type="text" class="form-control" placeholder="Search Blog..">
        <span class="input-group-btn">
          <button class="btn btn-default" type="button">
            <span class="glyphicon glyphicon-search"></span>
          </button>
        </span>
      </div> -->
			</div>

			<div class="col-sm-9">
				<div class="col-md-8 col-lg-9">
					<div class="container">
					</div>
				</div>

			</div>
		</div>
	</div>

	<footer class="container-fluid text-center">
		<p>KITRI 디지털 컨버젼스 28기</p>
	</footer>

	<div id="editInfoForm" style="display: none;">
		<h2>비밀번호 변경</h2>
		<form class="form mt-5" action="memberInfoRivision.do"
			id="memberInfoRivision">
			<div class="form-group">
				<div class="row mb-3">
					<div class="col-sm-3" style="text-align: center;">
						<label><h5>아이디</h5></label>
					</div>
					<div class="col-sm-9">
						<input class="form-control" type="text" readonly="readonly"
							value="${loginInfo.getMEMBER_ID()}" />
					</div>
				</div>

				<div class="row mb-3">
					<div class="col-sm-3" style="text-align: center;">
						<label><h5>현재 비밀번호</h5></label>
					</div>
					<div class="col-sm-9">
						<input class="form-control" name="currentPassword" id="currentPW"
							type="text" placeholder="현재 비밀번호를 입력해 주세요." />
					</div>
				</div>

				<div class="row mb-3">
					<div class="col-sm-3" style="text-align: center;">
						<label><h5>바꿀 비밀번호</h5></label>
					</div>
					<div class="col-sm-9">
						<input class="form-control" name="changePassword" id="passw1"
							onkeyup="passCheck()" type="text" placeholder="바꿀 비밀번호를 입력해 주세요." />
					</div>
				</div>

				<div class="row mb-3">
					<div class="col-sm-3" style="text-align: center;">
						<label><h5>비밀번호 확인</h5></label>
					</div>
					<div class="col-sm-9">
						<input class="form-control" type="text" id="passw2"
							onkeyup="passCheck()" placeholder="바꿀 비밀번호를 한번 더 입력해 주세요." />
					</div>
				</div>

				<div class="row mb-3">
					<div class="col-sm-3" style="text-align: center;">
						<label><h5>이메일</h5></label>
					</div>
					<div class="col-sm-9">
						<input class="form-control" type="text" readonly="readonly"
							value="${loginInfo.getMEMBER_EMAIL()}" />
					</div>
				</div>

				<div class="row text-right">
					<div class="col">
						<p style="color: red;" id="passCheckMessage2"></p>
						<button class="btn btn-primary" type="button" onclick="changePW()">비밀
							번호 변경</button>
					</div>
				</div>
			</div>
		</form>
	</div>

	<div id="delMemberForm" style="display: none;">
		<h2>회원 탈퇴</h2>
		<form id="delForm" class="form mt-5" action=""
			id="memberInfoRivision">
			<div class="form-group">
				<div class="row mb-3">
					<div class="col-sm-3" style="text-align: center;">
						<label><h5>아이디</h5></label>
					</div>
					<div class="col-sm-9">
						<input class="form-control" type="text" name="id" readonly="readonly"
							value="${loginInfo.getMEMBER_ID()}" />
					</div>
				</div>

				<div class="row mb-3">
					<div class="col-sm-3" style="text-align: center;">
						<label id="pwLabel"><h5>비밀번호</h5></label>
					</div>
					<div class="col-sm-9">
						<input class="form-control" name="pw" id="pw"
							type="text" placeholder="현재 비밀번호를 입력해 주세요." value="" />
					</div>
				</div>

				<div class="row mb-3">
					<div class="col-sm-3" style="text-align: center;">
						<label id="deleteLabel"><h5>정말로 탈퇴를 원하신다면 아래의 문자를 입력해 주세요.</h5></label> 
						<label class="text-danger"><h5>나는 정말 탈퇴 할 것이다</h5></label>
					</div>
					<div class="col-sm-9">
						<input class="form-control" type="text" id="deleteText"/>
					</div>
				</div>

				<div class="row text-right">
					<div class="col">
						<p style="color: red;" id="passCheckMessage2"></p>
						<input id="delMemberBtn" type="button" class="btn btn-primary" value="탈퇴" onClick="delCheck()"/>
					</div>
				</div>
			</div>
		</form>
	</div>
	
	<div class="modal" id="joinForm">
		<div class="modal-dialog">
			<div class="modal-content" style="padding: 50px">
				<div class="modal-header">
					<h4 class="modal-title">방 정보 수정</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<form action="editRoom.do" method="post" id="editRoomFormat">
					<div class="form-group">
						<div class="modal-body">

							<div class="row mt-2 mb-2">
								<div class="col-sm-9">
								<h5>
									<label>방제목</label>
								</h5>
									<input class="form-control" name="roomname" type="text"
										id="roomname" readonly="readonly" /> 
								</div>
							</div>

							<div class="row mt-2 mb-2">
								<div class="col-sm-9">
									<label><h5>방 비번</h5></label> <input class="form-control"
										name="roompass" type="roompass" id="roompass" 
										placeholder="비밀번호를 입력해 주세요." />
								</div>
							</div>
							<div class="row mt-2 mb-2">
								<div class="col-sm-9">
									<label><h5>방 주인</h5></label> <input class="form-control"
										name="userid" type="userid" id="userid" 
										readonly="readonly"  />
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<p style="color: red;" id="passCheckMessage"></p>
							<input id="delRoomBtn" type="button" class="btn btn-dark" value="삭제"/>
							<button type="button" class="btn btn-dark" onclick="roomJoin()">접속</button>
							<input id="editRoomBtn" type="button" class="btn btn-dark" value="수정"/>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>

	<script>
   	var passConfirmed = 0;
   
	/* 패스워드 일치 알림 */
	function passCheck() {
		var pass1 = $("#passw1").val();
		var pass2 = $("#passw2").val();
		if(pass1 != pass2) {
			$("#passCheckMessage2").html("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
			$("#passw1").addClass("warn");
			$("#passw2").addClass("warn")
		} else {
			$("#passCheckMessage2").html("");
			$("#passw1").removeClass("warn");
			$("#passw2").removeClass("warn");
			 passConfirmed = 1;
		}
	}
	
	function changePW() {
		if($("#currentPW").val() == ""){
			alert("현재 비밀번호를 입력해주세요.");
			return false;
		}else if(passConfirmed==0) {
			alert("비밀번호가 일치하지 않습니다.");
			return false;
		} else {
			$("#memberInfoRivision").submit();
		}
	}
	
	function delCheck() {
		console.log("클릭했다");
		var sessPw = ${loginInfo.getMEMBER_PW()};
		if(sessPw == $("#pw").val()) {
			$("#pwLabel").removeAttr("style").html("비밀번호");
			if($("#deleteText").val() == "나는 정말 탈퇴 할 것이다") {
				$.ajax({
					type: "GET",
					url: "${pageContext.request.contextPath}/memberDelete.do",
					data: {
						"id": $("#id").val()
					},
					success : (data) => {
						var result = JSON.parse(data);
						if(result.result) {
							
						}
						else {
							
						}
					}
				});
			}
			else {
				$("#deleteLabel").css("color", "red").html("밑의 메시지를 입력하세요.");
			}
		}
		else {
			$("#pwLabel").css("color", "red").html("올바른 비밀번호를 입력하세요.");
		}
	}
   </script>
</body>
</html>
