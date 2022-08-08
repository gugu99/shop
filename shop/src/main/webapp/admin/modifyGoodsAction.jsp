<%@page import="service.GoodsService"%>
<%@page import="vo.GoodsImg"%>
<%@page import="vo.Goods"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	System.out.println("\n--------------------modifyGoodsAction.jsp");	

	if (session.getAttribute("user") == null || !((String)session.getAttribute("user")).equals("employee")) { // 로그인상태가 아닌경우 loginForm.jsp로 이동 -> 로그인상태지만 사원이 아닌경우 index.jsp로 이동
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	// 인코딩
	request.setCharacterEncoding("UTF-8");
	
	// 폴더 경로 지정
	String dir = request.getServletContext().getRealPath("/upload");
	// 최대사이즈
	int max = 10 * 1024 * 1024;
	MultipartRequest mRequest = new MultipartRequest(request, dir, max, "utf-8", new DefaultFileRenamePolicy());

	// 파라미터 goods
	int goodsNo = Integer.parseInt(mRequest.getParameter("goodsNo"));
	String goodsName = mRequest.getParameter("goodsName");
	int goodsPrice = Integer.parseInt(mRequest.getParameter("goodsPrice"));
	String soldOut = mRequest.getParameter("soldOut");
	
	// goods_img
	String preFilename = mRequest.getParameter("preFilename"); // 기존 파일이름
	String filename = mRequest.getFilesystemName("imgFile");
	String originFilename = mRequest.getOriginalFileName("imgFile");
	String contentType = mRequest.getContentType("imgFile");
	
	if(!(contentType.equals("image/gif") || contentType.equals("image/png") || contentType.equals("image/jpeg"))){
		// 이미지가 아닌 파일 삭제
		File f = new File(dir + "/" + filename);
		
		if(f.exists()){
			f.delete(); // return boolean
		}
		
		response.sendRedirect(request.getContextPath()+"/admin/modifyGoodsForm.jsp?goodsNo="+goodsNo);
		return;
	}
	
	// 디버깅
	System.out.println("goodsNo --- " + goodsNo);
	System.out.println("goodsName --- " + goodsName);
	System.out.println("goodsPrice --- " + goodsPrice);
	System.out.println("soldOut --- " + soldOut);
	
	System.out.println("preFilename --- " + preFilename);
	System.out.println("filename --- " + filename);
	System.out.println("originFilename --- " + originFilename);
	System.out.println("contentType --- " + contentType);
	
	// goods setter
	Goods goods = new Goods();
	goods.setGoodsNo(goodsNo);
	goods.setGoodsName(goodsName);
	goods.setGoodsPrice(goodsPrice);
	goods.setSoldOut(soldOut);
	
	// goods_img setter
	GoodsImg goodsImg = new GoodsImg();
	goodsImg.setGoodsNo(goodsNo);
	goodsImg.setFilename(filename);
	goodsImg.setOriginFilename(originFilename);
	goodsImg.setContentType(contentType);
	
	GoodsService goodsService = new GoodsService();
	
	boolean modify = goodsService.modifyGoods(goods, goodsImg);
	
	if (!modify) {
		System.out.println("상품 수정 실패!");
		File f = new File(dir + "/" + filename);
		
		if(f.exists()){ // 상품 수정 실패시 이미지 업로드 됐으면 삭제
			f.delete(); // return boolean
		}
		response.sendRedirect(request.getContextPath()+"/admin/modifyGoodsForm.jsp?goodsNo="+goodsNo);
		return; // 상품 수정 실패시 리턴
	}
	
	System.out.println("상품 수정 성공!");
	File f = new File(dir + "/" + preFilename);
	
	if(f.exists()){ // 상품 성공시 기존 이미지 파일 삭제
		f.delete(); // return boolean
	}
	response.sendRedirect(request.getContextPath()+"/admin/goodsAndImgOne.jsp?goodsNo="+goodsNo);
%>