<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="com.project.vo.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/headquarter/headquarterLaunchBusiness.css">
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<title>창업문의 페이지</title>
<script>
$(document).ready(function(){        
	//약관보기 클릭이벤트 
	$("#contractInfo").click(function() {
		$(".agm_cont_wrap").show();
	});
	//약관보기 닫기.
	$(".agm_close").click(function() {
		$(".agm_cont_wrap").hide();
	});

	if($("#idx").val()== -1){
		alert("로그인하고오세요!");
		history.go(-1);
	}
});

	function signup(){
				event.preventDefault();

				if (!$('#request_brand').val()) {
					alert('브랜드를 선택해주세요');
					$("#request_brand").focus();
					return;
				}
				if ($('#request_brand').val() == 1653) {
					alert('더본코리아 통합설명회 선택시 설명회 신청이 되지 않습니다. \n다른 브랜드를 선택해 주세요.');
					$("#request_brand").focus();
					return;
				}
				if(document.getElementById('consent').checked === false){
					alert("약관보기 체크해주세요!");
					return;
				}
				
				var intenral = $(".none-css btn_field:checked").val();
				
				var data = {
					text:$("#boardForm").serialize(),
					consent: $("input#consent").val(),
				  
					startup_field: internal
					
				};

				var data1 = $("#boardForm").serialize();

				var warn = confirm("창업 문의 신청하시겠습니까?");//

				if(warn){
						$.ajax({    
				            url        : 'http://192.168.6.118:8080/rest2/vo/signup/businesslaunch',
				            data    : $("#boardForm").serialize(),
				            cache   : false,
				            async   : true,
				            contentType:"application/x-www-form-urlencoded; charset=utf-8", 
				            type    : "post",    
				            success : function(response) { 
				            	 alert("신청 문의를 완료하였습니다!!");   
				            	 
				            	 var ajaxName = decodeURIComponent(response.ajaxName);
				                 location.href = '${pageContext.request.contextPath}/headquarter';
				                 title.val("");
				                 content.val("");
				            },           
				            error     : function(xhr, status, error) {
				                		alert("에러!");
										alert("code:"+xhr.status+"\n"+"message:"+xhr.responseText+"\n"+"error:"+error);

							}
				            
				        });
				    }else{
						alert("취소!");
					}
				
		}
</script>

</head>
<body>

	<header id="header" class="header">
		<%@ include file="../header.jsp"%>
	</header>
<%  
	MemberVO user = (MemberVO)session.getAttribute("loginMember"); 
	int idx = 0;
	try{
		idx = user.getIdx();
	}catch(Exception e){
		idx = -1;
	}
	System.out.println("idx: " + idx);
%>


