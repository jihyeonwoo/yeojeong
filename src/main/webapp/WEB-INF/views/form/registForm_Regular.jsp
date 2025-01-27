<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>회원가입</title>

<link href="resources/css/kh_bootstrap.min.css?asd=asdda"
	rel="stylesheet">
<script type="text/javascript" src="resources/js/jquery.js"></script>
<script src="resources/js/kh_bootstrap.min.js"></script>

<style type="text/css">
.form-control {
	border-radius: 4px 4px 4px 4px;
	border-left-color: #ccc;
	width: 100%;
	height: 40px
}
</style>
<script type="text/javascript">
	var flag_id = false;
	var flag_password = false;
	var flag_name = false;
	var flag_year = false;
	var flag_month = false;
	var flag_day = false;
	var flag_email = false;
	var flag_email_Certified = false;
	var flag_tel = false;

	var idCheck_1 = /^[0-9]/;
	var idCheck_2 = /\s/g;
	var idCheck_3 = /[`~!@#$%^&*|\\\'\";:\/?]/g;
	var idCheck_4 = /^[a-zA-Z0-9]{4,12}$/;
	
	var passwordCheck_1 = /\s/g;
	var passwordCheck_2 = /[`~!@#$%^&*|\\\'\";:\/?]/;
	var passwordCheck_3 = /^.*(?=^.{8,16}$)(?=.*\d)(?=.*[a-zA-Z]).*$/;
	
	var nameCheck_1 = /\s/g;
	var nameCheck_2 = /[`~!@#$%^&*|\\\'\";:\/?]/;
	
	var yearCheck_1 = /\s/g;
	var yearCheck_2 = /^[0-9]{4,4}$/;
	
	var dayCheck_1 = /\s/g;
	var dayCheck_2 = /^[0-9]{2,2}$/;
	
	var emailCheck_1 = /\s/g;
	var emailCheck_2 = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
	
	var telCheck_1 = /\s/g;
	var telCheck_2 = /^[0-9]{11,11}$/;
	
	
	
	var send_email_code = "";
	$(function() {
// 		````````````````````이메일 인증 관련//

		
$("#regist_btn").on("click",function(){
	
			var all_flag = false;
			
					
					if(!flag_id){
						alert("아이디를 확인하세요");
						$("#member_id").focus();
						all_flag = false;
						return;
					}else if(!flag_password){
						alert("패스워드를  확인하세요.");
						$("#password").focus();
						all_flag = false;
						return;
					}else if(!flag_name){
						alert("이름을  확인하세요.");
						$("#name").focus();
						all_flag = false;
						return;
					}else if(!flag_year){
						alert("(년)을  확인하세요.");
						$("#year").focus();
						all_flag = false;
						return;
					}else if(!flag_month){
						alert("(월)을  확인하세요.");
						$("#month").focus();
						all_flag = false;
						return;
					}else if(!flag_day){
						alert("(일)을  확인하세요.");
						$("#day").focus();
						all_flag = false;
						return;
					}else if(!flag_email){
						alert("이메일을  확인하세요.");
						$("#email").focus();
						all_flag = false;
						return;
					}else if(!flag_email_Certified){
						alert("이메일인증을  확인하세요.");
						all_flag = false;
						return;
					}else if(!flag_tel){
						alert("휴대전화를  확인하세요.");
						$("#tel").focus();
						all_flag = false;
						return;
					}
					all_flag = true;
					var member = new Object();
					
					member.member_id = $("#member_id").val();
					member.password = $("#password").val();
					member.name = $("#name").val();
					member.gender = $('input[name="gender"]:checked').val();
// 					날짜 포맷
					var birth = $("#year").val()+"-"+$("#month").val() +"-" + $("#day").val();
			        console.log(birth);
			        member.birth = birth;
			        
					member.email = $("#email").val();
					member.tel = $("#tel").val();
					
					var memberJsonObject = JSON.stringify(member);
					// alert(memberJsonObject);
				
			if(all_flag){
				$.ajax({
					url : "<%=request.getContextPath()%>/regist_Regular",
					type : "post",
					contentType : "application/json; charset=UTF-8",
					data : memberJsonObject,
					dataType : "text",
					success : function(data) {
						alert(member.name +"님 회원가입 성공. 로그인 페이지로 이동합니다.");
						
						if(eval(data)){
							window.location.href = 'http://localhost:8080/yeojeong/login';
						}else{
							alert("회원가입 실패(관리자에게 문의하세요.)");
						}
					},
					error : function(data) {
						alert("통신오류(관리자에게 문의하세요.)");
					}
				});
			};
});
			
// 		``````````````````````````//
		
		
		
		
		
// 		`````````````````월 입력 이벤트//
		$('#month').change(function() {
		    var month = $(this).val();
		    if(month=="0"){
		    	$("#span_ymd").css("color", "red")
				$("#span_ymd").text("월을 정확히 입력하세요.");
		    	flag_month = false;
		    }else{
		    	$("#span_ymd").css("color", "blue")
				$("#span_ymd").text("사용 가능한 월입니다.");
		    	flag_month = true;
		    	
		    }
		   
		});
		$("#email_ac").on("focusout",function(){
			
			var email_ac = $("#email_ac").val();
// 			if(email_ac==""){
// 				$("#span_email_ac").text("코드를 입력하세요.");
// 				   $("#span_email_ac").css("color","red")
// 					flag_email_Certified = false;
// 				   return;
// 			}
			
			
			if(email_ac== send_email_code){
				$("#span_email_ac").text("코드 일치");
				$("#time_ac").text("");
			    $("#span_email_ac").css("color","blue")
				flag_email_Certified = true;
			}	else {
				$("#span_email_ac").text("코드 불일치");
	     	    $("#span_email_ac").css("color","red")
				flag_email_Certified = false;
			}
			
		});
// 		````````````````````````````//
		
		
		
// 		```````````````인증 타이머//
		function countdown( elementName, minutes, seconds ) {
			
		    var element, endTime, hours, mins, msLeft, time;
			 flag_email_Certified =false;
		    function twoDigits( n )
		    {
		        return (n <= 9 ? "0" + n : n);
		    }

		    function updateTimer(){
		    	if(flag_email_Certified){
					return;
				}
		        msLeft = endTime - (+new Date);
		        if ( msLeft < 1000 ) {
		        	
		            element.innerHTML = "인증번호를 다시 발급받으세요.";
		        	send_email_code = "";
		            flag_email_Certified = false;
		            		            
		            $("#span_email_ac").css("color","red");
		        } else {
		            time = new Date( msLeft );
		            hours = time.getUTCHours();
		            mins = time.getUTCMinutes();
		            element.innerHTML = (hours ? hours + ':' + twoDigits( mins ) : mins) + ':' + twoDigits( time.getUTCSeconds() );
		            setTimeout( updateTimer, time.getUTCMilliseconds() + 500 );
		        }
		    }

		    element = document.getElementById( elementName );
		    endTime = (+new Date) + 1000 * (60*minutes + seconds) + 500;
		    updateTimer();
		}

		
		$("#email_button").on("click",function(){
			
			var email = $("#email").val();
			 $("#span_email_ac").text("");
			countdown("time_ac", 3, 0 );
			$.ajax({
				url : "<%=request.getContextPath()%>/sendMail",
				type : "post",
				data : "email=" + email,
				dataType : "text",
				success : function(data) {
					send_email_code = data;
					
				},
				error : function(data) {
					alert("통신오류(관리자에게 문의하세요.)");
				}
			});
		});
		
		
		
	});
