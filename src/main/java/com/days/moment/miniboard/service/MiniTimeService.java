package com.days.moment.miniboard.service;

import org.springframework.transaction.annotation.Transactional;

@Transactional
public interface MiniTimeService {

    String getNow();
}
