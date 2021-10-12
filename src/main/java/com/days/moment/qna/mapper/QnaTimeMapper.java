package com.days.moment.qna.mapper;

import org.apache.ibatis.annotations.Select;

public interface QnaTimeMapper {

    @Select("select now()")
    String getTime();
    String getTime3();
}
