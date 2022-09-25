package com.swan.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.swan.model.MemberVO;
import com.swan.model.OrderDTO;
import com.swan.model.OrderListVO;
import com.swan.model.OrderPageDTO;
import com.swan.service.MemberService;
import com.swan.service.OrderService;

@Controller
public class OrderController {

	public static final String IMPORT_TOKEN_URL = "https://api.iamport.kr/users/getToken";
	public static final String IMPORT_PAYMENTINFO_URL = "https://api.iamport.kr/payments/find/";
	public static final String IMPORT_CANCEL_URL = "https://api.iamport.kr/payments/cancel";
	public static final String IMPORT_PREPARE_URL = "https://api.iamport.kr/payments/prepare";

	public static final String KEY = "";
	public static final String SECRET = "";

	@Autowired
	private OrderService orderService;

	@Autowired
	private MemberService memberService;

	// 아임포트 인증(토큰)을 받아주는 함수
	public String getImportToken() {
		String result = "";
		
		HttpClient client = HttpClientBuilder.create().build();
		
		HttpPost post = new HttpPost(IMPORT_TOKEN_URL);
		
		Map<String, String> m = new HashMap<String, String>();
		
		m.put("imp_key", KEY);
		
		m.put("imp_secret", SECRET);
		try {
			post.setEntity(new UrlEncodedFormEntity(convertParameter(m)));
			HttpResponse res = client.execute(post);
			ObjectMapper mapper = new ObjectMapper();
			String body = EntityUtils.toString(res.getEntity());
			JsonNode rootNode = mapper.readTree(body);
			JsonNode resNode = rootNode.get("response");
			result = resNode.get("access_token").asText();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	// Map을 사용해서 Http요청 파라미터를 만들어 주는 함수
	private List<NameValuePair> convertParameter(Map<String, String> paramMap) {
		List<NameValuePair> paramList = new ArrayList<NameValuePair>();

		Set<Entry<String, String>> entries = paramMap.entrySet();

		for (Entry<String, String> entry : entries) {
			paramList.add(new BasicNameValuePair(entry.getKey(), entry.getValue()));
		}
		return paramList;
	}

	// '주문 페이지' 이동을 수행하는 URL 매핑 메소드를 추가
	@RequestMapping(value = "/orders/{member_id}", method = { RequestMethod.GET, RequestMethod.POST })
	// URL을 통해 전달받는 member_id를 파라미터 변수로 선언하였고, 상품 정보를 전달받을 수 있도록 OrderPageDTO 타입의
	// 변수를 선언. 그리고 이 메서드에서 만들어낸 정보를 뷰로 전달하기 위해서 Mdoel 타입의 파라미터 변수를 추가
	public String orderPageGet(@PathVariable("member_id") String member_id, OrderPageDTO opd, Model model) {

		// 상품 정보 만들어 내는 Service
		model.addAttribute("orderList", orderService.getProductsInfo(opd.getOrders()));

		// 회원 정보 만들어내는 Service
		model.addAttribute("memberInfo", memberService.getMemberInfo(member_id));

		return "/orders";

	}

	// 뷰에서 요청하는 '주문'을 처리하는 URL 매핑 메서드
	@GetMapping(value = "/orders")
	public String orderPagePost(OrderDTO od, HttpServletRequest request) {

		System.out.println(od);

		orderService.order(od);

		// 회원 정보 session인 "member"에 변동 값이 적용된 MemberVO 객체로 바꿔줌
		MemberVO member = new MemberVO();
		member.setId(od.getMember_id());

		HttpSession session = request.getSession();

		try {
			MemberVO memberLogin = memberService.login(member);
			session.setAttribute("member", memberLogin);

		} catch (Exception e) {

			e.printStackTrace();
		}

		return "redirect:/swan";
	}

	/* 환불 */
	@RequestMapping(value = "/cancel")
	@ResponseBody
	public int cancelPayment(String token, String merchant_uid) {
		HttpClient client = HttpClientBuilder.create().build();
		HttpPost post = new HttpPost(IMPORT_CANCEL_URL);
		Map<String, String> map = new HashMap<String, String>();
		post.setHeader("Authorization", token);
		map.put("merchant_uid", merchant_uid);
		String asd = "";
		
		try {
			post.setEntity(new UrlEncodedFormEntity(convertParameter(map)));
			HttpResponse res = client.execute(post);
			ObjectMapper mapper = new ObjectMapper();
			String enty = EntityUtils.toString(res.getEntity());
			JsonNode rootNode = mapper.readTree(enty);
			asd = rootNode.get("response").asText();
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (asd.equals("null")) {
			System.err.println("환불 실패");
			return -1;
		} else {
			System.err.println("환불 성공");
			return 1;
		}
	}
	
	// 아임포트 결제정보를 조회해서 결제금액을 뽑아주는 함수
		public String getAmount(String token, String mId) {
			String amount = "";
			HttpClient client = HttpClientBuilder.create().build();
			HttpGet get = new HttpGet(IMPORT_PAYMENTINFO_URL + mId + "/paid");
			get.setHeader("Authorization", token);

			try {
				HttpResponse res = client.execute(get);
				ObjectMapper mapper = new ObjectMapper();
				String body = EntityUtils.toString(res.getEntity());
				JsonNode rootNode = mapper.readTree(body);
				JsonNode resNode = rootNode.get("response");
				amount = resNode.get("amount").asText();
			} catch (Exception e) {
				e.printStackTrace();
			}

			return amount;
		}
		
	    // 아임포트 결제금액 변조는 방지하는 함수
		public void setHackCheck(String amount,String mId,String token) {
			HttpClient client = HttpClientBuilder.create().build();
			HttpPost post = new HttpPost(IMPORT_PREPARE_URL);
			Map<String,String> m  =new HashMap<String,String>();
			post.setHeader("Authorization", token);
			m.put("amount", amount);
			m.put("merchant_uid", mId);
			try {
				post.setEntity(new UrlEncodedFormEntity(convertParameter(m)));
				HttpResponse res = client.execute(post);
				ObjectMapper mapper = new ObjectMapper();
				String body = EntityUtils.toString(res.getEntity());
				JsonNode rootNode = mapper.readTree(body);
				System.out.println(rootNode);
			} catch (Exception e) {
				e.printStackTrace();
			}	
		}

	/* 결제 목록으로 가는 컨트롤러 */
	@GetMapping("/orderList/{member_id}")
	public String orderList(OrderDTO order, Model model, HttpSession session) throws Exception {
		MemberVO member = (MemberVO) session.getAttribute("member");
		String userId = member.getId();
		order.setMember_id(userId);
		List<OrderDTO> orderList = orderService.orderList(order);

		model.addAttribute("orderList", orderList);

		return "/orderList";

	}

	/* 주문 목록 */
	@RequestMapping(value = "/orderList", method = RequestMethod.GET)
	public void getOrderList(HttpSession session, OrderDTO order, Model model) throws Exception {

		MemberVO member = (MemberVO) session.getAttribute("member");
		String userId = member.getId();

		order.setMember_id(userId);

		List<OrderDTO> orderList = orderService.orderList(order);

		model.addAttribute("orderList", orderList);
	}

	/* 주문 상세 목록 */
	@RequestMapping(value = "/orderView", method = RequestMethod.GET)
	public void getOrderList(HttpSession session, @RequestParam("n") String order_id, OrderDTO order, Model model)
			throws Exception {

		MemberVO member = (MemberVO) session.getAttribute("member");
		String userId = member.getId();

		order.setMember_id(userId);
		order.setOrder_id(order_id);

		List<OrderListVO> orderView = orderService.orderView(order);

		model.addAttribute("orderView", orderView);
	}

}
