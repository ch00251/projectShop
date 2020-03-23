package com.test.project01.order.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.project01.order.dto.OrdersDto;

@Repository
public class OrderDaoImpl implements OrderDao {
	@Autowired
	SqlSession session;

	@Override
	public List<OrdersDto> getOrderNum(String userId) {
		
		return session.selectList("order.getOrderNum",userId);
	}
	
	@Override
	public void insert(OrdersDto dto) {
		session.insert("order.insert",dto);
	}

	@Override
	public List<OrdersDto> orderInfo(OrdersDto dto) {
		
		return session.selectList("order.orderInfo",dto);
	}

	
	
}