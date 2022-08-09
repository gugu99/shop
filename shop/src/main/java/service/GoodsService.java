package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import repository.GoodsDao;
import repository.GoodsImgDao;
import util.DBUtil;
import vo.Goods;
import vo.GoodsImg;

//트랜잭션 + action이나 dao가 해서는 안되는일
public class GoodsService {

	private DBUtil dbUtil;
	private GoodsDao goodsDao;
	private GoodsImgDao goodsImgDao;
	
	// 상품 수정하기
	public boolean modifyGoods(Goods paramGoods, GoodsImg paramGoodsImg) {
		
		Connection conn = null;
		dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false); // 자동 커밋을 막는다.
			
			goodsDao = new GoodsDao();
			if (goodsDao.updateGoods(conn, paramGoods) != 1) { // 상품 수정 실패시
				throw new Exception(); // 강제로 예외를 만든다.
			}
			
			goodsImgDao = new GoodsImgDao();
			if (goodsImgDao.updateGoodsImg(conn, paramGoodsImg) != 1) { // 상품 이미지 수정 실패시
				throw new Exception(); // 강제로 예외를 만든다.
			}
			
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			return false;
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		return true;
	}
	
	// 상품 품절 여부 수정
	public boolean modifyGoodsSoldOut(Goods paramGoods) {
		
		Connection conn = null;
		dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false); // 자동 커밋을 막는다.
			
			goodsDao = new GoodsDao();
			
			if (goodsDao.updateGoodsSoldOut(conn, paramGoods) != 1) { // 품절 여부 수정 실패시
				throw new Exception(); // 강제로 예외를 만든다.
			}
			
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			return false;
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		return true;
	}
	
	// 상품등록
	public int addGoods(Goods paramGoods, GoodsImg paramGoodsImg) {
		
		Connection conn = null;
		dbUtil = new DBUtil();
		int goodsNo = 0;
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			goodsDao = new GoodsDao();
			
			goodsNo = goodsDao.insertGoods(conn, paramGoods);
			if (goodsNo == 0) {
				throw new Exception(); // 이미지 입력 실패시 강제로 롤백(catch절 이동)
			}
			
			paramGoodsImg.setGoodsNo(goodsNo);
			goodsImgDao = new GoodsImgDao();
			if (goodsImgDao.insertGoodsImg(conn, paramGoodsImg) != 1) {
				goodsNo = 0;
				throw new Exception(); // 이미지 입력 실패시 강제로 롤백(catch절 이동)
			}
			
//			if (goodsNo != 0) {
//				paramGoodsImg.setGoodsNo(goodsNo);
//				goodsImgDao = new GoodsImgDao();
//				if (goodsImgDao.insertGoodsImg(conn, paramGoodsImg) == 0) {
//					goodsNo = 0;
//					throw new Exception(); // 이미지 입력 실패시 강제로 롤백(catch절 이동)
//				}
//			}
			
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		return goodsNo;
	}
	
	// goods 상세보기 페이지
	public Map<String, Object> getGoodsAndImgOne (int goodsNo) {
		
		Map<String, Object> map = null;
		Connection conn = null;
		dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			goodsDao = new GoodsDao();
			map = goodsDao.selectGoodsAndImgOne(conn, goodsNo);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		
		return map;
	}
	
	// goodsList.jsp에서 호출(상품리스트 라스트페이지 구하기)
	public int getGoodsListLastPage(int rowPerPage) {
		
		int lastPage = 0;
		Connection conn = null;
		dbUtil = new DBUtil();
		int totalRow = 0;
		
		try {
			conn = dbUtil.getConnection();
			goodsDao = new GoodsDao();
			totalRow = goodsDao.selectGoodsCount(conn);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		lastPage = (totalRow % rowPerPage != 0) ? (totalRow / rowPerPage)+1 : totalRow / rowPerPage;
		return lastPage;
	}
	
	// goodsList.jsp에서 호출(상품리스트)
	public List<Goods> getGoodsListByPage(int rowPerPage, int currentPage) {
		
		Connection conn = null;
		dbUtil = new DBUtil();
		List<Goods> list = null;
		
		int beginRow = (currentPage -1) * rowPerPage;
		
		try {
			conn = dbUtil.getConnection();
			goodsDao = new GoodsDao();
			list = goodsDao.selectGoodsListByPage(conn, rowPerPage, beginRow);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return list;
	}
}
