# Shop
Model1 쇼핑몰 -> [바로가기](http://43.200.96.123/shop)
## ADMIN
### 1. 공지관리 - [NoticeService](https://github.com/gugu99/shop/blob/master/shop/src/main/java/service/NoticeService.java) / [NoticeDao](https://github.com/gugu99/shop/blob/master/shop/src/main/java/repository/NoticeDao.java)
  - Notice CRUD
    - adminNoticeList
    - addNoticeForm / addNoticeAction
    - modifyNoticeForm / modifyNoticeAction
    - removeNoticeAction
### 2. 고객관리 - [CustomerService](https://github.com/gugu99/shop/blob/master/shop/src/main/java/service/CustomerService.java) / [CustomerDao](https://github.com/gugu99/shop/blob/master/shop/src/main/java/repository/CustomerDao.java)
  - 고객 목록
    - customerList
    - adminCustomerOrders(특정 고객의 주문 목록)
  - 고객 삭제(강제 탈퇴) -> 알림 구현X
  - 비밀번호 수정 -> 알림 구현X
### 3. 사원관리 - [EmployeeService](https://github.com/gugu99/shop/blob/master/shop/src/main/java/service/EmployeeService.java) / [EmployeeDao](https://github.com/gugu99/shop/blob/master/shop/src/main/java/repository/EmployeeDao.java)
  - 사원 목록
    - employeeList
  - 사원 권한 변경
    - ModifyEmployeeActiveAction
### 4. 상품관리 - [GoodsService](https://github.com/gugu99/shop/blob/master/shop/src/main/java/service/GoodsService.java) / [GoodsDao](https://github.com/gugu99/shop/blob/master/shop/src/main/java/repository/GoodsDao.java) / [GoodsImgDao](https://github.com/gugu99/shop/blob/master/shop/src/main/java/repository/GoodsImgDao.java)
  - 상품 목록
    - adminGoodsList
  - 상품 상세
    - goodsAndImgOne
    - (+review)
  - 상품 & 이미지 입력
    - addGoodsForm
    - addGoodsAction
  - 상품 수정
    - modifyGoodsForm
    - modifyGoodsAction
### 5. 주문관리 - [OrdersService](https://github.com/gugu99/shop/blob/master/shop/src/main/java/service/OrdersService.java) / [OrdersDao](https://github.com/gugu99/shop/blob/master/shop/src/main/java/repository/OrdersDao.java)
  - 주문 목록
    - adminOrdersList
  - 주문 상세
    - adminOrdersOne
  - 주문 상태 변경
    - modifyOrderStateAction
## CUSTOMER
