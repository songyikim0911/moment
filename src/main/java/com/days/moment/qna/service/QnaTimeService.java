package com.days.moment.qna.service;

import org.springframework.transaction.annotation.Transactional;

@Transactional
public interface QnaTimeService {

    String getNow();
}
