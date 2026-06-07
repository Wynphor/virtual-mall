package com.mall.service;

import com.mall.entity.CardKey;
import java.util.List;

public interface CardKeyService {
    int getAvailableStock(Integer skuId);
    List<CardKey> allocateKeys(Integer skuId, int quantity, Integer orderItemId);
    List<CardKey> findByOrderItemId(Integer orderItemId);
    List<CardKey> findBySkuId(Integer skuId);
    boolean addCardKey(CardKey cardKey);
    boolean freezeKey(Integer id);
    boolean unfreezeKey(Integer id);
    List<CardKey> findAll(int page, int pageSize);
    List<CardKey> findAllWithProduct(int page, int pageSize);
    int countAll();
}
