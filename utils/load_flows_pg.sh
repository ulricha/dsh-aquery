drop table packets;
create table packets(p_pid int not null, p_src int not null, p_dest int not null, p_len int not null, p_ts int not null);
copy packets from '/home/au/work/dev/Alex.NestedQueries/aquery/packets.csv' csv;
alter table packets add primary key (p_pid);
analyze;
