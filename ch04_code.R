# load library tidyverse
library(tidyverse)

# read_csv
sample_df <- read_csv("data/csv1.csv")
colnames(sample_df)[1] <- "no"
glimpse(sample_df)

#------------------------------------------
# seperate & unite
#------------------------------------------
df.1 <- sample_df %>% 
    separate(col = gu, 
             into = c("주소구분1", "주소구분2"),
             sep = " ",
             remove = FALSE)

df.1 %>% 
    unite(col = "full_address",
          `주소구분1`, `주소구분2`,
          sep = "-",
          remove = TRUE)

#------------------------------------------
# count
#------------------------------------------
sample_df %>% 
    count(category)

sample_df %>% 
    count(category, public)

sample_df %>% 
    count(category, public, sort = T)

sample_df %>% 
    count(category)

#------------------------------------------
# dplyr에서 select
# 필요없는 첫번째 열을 제거
#------------------------------------------
sample_df <- sample_df %>%
    select(-no, -code)
head(sample_df)

#------------------------------------------
# dplyr에서 filter
# 강남권에서 공립 중학교만 추출
#------------------------------------------
public <- sample_df %>% 
    filter(category == "강남권" & public == "공립")

public_gangnam <- public %>%
    filter(gu %in% c("서울특별시 송파구", "서울특별시 강남구", "서울특별시 서초구"))
head(public_gangnam)

#------------------------------------------
# dplyr에서 arrange
#------------------------------------------
sample_df %>% 
    arrange(value)

sample_df %>%
    arrange(desc(value))

sample_df %>% 
    arrange(category, desc(value))

#------------------------------------------
# dplyr에서 mutate
#------------------------------------------
sample_df %>% 
    mutate(message = paste0(school_name, "의 순유입은 ", value, "명 입니다")) %>% View()

sample_df %>% 
    mutate(avg = round((value / sum(value))*100, 2))

sample_df %>% 
    mutate(avg = paste0(round((value / sum(value))*100, 2), "%"))

#------------------------------------------
# dplyr에서 group_by & summarise
#------------------------------------------
sample_df %>%
    group_by(category) %>% 
    summarise(total = sum(value))

sample_df %>% 
    group_by(category) %>% 
    summarise(count = n())

sample_df %>%
    group_by(gu) %>% 
    summarise(total = sum(value)) %>% 
    arrange(desc(total))

sample_df %>%
    group_by(category, public) %>% 
    summarise(total = sum(value))

#----------------------------------------------------------------------
# 간단한 실습을 해봅시다!
# iris 데이터
#   1. Sepal(꽃받침)과 관련있는 column을 추출해서 df_Sepal 변수에 저장
#   2. Sepal.Length와 Petal.Length 모두 1.5 이상만 추출
#   3. Species(종)과 Petal.Width 순으로 내림차순 정렬
#   4. 새롭게 text 칼럼을 생성하고 Sepal.Length값을 활용해서 
#      "꽃받침 너비는 00입니다"라고 새롭게 만들어주세요
#   5. Species별 Sepal.Width의 평균값을 만들어보세요
#----------------------------------------------------------------------