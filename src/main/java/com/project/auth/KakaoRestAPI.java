package com.project.auth;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

public class KakaoRestAPI {
	
	private final static String id = "0071bab4e0ba935cefd3166f7c763591";
	private final static String url = "http://192.168.6.118:8080/member/kakaoLogin";
	// 카카오
		public static JsonNode getAccessToken(String autorize_code) {
			final String RequestUrl = "https://kauth.kakao.com/oauth/token";
			final List<BasicNameValuePair> postParams = new ArrayList<BasicNameValuePair>();
			postParams.add(new BasicNameValuePair("grant_type", "authorization_code"));
			postParams.add(new BasicNameValuePair("client_id", id)); // REST API KEY
			postParams.add(new BasicNameValuePair("redirect_uri", url)); // 리다이렉트 URI
			postParams.add(new BasicNameValuePair("code", autorize_code)); // 로그인 과정중 얻은 code 값
			final HttpClient client = HttpClientBuilder.create().build();
			final HttpPost post = new HttpPost(RequestUrl);
			JsonNode returnNode = null;
			try {
				post.setEntity(new UrlEncodedFormEntity(postParams));
				final HttpResponse response = client.execute(post);
				final int responseCode = response.getStatusLine().getStatusCode();
				System.out.println("\nSending 'POST' request to URL : " + RequestUrl);
				System.out.println("Post parameters : " + postParams);
				System.out.println("Response Code : " + responseCode);

				// JSON 형태 반환값 처리
				ObjectMapper mapper = new ObjectMapper();
				returnNode = mapper.readTree(response.getEntity().getContent());
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			} catch (ClientProtocolException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
			}
			return returnNode;
		}

		public static JsonNode getKakaoUserInfo(String access_token) {
			final String RequestUrl = "https://kapi.kakao.com/v2/user/me";
			final HttpClient client = HttpClientBuilder.create().build();
			final HttpPost post = new HttpPost(RequestUrl);
			String accessToken = access_token;

			// add header
			post.addHeader("Authorization", "Bearer " + accessToken);
			JsonNode returnNode = null;
			try {
				final HttpResponse response = client.execute(post);
				final int responseCode = response.getStatusLine().getStatusCode();
				System.out.println("\nSending 'POST' request to URL : " + RequestUrl);
				System.out.println("Response Code : " + responseCode);

				// JSON 형태 반환값 처리
				ObjectMapper mapper = new ObjectMapper();
				returnNode = mapper.readTree(response.getEntity().getContent());
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			} catch (ClientProtocolException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				// clear resources
			}
			
			return returnNode;
		}
}
