package com.mall.mapper;

import com.mall.entity.CardKey;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CardKeyMapper {
    List<CardKey> findBySkuIdAndStatus(@Param("skuId") Integer skuId,
                                        @Param("status") Integer status,
                                        @Param("limit") int limit);
    CardKey findById(Integer id);
    List<CardKey> findByOrderItemId(Integer orderItemId);
    List<CardKey> findBySkuId(Integer skuId);
    int countBySkuIdAndStatus(@Param("skuId") Integer skuId, @Param("status") Integer status);
    int updateStatus(@Param("id") Integer id, @Param("status") Integer status,
                     @Param("orderItemId") Integer orderItemId);
    int batchUpdateStatus(@Param("ids") List<Integer> ids, @Param("status") Integer status,
                          @Param("orderItemId") Integer orderItemId, @Param("expectedStatus") Integer expectedStatus);
    int insert(CardKey cardKey);
    int countAll();
    List<CardKey> findAll(@Param("offset") int offset, @Param("limit") int limit);
    List<CardKey> findAllWithProduct(@Param("offset") int offset, @Param("limit") int limit);
}
