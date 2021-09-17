$(document).ready(function() {
		// 중복확인 & id 정규식             
		$("#overlapCheck").on("click",function(){
            var id = $("#id").val();
            if(id == ""){
            	alert("아이디를 입력해주세요");
            	return;
            }
            
            
            // 영문 대문자 또는 소문자로 시작하는 아이디, 길이는 5~15자, 끝날때 제한 없음
            var regex = /^[A-za-z]{5,15}/g;
            
        	var result = regex.exec(id);
            
        	 if(result != null){
                 $(".id.regex").html("사용 가능한 아이디 입니다.");
                 $(".id.regex").css("color", "green")
             }else{
                 $(".id.regex").html("영어 대소문자 5~15자로 적어주세요.");
                 $(".id.regex").css("color","red")
             }
        })

        
		//비밀번호 정규식
           $("#password").on("input",function(){
               var regex = /^[A-Za-z\d]{8,12}$/;
               var result = regex.exec($("#password").val())
               
               if(result != null){
                   $(".password.regex").html("");
               }else{
                   $(".password.regex").html("영어대소문자,숫자 8-11자리");
                   $(".password.regex").css("color","red")
               }
           });
           
		//비밀번호 확인    
		$("#passwordCheck").on("keyup",function(){
		     if($("#passwordCheck").val()==$("#password").val()){
		        $(".passwordCheck.regex").html("비밀번호가 일치합니다"); 
		     }else{
		      $(".passwordCheck.regex").html("비밀번호가 일치하지않습니다"); 
		     }
		})


		//email 정규식
        $("#email").on("input",function(){
        	var regex = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
            var result = regex.exec($("#email").val());
            
            if(result != null){
               $(".email.regex").html("");  
            }else{
                $(".email.regex").html("이메일 형식이 맞지 않습니다.");
                $(".email.regex").css("color","red")
            }
        })


		//전화번호 정규식
        $("#phone").on("input",function(){
        	var regex = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
            var result = regex.exec($("#phone").val());
            
            if(result != null){
               $(".phone.regex").html("");  
            }else{
                $(".phone.regex").html("올바른 번호가 아닙니다");
                $(".phone.regex").css("color","red")
            }
            
        })
        
        
        //이름 유효성검사
        $("#name").on("input",function(){
            var regex = /[가-힣]{2,}/;
            var result = regex.exec($("#name").val());
            
            if(result != null){
               $(".name.regex").html("");  
            }else{
                $(".name.regex").html("한글만 입력 가능합니다.");
            }
            
        })


		// 회원가입 버튼 클릭 시
           $("#signupbtn").on("click",function(){
        	   var id = $("#id").val();
        	   var pw = $("#password").val();
        	   var name = $("#name").val();
        	   var phone = $("#phone").val();
        	   var email = $("#email").val();
        	   
        	   var idregex = /^[A-za-z]{5,15}/g;
        	   var pwregex = /^[A-Za-z\d]{8,12}$/;
        	   var nameregex = /[가-힣]{2,}/;
        	   var phoneregex = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
        	   var emailregex = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
        	   
        	   var idregex = idregex.exec(id);
        	   if(idregex == null){
        		   alert("아이디양식을 확인해주세요");
        		   return;
        	   }
        	   var pwregex = pwregex.exec(pw);
        	   if(pwregex == null){
        		   alert("비밀번호양식을 확인해주세요");
        		   retrun;
        	   }
        	   var nameregex = nameregex.exec(name);
        	   if(nameregex == null){
        		   alert("이름양식을 확인해주세요");
        		   retrun;
        	   }
        	   var phoneregex = phoneregex.exec(phone);
        	   if(phoneregex == null){
        		   alert("전화번호양식을 확인해주세요");
        		   retrun;
        	   }
        	   var emailregex = emailregex.exec(email);
        	   if(emailregex == null){
        		   alert("이메일양식을 확인해주세요");
        		   retrun;
        	   }
        	   
             //빈칸 없을 때 제출.
        	   $("#signUpForm").submit();
           })
	})

	// 주소 Api
	function execDaumPostcode() {
       new daum.Postcode({
           oncomplete: function(data) {
               // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

               // 각 주소의 노출 규칙에 따라 주소를 조합한다.
               // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
               var addr = ''; // 주소 변수
               var extraAddr = ''; // 참고항목 변수

               //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
               if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                   addr = data.roadAddress;
               } else { // 사용자가 지번 주소를 선택했을 경우(J)
                   addr = data.jibunAddress;
               }

               // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
               if(data.userSelectedType === 'R'){
                   // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                   // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                   if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                       extraAddr += data.bname;
                   }
                   // 건물명이 있고, 공동주택일 경우 추가한다.
                   if(data.buildingName !== '' && data.apartment === 'Y'){
                       extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                   }
                   // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                   if(extraAddr !== ''){
                       extraAddr = ' (' + extraAddr + ')';
                   }
               }

               // 우편번호와 주소 정보를 해당 필드에 넣는다.
               document.getElementById('postcode').value = data.zonecode;
               document.getElementById("address").value = addr+extraAddr;
               // 커서를 상세주소 필드로 이동한다.
               document.getElementById("detailAddress").focus();
           }
       }).open();
   }
		