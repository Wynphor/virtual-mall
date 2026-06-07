package com.mall.service.impl;

import com.mall.entity.CardKey;
import com.mall.mapper.CardKeyMapper;
import com.mall.service.CardKeyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class CardKeyServiceImpl implements CardKeyService {

    @Autowired
    private CardKeyMapper cardKeyMapper;

    @Override
    public int getAvailableStock(Integer skuId) {
        return cardKeyMapper.countBySkuIdAndStatus(skuId, CardKey.STATUS_UNSOLD);
    }

    @Override
    @Transactional
    public List<CardKey> allocateKeys(Integer skuId, int quantity, Integer orderItemId) {
        // 获取指定数量的未售卡密
        List<CardKey> available = cardKeyMapper.findBySkuIdAndStatus(
                skuId, CardKey.STATUS_UNSOLD, quantity);
        if (available.size() < quantity) {
            return available;
        }
        // 批量更新状态为已售
        List<Integer> ids = available.stream()
                .map(CardKey::getId)
                .collect(Collectors.toList());
        cardKeyMapper.batchUpdateStatus(ids, CardKey.STATUS_SOLD, orderItemId, CardKey.STATUS_UNSOLD);
        return available;
    }

    @Override
    public List<CardKey> findByOrderItemId(Integer orderItemId) {
        return cardKeyMapper.findByOrderItemId(orderItemId);
    }

    @Override
    public List<CardKey> findBySkuId(Integer skuId) {
        return cardKeyMapper.findBySkuId(skuId);
    }

    @Override
    public boolean addCardKey(CardKey cardKey) {
        cardKey.setStatus(CardKey.STATUS_UNSOLD);
        return cardKeyMapper.insert(cardKey) > 0;
    }

    @Override
    public boolean freezeKey(Integer id) {
        // 只允许冻结未售出的卡密，不允许冻结已售出的
        CardKey key = cardKeyMapper.findById(id);
        if (key == null || key.getStatus() != CardKey.STATUS_UNSOLD) {
            return false;
        }
        return cardKeyMapper.updateStatus(id, CardKey.STATUS_FROZEN, null) > 0;
    }

    @Override
    public boolean unfreezeKey(Integer id) {
        // 只允许解冻已冻结的卡密，不允许解冻已售出的
        CardKey key = cardKeyMapper.findById(id);
        if (key == null || key.getStatus() != CardKey.STATUS_FROZEN) {
            return false;
        }
        return cardKeyMapper.updateStatus(id, CardKey.STATUS_UNSOLD, null) > 0;
    }

    @Override
    public List<CardKey> findAll(int page, int pageSize) {
        return cardKeyMapper.findAll((page - 1) * pageSize, pageSize);
    }

    @Override
    public List<CardKey> findAllWithProduct(int page, int pageSize) {
        return cardKeyMapper.findAllWithProduct((page - 1) * pageSize, pageSize);
    }

    @Override
    public int countAll() {
        return cardKeyMapper.countAll();
    }
}
