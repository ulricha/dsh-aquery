select max(running_diff)
from (select t_price - min(t_price) over
               (order by t_timestamp
                rows unbounded preceding)
               as running_diff
      from tradessmall
      where t_tid = 4 and t_tradedate = 2) as t1;