// ````````````````````//
	function id_keyup() {
		if ($("#member_id").val() == "") {
			$("#span_member_id").text("아이디를 입력하세요");
			$("#span_member_id").css("color", "red");
			flag_id = false;
			return;
		} else if (idCheck_1.test($("#member_id").val())) {
			$("#span_member_id").text("아이디는 숫자로 시작하지 않습니다.");
			$("#span_member_id").css("color", "red");
			flag_id = false;
			return;
		} else if (idCheck_2.test($("#member_id").val())) {
			$("#span_member_id").text("공백을 포함하지 않습니다.");
			$("#span_member_id").css("color", "red");
			flag_id = false;
			return;
		} else if (idCheck_3.test($("#member_id").val())) {
			$("#span_member_id").text("특수문자는 포함하지 않습니다.");
			$("#span_member_id").css("color", "red");
			flag_id = false;
			return;
		} else if (!idCheck_4.test($("#member_id").val())) {
			$("#span_member_id").text("아이디는  영어 대소문자와 숫자만 들어갑니다.(4~12자)");
			$("#span_member_id").css("color", "red");
			flag_id = false;
			return;
		} else {
			var member_id = $("#member_id").val();
			$.ajax({
				url : "<%=request.getContextPath()%>/searchID",
				type : "post",
				data : "member_id=" + member_id,
				dataType : "text",
				success : function(data) {
					if (eval(data)) {
						flag_id = true;
						$("#span_member_id").css("color", "blue");
						$("#span_member_id").text("사용 가능한 아이디입니다.");
					} else {
						$("#span_member_id").css("color", "red");
						$("#span_member_id").text("이미 사용중인 아이디 입니다.");
					}
				},
				error : function(data) {
					alert("통신오류(관리자에게 문의하세요.)");
				}
			});

		}

	};
	function password_keyup() {
		if ($("#password").val() == "") {
			$("#span_password").text("영문 대 소문자, 특수문자, 숫자를 사용하세요.(8~16자)");
			$("#span_password").css("color", "red")
			flag_password = false;
			return;
		} else if (passwordCheck_1.test($("#password").val())) {
			$("#span_password").text("공백을 포함하지 않습니다.");
			$("#span_password").css("color", "red")
			flag_password = false;
			return;
		} else if (!passwordCheck_2.test($("#password").val())) {
			$("#span_password").text("특수문자를 포함해야 합니다.");
			$("#span_password").css("color", "red")
			flag_password = false;
			return;
		} else if (!passwordCheck_3.test($("#password").val())) {
			$("#span_password").text("영문 대 소문자, 숫자를 사용하세요.(8~16자)");
			$("#span_password").css("color", "red")
			flag_password = false;
			return;
		} else {
			flag_password = true;
			$("#span_password").css("color", "blue")
			$("#span_password").text("사용 가능한 패스워드입니다.");
		}

	};
	function name_keyup() {
		if ($("#name").val() == "") {
			$("#span_name").text("이름을 입력하세요.");
			$("#span_name").css("color", "red")
			flag_name = false;
			return;
		} else if (nameCheck_1.test($("#name").val())) {
			$("#span_name").text("공백을 포함하지 않습니다.");
			$("#span_name").css("color", "red")
			flag_name = false;
			return;
		} else if (nameCheck_2.test($("#name").val())) {
			$("#span_name").text("특수문자를 포함하지 않습니다.");
			$("#span_name").css("color", "red")
			flag_name = false;
			return;
		} else {
			flag_name = true;
			$("#span_name").css("color", "blue")
			$("#span_name").text("사용 가능한 이름입니다.");
		}
	};
	function year_keyup() {
		if ($("#year").val() == "") {
			$("#span_ymd").text("태어난 년도 4자리를 입력하세요.");
			$("#span_ymd").css("color", "red")
			flag_year = false;
			return;
		} else if (yearCheck_1.test($("#year").val())) {
			$("#span_ymd").text("공백을 포함하지 않습니다.");
			$("#span_ymd").css("color", "red")
			flag_year = false;
			return;
		} else if (!yearCheck_2.test($("#year").val())) {
			$("#span_ymd").text("숫자 4자리를 입력하세요.");
			$("#span_ymd").css("color", "red")
			flag_year = false;
			return;
		} else {
			flag_year = true;
			$("#span_ymd").css("color", "blue")
			$("#span_ymd").text("사용 가능한 년도입니다.");
			var month = $("#month").val();
			if(month=="0"){
				$("#span_ymd").css("color", "red")
				$("#span_ymd").text("월을 입력하세요");
			}
		}
	};
	function day_keyup() {
		if ($("#day").val() == "") {
			$("#span_ymd").text("태어난 일 2자리를 입력하세요.");
			$("#span_ymd").css("color", "red")
			flag_day = false;
			return;
		} else if (dayCheck_1.test($("#day").val())) {
			$("#span_ymd").text("공백을 포함하지 않습니다.");
			$("#span_ymd").css("color", "red")
			flag_day = false;
			return;
		} else if (!dayCheck_2.test($("#day").val())) {
			$("#span_ymd").text("숫자 2자리를 입력하세요.");
			$("#span_ymd").css("color", "red")
			flag_day = false;
			return;
		} else {
			flag_day = true;
			$("#span_ymd").css("color", "blue")
			$("#span_ymd").text("사용 가능한 일입니다.");
			var month = $("#month").val();
			if(month=="0"){
				$("#span_ymd").css("color", "red")
				$("#span_ymd").text("월을 입력하세요");
			}
		}
	};
