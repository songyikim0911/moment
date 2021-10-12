package com.days.moment.miniboard.mapper;

import org.apache.ibatis.annotations.Select;

public interface MiniTimeMapper {

    @Select("select now()")
    String getTime();
    String getTime4();
}