<input type = "hidden" id = "idx" value = "<%=idx%>"/>

	<div class="entry-content" style="margin-top: 122px;">
		<div class="sub_header sub_bg05">
			<div>
				<p class="company">THEONE</p>
				<p class="sub_tit">창업안내</p>
				<p class="caption">
					THEONE pursues consistent brand development and business policies
					in order to symbiose between headquarter company and franchised
					CEOs.<br>Rather than just increasing the number of franchise
					companies, we are mostly focusing on maintenance and management of
					their business.<br />Through approximately 300 people from Human
					Resource Department's franchise management, we are able to
					strengthen our competitiveness to other competitors.
				</p>
			</div>
		</div>

		<div class="section_wrap">
			<div class="tabMenu">
				<ul class="cols_06">
					<li><a href="">창업절차</a></li>
					<li><a href="">상생경영</a></li>
					<li><a href="/business-center/found_information/">창업설명회장
							안내</a></li>
					<li><a href="/business-center/calendar/">창업설명회 일정</a></li>
					<li><a href="/business-center/request/">창업설명회 신청</a></li>
					<li><a href="/business-center/inquiry/" class="on">창업 문의</a></li>
				</ul>
			</div>

			<div class="section">
				<div class="location">
					<ul>
						<li><img src="http://www.theborn.co.kr/wp-content/themes/theborn/images/home_icon.jpg" alt=""></li>&nbsp;&nbsp;
						<li>창업센터</li>&nbsp;&nbsp;&nbsp;
						<li>창업설명회 신청</li>
					</ul>
				</div>


				<div class="ft_info">
					<div class="ft_form">
						<p class="desc_h4">창업문의 신청</p>

						<div class="tip">
							<ul>
								<li>
									<p>
										<span>THEONE 대표창업상담번호</span> - 010 - 3982 - 8216&nbsp;&nbsp;<span>빽다방
											창업문의번호</span> - 02 - 3447 - 0410 &nbsp;&nbsp;<span>상담시간</span> -
										10:00 ~ 19:00 [평일]
									</p>
								</li>

								<li>
									<p>
										<span>기타</span> - THEONE의 모든 브랜드는 점포 알선, 중개 등의 추천행위를 하지 않습니다.<br>(점포추천
										관련 일체의 유선 및 인터넷상담을 진행하지 않습니다.)
									</p>
								</li>
							</ul>
						</div>

						<form  id = "boardForm" name = "boardForm" accept-charset="UTF-8">
							<div class="form">
								<div class="form_input">
									<!--20200619 모션아이-->
									<div>
										<label><p>창업희망지역</p></label>
										<div class="form_st">
											<input type="radio" value="국내" name="startup_field" id="internal" class="none-css btn_field" checked="checked">
											<label for="internal">국내</label>
										</div>
									</div>

									<div>
										<label for="">
											<p>브랜드 선택</p>
										</label>
										<div class="form_st">
											<select name="brand" id="request_brand" class="none-css">
												<option value="">브랜드를 선택해주세요</option>
												<option value="빽다방">빽다방</option>
												<option value="한신포차">한신포차</option>
											</select>
											<div class="brand_fail">더본코리아 통합설명회 선택시 설명회 신청이 되지
												않습니다. 다른 브랜드를 선택해 주세요.</div>
										</div>
									</div>
									<!--20200619 모션아이-->
									<div>
										<label for="request_name">
											<p>이름</p>
										</label> <input type="text" id="request_name" name="name" required="">
									</div>
									<div>
										<label for="">
											<p>휴대폰</p>
										</label> <input type="text" name="phone" required="">
									</div>
									<div>
										<label for="email"><p>이메일</p></label> <input type="text" name="email" id="email" required =""> @ 
										<input type="text" name="emaildomain" id="email_domain" value="" required ="">
										
										<select class="none-css" id="form_email_domain" style="height: 34px !important;">
											<option value="">직접입력</option>
											<option value="naver.com">네이버</option>
											<option value="daum.net">다음</option>
											<option value="google.com">구글</option>
										</select>
										
									</div>
									<div>
										<label for="">
											<p>내용/창업희망지역</p>
										</label>
										<textarea cols="90" rows="3" id="location" name="location"></textarea>
									</div>
									
									<div>
		                              <label><p>위치 서비스 이용</p></label>
		                              <div class="form_st">
		                                 <input type="radio" value="yes" name="mapservice" id="yes" class="none-css btn_field" checked="checked">
		                                    <label for="internal">예</label>
		                                 <input type="radio" value="no" name="mapservice" id="no" class="none-css btn_field" checked="checked">
		                                    <label for="internal">아니오</label>
		                              </div>
                           </div>
								</div>

								<div class="agreement">
									<span> <input type="checkbox" id="consent" name="consent" value = "checkedValue" required=""> <label for="">개인정보취급방침
											약관에 동의하기</label>
									</span>
									<p id="contractInfo">
										약관보기 <span></span>
									</p>
									<div class="agm_cont_wrap">
										<p class="agm_close">
											<span></span>
										</p>
										<div class="agm_cont">
											<p class="tit">개인정보처리방침</p>
											<div>
												<p class="tit">더본 코리아의 [개인정보취급방침]을 안내합니다.</p>
												<div>
													<p class="tit">총칙</p>
													<p class="cont">주식회사
														더본코리아('http://www.theborn.co.kr/'이하 '더본코리아')는 고객의 개인정보를
														중요시하며, 개인정보 보호와 관련하여 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」및 개인정보
														보호법 등 관련법 상의 개인정보 보호 규정을 준수하고 개인정보와 관련한 이용자의 고충을 원활하게 처리할
														수 있도록 다음과 같은 처리방침을 두고 있습니다.?더본코리아는 개인정보취급방침을 개정하는 경우 웹사이트
														공지사항(또는 개별공지)을 통하여 공지할 것입니다. 본 방침은?2016년 8월 1일부터 시행됩니다.</p>
												</div>

												<div>
													<p class="tit bold">목차</p>
													<ul>
														<li>제0조 개인정보 수집에 대한 동의</li>
														<li>제1조 개인정보의 수집과 이용 목적</li>
														<li>제2조 개인정보의 보유 및 이용기간</li>
														<li>제3조 정보주체의 권리, 의무 및 행사방법</li>
														<li>제4조 처리하는 개인정보의 항목</li>
														<li>제5조 개인정보 자동수집 장치의 설치, 운영 및 그 거부에 관한 사항</li>
														<li>제6조 개인정보의 파기</li>
														<li>제7조 개인정보의 안전성 확보조치</li>
														<li>제8조 개인정보 보호책임자</li>
														<li>제9조 개인정보 열람창구</li>
														<li>제10조 권익침해 구제방법</li>
														<li>제11조 개인정보취급방침의 개정과 그 공지</li>
													</ul>
												</div>

												<div>
													<p class="tit">제 0조 (개인정보의 수집에 대한 동의)</p>
													<p class="cont">더본코리아는 고객의 개인정보를 수집해야 하는 모든 상황에서,
														개인정보취급방침 또는 이용 약관의 내용에 대하여「동의」또는「취소」버튼을 클릭할 수 있는 절차를 마련하고
														있습니다. 「동의」버튼을 클릭할 경우 더본코리아의 개인정보취급방침과 개인정보 수집에 동의한 것으로
														간주합니다.</p>
												</div>
												<div>
													<p class="tit">제 1조 (개인정보의 수집과 이용 목적)</p>
													<p class="cont">더본코리아는 다음 목적을 위해 개인정보를 수집하고 이용합니다. 처리한
														개인정보는 아래 목적 이외의 용도로는 사용되지 않으며 이용 목적이 변경될 시에는 개인정보 보호법 제
														18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.</p>
													<ul class="dash">
														<li>① 민원사무 처리
															<ul>
																<li>고객 불만사항을 해결하기 위해 고객의 이름과 연락처를 수집합니다. 이후 사실조사와
																	불만사항 처리결과 등을 고객에 안내하기 위해 해당 개인정보를 처리합니다. 또한 고객이 제기한 민원의
																	확인 및 정확한 처리를 위해, 고객이 제공한 개인정보는 민원사무처리에 국한하여 제3자(민원
																	관련자)에게 제공 및 활용될 수 있습니다.</li>
															</ul>
														</li>
														<li>② 재화 또는 서비스 제공
															<ul>
																<li>더본코리아의 창업상담, 창업설명회 신청과 예약정보 확인 등을 목적으로, 신청자에 한해
																	개인정보를 처리합니다.</li>
															</ul>
														</li>
														<li>③ 마케팅 및 광고에의 활용
															<ul>
																<li>서비스의 유효성 확인, 접속빈도 파악 또는 회원의 이용 통계 등을 활용해 더 나은
																	서비스를 제공할 목적으로 개인정보를 처리합니다.</li>
															</ul>
														</li>
													</ul>
												</div>
												<div>
													<p class="tit">제 2조 (개인정보의 보유 및 이용기간)</p>
													<p class="cont">더본코리아는 법령에 따른 개인정보 보유?이용기간 또는 정보주체로부터
														개인정보를 수집 시 동의 받은 개인정보 보유?이용기간 내에서 개인정보를 처리?보유합니다.</p>
													<ul>
														<li>① 개인정보 관리 파일명: 더본코리아 개인정보양식</li>
														<li>② 개인정보 항목: 자택(직장)전화번호, 휴대전화번호, 이름, 이메일</li>
														<li>③ 수집방법: 홈페이지, 전화/팩스</li>
														<li>④ 보유근거: 고객 불만사항 처리 및 결과 안내 전달, 분쟁조정을 위한 기록 보존, 매장
															이용 불만족 사례 데이터화, 개설문의에 따른 상담 내역 자료화</li>
														<li>⑤ 보유기간: 3년</li>
														<li>⑥ 관련법령: 소비자의 불만 또는 분쟁처리에 관한 기록: 3년, 신용정보의 수집/처리 및
															이용 등에 관한 기록: 3년, 계약 또는 청약철회 등에 관한 기록: 5년</li>
													</ul>
												</div>
												<div>
													<p class="tit">제 3조 (정보주체의 권리, 의무 및 행사방법)</p>
													<ul>
														<li>① 정보주체는 더본코리아에 대해 언제든지 다음 각 호의 개인정보 보호 관련 권리를 행사할
															수 있습니다.
															<ul>
																<li>1) 개인정보 열람요구</li>
																<li>2) 오류 등이 있을 경우 정정 요구</li>
																<li>3) 삭제 요구</li>
																<li>4) 취급정지 요구</li>
															</ul>
														</li>
														<li>② 제1항에 따른 권리 행사는 더본코리아에 대해 개인정보보호법 시행규칙 별지 제8호
															서식에 따라 서면, 전화, 전자우편, 모사전송(FAX)등을 통해 하실 수 있으며, 더본코리아는 이에
															대해 지체 없이 조치하겠습니다.</li>
														<li>③ 정보주체가 개인정보의 오류 등에 대한 정정 또는 삭제를 요구한 경우 더본코리아는 정정
															또는 삭제를 완료할 때까지 당해 개인정보를 이용하거나 제공하지 않습니다.</li>
														<li>④ 제1항에 따른 권리 행사는 정보주체의 법정대리인이나 위임을 받은 자 등 대리인을
															통하여 하실 수 있습니다. 이 경우 개인정보 보호법 시행규칙 별지 제11호 서식에 따른 위임장을
															제출하셔야 합니다.</li>
														<li>⑤ 정보주체는 개인정보 보호법 등 관계 법령을 위반하여 더본코리아가 처리하고 있는
															정보주체 본인이나 타인의 개인정보 및 사생활을 침해하여서는 안 됩니다.</li>
													</ul>
												</div>
												<div>
													<p class="tit">제 4조 (처리하는 개인정보의 항목)</p>
													<p class="cont">※ 처리하는 개인정보의 항목은 제2조, 개인정보 관리 현황과
														동일합니다.</p>
												</div>
												<div>
													<p class="tit">제 5조 (개인정보 자동 수집 장치의 설치, 운영 및 거부에 관한 사항)</p>
													<p class="cont">※ 더본코리아는 고객의 정보를 자동으로 수집하는 장치를 운영하지
														않습니다.</p>
												</div>
												<div>
													<p class="tit">제 6조 (개인정보의 파기)</p>
													<p class="cont">더본코리아는 원칙적으로 개인정보 취급목적이 달성된 경우에는 지체 없이
														해당 개인정보를 파기합니다. 파기의 절차, 기한 및 방법은 다음과 같습니다.</p>
													<ul>
														<li>① 파기절차
															<ul class="dash">
																<li>이용자가 입력한 정보는 목적 달성 후 별도의 DB에 옮겨져(종이의 경우 별도의 서류)
																	내부 방침 및 기타 관련 법령에 따라 일정기간 저장된 후 혹은 즉시 파기됩니다. 이 때, DB로
																	옮겨진 개인정보는 법률에 의한 경우가 아니고서는 다른 목적으로 이용되지 않습니다.</li>
															</ul>
														</li>
														<li>② 파기방법
															<ul class="dash">
																<li>더본코리아는 전자적 파일 형태로 기록?저장된 개인정보는 기록을 재생할 수 없도록 로우
																	레벨 포맷(Low Level Format) 등의 방법을 이용하여 파기하며, 종이 문서에 기록?저장된
																	개인정보는 분쇄기로 분쇄하거나 소각하여 파기합니다.</li>
															</ul>
														</li>
														<li>③ 파기기한
															<ul class="dash">
																<li>정보주체의 개인정보는 개인정보의 보유기간이 경과된 경우 종료일로부터 5일 이내에,
																	개인정보의 처리 목적 달성, 해당 서비스의 폐지, 사업의 종료 등 그 개인정보가 불필요하게 되었을
																	때에는 개인정보의 처리가 불필요한 것으로 인정되는 날로부터 5일 이내에 그 개인정보를 파기합니다.
																</li>
															</ul>
														</li>
													</ul>
												</div>
												<div>
													<p class="tit">제 7조 (개인정보의 안전성 확보조치)</p>
													<p class="cont">더본코리아는 개인정보보호법 제 29조에 따라 다음과 같이 안전성 확보에
														필요한 기술적/관리적 및 물리적 조치를 하고 있습니다.</p>
													<ul>
														<li>① 기술적 조치
															<ul class="dash">
																<li>개인정보처리시스템 등의 접근권한 관리, 접근통제시스템 설치, 고유식별정보 등의 암호화</li>
															</ul>
														</li>
														<li>② 관리적 조치
															<ul class="dash">
																<li>내부관리계획 수립 및 시행, 정기적 직원 교육 등</li>
															</ul>
														</li>
														<li>③ 물리적 조치
															<ul class="dash">
																<li>전산실, 자료보관실 등의 접근통제</li>
															</ul>
														</li>
													</ul>
												</div>
												<div>
													<p class="tit">제 8조 (개인정보 보호책임자)</p>
													<p class="cont">더본코리아는 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보
														처리와 관련한 정보주체의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를 지정하고
														있습니다.</p>
													<ul>
														<li>① 개인정보 보호책임자
															<ul class="dotted">
																<li>성명: 김용희</li>
																<li>직책: 팀장</li>
																<li>연락처: 070-4918-9812, meatsauce@theborn.co.kr</li>
															</ul>
														</li>
														<li>② 개인정보 보호 담당부서
															<ul class="dotted">
																<li>부서명: 마케팅기획팀</li>
																<li>담당자: 김홍철</li>
																<li>연락처: 070-4941-8289, dango@theborn.co.kr</li>
															</ul>
														</li>
														<li>③ 정보주체께서는 더본코리아의 서비스(또는 사업)을 이용하시면서 발생한 모든 개인정보
															보호 관련 문의, 불만처리, 피해구제 등에 관한 사항을 개인정보 보호책임자 및 담당부서로 문의하실 수
															있습니다. 더본코리아는 정보주체의 문의에 대해 지체 없이 답변 및 처리해드릴 것입니다.</li>
													</ul>
												</div>
												<div>
													<p class="tit">제 9조 (개인정보 열람청구)</p>
													<p class="cont">정보주체는 개인정보 보호법 제35조에 따른 개인정보의 열람 청구를
														아래의 부서에 할 수 있습니다. 더본코리아는 정보주체의 개인정보 열람청구가 신속하게 처리되도록
														노력하겠습니다.</p>
													<ul>
														<li>① 개인정보 열람청구 접수?처리 부서
															<ul class="dotted">
																<li>부서명: 마케팅기획팀</li>
																<li>담당자: 김홍철</li>
																<li>연락처: 070-4941-8289, dango@theborn.co.kr</li>
															</ul>
														</li>
														<li>② 정보주체께서는 제1항의 열람청구 접수?처리부서 이외에, 행정안전부의 ‘개인정보보호
															종합지원 포털’ 웹사이트(www.privacy.go.kr)를 통하여서도 개인정보 열람청구를 하실 수
															있습니다.</li>
														<li>③ 정보주체께서는 더본코리아의 서비스(또는 사업)을 이용하시면서 발생한 모든 개인정보
															보호 관련 문의, 불만처리, 피해구제 등에 관한 사항을 개인정보 보호책임자 및 담당부서로 문의하실 수
															있습니다. 더본코리아는 정보주체의 문의에 대해 지체 없이 답변 및 처리해드릴 것입니다.</li>
													</ul>
												</div>
												<div>
													<p class="tit">제 10조 (권익침해 구제방법)</p>
													<p class="cont">정보주체는 아래의 기관에 대해 개인정보 침해에 대한 피해구제, 상담
														등을 문의하실 수 있습니다. 아래의 기관은 더본코리아와는 별개의 기관으로서, 더본코리아의 자체적인
														개인정보 불만처리, 피해구제 결과에 만족하지 못하시거나 보다 자세한 도움이 필요한 경우 문의해 주시기
														바랍니다.</p>
													<ul>
														<li>① 개인정보 침해신고센터 (한국인터넷진흥원 운영)
															<ul class="dash">
																<li>소관업무: 개인정보 침해사실 신고, 상담 신청</li>
																<li>홈페이지: privacy.kisa.or.kr</li>
																<li>전화: (국번없이) 118</li>
																<li>주소: (138-950) 서울시 송파구 중대로 135 한국인터넷진흥원
																	개인정보침해신고센터</li>
															</ul>
														</li>
														<li>② 개인정보 분쟁조정위원회 (한국인터넷진흥원 운영)
															<ul class="dash">
																<li>소관업무: 개인정보 분쟁조정신청, 집단분쟁조정 (민사적 해결)</li>
																<li>홈페이지: privacy.kisa.or.kr</li>
																<li>전화: (국번없이) 118</li>
																<li>주소: (138-950) 서울시 송파구 중대로 135 한국인터넷진흥원
																	개인정보침해신고센터</li>
															</ul>
														</li>
														<li>③ 대검찰청 사이버범죄수사단: 02-3480-3573 (www.spo.go.kr)</li>
														<li>④ 경찰청 사이버테러대응센터: 1566-0112 (www.netan.go.kr)</li>
													</ul>
												</div>
												<div>
													<p class="tit">제 11조 (개인정보취급방침 변경 안내)</p>
													<p class="cont">이 개인정보취급방침은 시행일로부터 적용되며, 법령 및 방침에 따른
														변경내용의 추가, 삭제 및 정정이 있는 경우에는 변경사항의 시행 7일 전부터 공지사항을 통해 고지할
														것입니다.</p>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="clear"></div>
								<input type = "hidden" value = "waiting" name = "Status">
								<input type = "hidden" value= "<%=idx%>" name = "member_index"/>
							</div>

						</form>
						
						<div class="form_btn">
									<input type="button" class="submit" value="보내기"  onclick= "javascript:signup();">
									<p class="cancel" id="btn_cancel">취소</p>
						</div>

						<input type = "hidden" id = "msg" value = "창업문의 신청 승인된 사장님들을 위한 알림" class = "form-control">

					</div>
				</div>
			</div>
		</div>
	</div>


	<footer id="footer" class="footer">
		<%@ include file="../footer.jsp"%>
	</footer>
</body>
</html>