// 	```````````````이메일검사//
	function email_keyup() {
	
	
		if ($("#email").val() == "") {
			$("#span_email").text("이메일을 입력하세요.");
			$("#span_email").css("color", "red")
			flag_email = false;
			return;
		} else if (emailCheck_1.test($("#email").val())) {
			$("#span_email").text("공백을 포함하지 않습니다.");
			$("#span_email").css("color", "red")
			flag_email = false;
			return;
		} else if (!emailCheck_2.test($("#email").val())) {
			$("#span_email").text("이메일형식에 맞지 않습니다.");
			$("#span_email").css("color", "red")
			flag_email = false;
			return;
		} else {
			var email = $("#email").val();
			$.ajax({
				url : "<%=request.getContextPath()%>/searchEmail",
				type : "post",
				data : "email=" + email,
				dataType : "text",
				success : function(data) {
					if (eval(data)) {
						flag_email = true;
						$("#span_email").css("color", "blue");
						$("#span_email").text("사용 가능한 이메일입니다.");
					} else {
						flag_email = false;
						$("#span_email").css("color", "red");
						$("#span_email").text("이미 사용중인 이메일 입니다.");
					}
				},
				error : function(data) {
					alert("통신오류(관리자에게 문의하세요.)");
				}
			});
		} 
		
		
		
		
		
		
		
		
	};
