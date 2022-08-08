<%@page import="vo.Goods"%>
<%@page import="service.GoodsService"%>
<%@page import="vo.GoodsImg"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 인코딩
	request.setCharacterEncoding("UTF-8");
	
	// 폴더 경로 지정
	String dir = request.getServletContext().getRealPath("/upload");
	// 최대사이즈
	int max = 10 * 1024 * 1024;
	MultipartRequest mRequest = new MultipartRequest(request, dir, max, "utf-8", new DefaultFileRenamePolicy());
	// 파라미터 goods_img
	String filename = mRequest.getParameter("filename");
	
	String originFilename = mRequest.getOriginalFileName("imgFile");
	String contentType = mRequest.getContentType("imgFile");
	String systemFilename = mRequest.getFilesystemName("imgFile");
	
	// 파라미터 goods
	String goodsName = mRequest.getParameter("goodsName");
	int goodsPrice = Integer.parseInt(mRequest.getParameter("goodsPrice"));
	String soldOut = mRequest.getParameter("soldOut");
	
	if(!(contentType.equals("image/gif") || contentType.equals("image/png") || contentType.equals("image/jpeg"))){
		// 이미지가 아닌 파일 삭제
		File f = new File(dir + "/" + systemFilename);
		
		if(f.exists()){
			f.delete(); // return boolean
		}
		
		response.sendRedirect(request.getContextPath()+"/admin/addGoodsForm.jsp");
		return;
	}
	
	// 디버깅
	System.out.println("goodsName --- " + goodsName);
	System.out.println("goodsPrice --- " + goodsPrice);
	System.out.println("soldOut --- " + soldOut);
	
	System.out.println("filename --- " + filename);
	System.out.println("originFilename --- " + originFilename);
	System.out.println("contentType --- " + contentType);
	System.out.println("systemFilename --- " + systemFilename);
	
	// goods
	Goods goods = new Goods();
	goods.setGoodsName(goodsName);
	goods.setGoodsPrice(goodsPrice);
	goods.setSoldeOut(soldOut);
	
	// goods_img
	GoodsImg goodsImg = new GoodsImg();
	goodsImg.setFilename(filename);
	goodsImg.setOriginFilename(originFilename);
	goodsImg.setContentType(contentType);
	goodsImg.setSystemFilename(systemFilename);
	
	GoodsService goodsService = new GoodsService();
	
	boolean add = goodsService.addGoods(goods, goodsImg);
	
	if (!add) {
		System.out.println("상품 등록 실패!");
		
		File f = new File(dir + "/" + systemFilename);
		
		if(f.exists()){ // 상품 등록 실패시 이미지 업로드 됐으면 삭제
			f.delete(); // return boolean
		}
		response.sendRedirect(request.getContextPath()+"/admin/addGoodsForm.jsp");
		return; // 상품 등록 실패시 리턴
	}
	
	System.out.println("상품 등록 성공!");
	response.sendRedirect(request.getContextPath()+"/admin/adminGoodsList.jsp");
%>