// 	```````````````````````````//
	function tel_keyup() {
		if ($("#tel").val() == "") {
			$("#span_tel").text("전화번호를 입력하세요.");
			$("#span_tel").css("color", "red")
			flag_tel = false;
			return;
		} else if (telCheck_1.test($("#tel").val())) {
			$("#span_tel").text("공백을 포함하지 않습니다.");
			$("#span_tel").css("color", "red")
			flag_tel = false;
			return;
		} else if (!telCheck_2.test($("#tel").val())) {
			$("#span_tel").text("전화번호 11자리를 확인하세요.");
			$("#span_tel").css("color", "red")
			flag_tel = false;
			return;
		} else {
			flag_tel = true;
			$("#span_tel").css("color", "blue")
			$("#span_tel").text("사용 가능한 전화번호입니다.");
		}
	};
</script>
</head>
<body style="overflow: scroll;">


	<div style="height: 25%;"></div>

	<form:form modelAttribute="member">

		<table
			style="border-spacing: 10px; margin: auto; border-collapse: separate;">
			<tr>
				<th colspan="3"
					style="color: rgb(52, 152, 219); text-align: center; font-family: sans-serif; font-size: 30px;">
					여정 회원가입</th>
			</tr>
			<tr>
				<th colspan="3"><form:input id="member_id" size="30"
						class="form-control" path="member_id" placeholder="아이디"
						onkeyup="id_keyup();" /> <span id="span_member_id"
					style="color: red;"></span></th>
			<tr>
				<th colspan="3"><form:password id="password" size="30"
						class="form-control" path="password" placeholder="비밀번호"
						onkeyup="password_keyup();" /><span id="span_password"
					style="color: red;"></span></th>
			</tr>
			<tr>
				<th colspan="3"><form:input id="name" size="30"
						class="form-control" path="name" placeholder="이름"
						onkeyup="name_keyup();" /><span id="span_name"
					style="color: red;"></span></th>
			</tr>
			<tr>
				<th style="text-align: center;" colspan="3"><label><input
						type="radio" name="gender" value="2" checked />남자</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<label><input type="radio" name="gender" value="1" />여자</label></th>
			</tr>

			<tr>
				<th style="width: 100px"><input size="30" type="text"
					class="form-control" id="year" name="year" placeholder="년 (4자)"
					onkeyup="year_keyup();" /></th>
				<th style="width: 100px"><select style="" id="month"
					class="form-control" name="month">
						<option value="0" selected="selected">월</option>
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
						<option value="6">6</option>
						<option value="7">7</option>
						<option value="8">8</option>
						<option value="9">9</option>
						<option value="10">10</option>
						<option value="11">11</option>
						<option value="12">12</option>
				</select></th>
				<th style="width: 100px"><input size="30" type="text"
					class="form-control" id="day" name="day" placeholder="일 "
					onkeyup="day_keyup();" /></th>
			</tr>
			<tr>
				<th colspan="3"><span id="span_ymd" style="color: red;"></span></th>
			</tr>
			<tr>
				<th colspan="2"><form:input id="email" size="30"
						class="form-control" path="email" placeholder="이메일(선택)"
						onkeyup="email_keyup();" /></th>
				<td><button id="email_button" style="width: 100%; height: 40px"
						type="button" class="btn btn-primary">이메일 인증</button></td>
			</tr>
			<tr>
				<th colspan="3"><span id="span_email" style="color: red;"></span>
				</th>
			</tr>
			<tr>
				<th colspan="2"><input id="email_ac" size="30"
					class="form-control" placeholder="코드를 입력하세요." /></th>
				<th colspan="1"><span id="time_ac"></span></th>
			</tr>

			<tr>
				<th><span id="span_email_ac" style="color: red;"></span></th>
			</tr>
			<tr>
				<th style="width: 100px" colspan="3"><form:input id="tel"
						size="30" class="form-control" path="tel"
						placeholder="휴대폰번호를 입력하세요." onkeyup="tel_keyup();" /></th>
			</tr>
			<tr>
				<th colspan="3"><span id="span_tel" style="color: red;"></span>
				</th>
			</tr>
			<tr>
				<th colspan="3">
					<button id="regist_btn" style="width: 100%; height: 40px"
						type="button" class="btn btn-primary">가입</button>
				</th>
			</tr>


		</table>


	</form:form>






</body>
</html>